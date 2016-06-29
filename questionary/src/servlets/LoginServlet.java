package servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;

import com.google.gson.Gson;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("inputEmail");
		String password = request.getParameter("inputPassword");
		Gson gson = new Gson();
		LoginTO loginTO = new LoginTO();
		loginTO.setEmail(email);
		loginTO.setPassword(password);
		String json = gson.toJson(loginTO);
		CloseableHttpClient httpClient = HttpClientBuilder.create().build();
		try {

			String inputLine;
			StringBuffer postResponse = new StringBuffer();

			HttpPost postRequest = new HttpPost("http://mgl.usask.ca:8080/question/api/auth/login");
			StringEntity params = new StringEntity(json.toString());
			System.out.println("json:" + json);
			postRequest.addHeader("content-type", "application/json");

			postRequest.setEntity(params);

			HttpResponse httpResponse = httpClient.execute(postRequest);
			if (httpResponse.getStatusLine().getStatusCode() == 200) {
				BufferedReader in = new BufferedReader(new InputStreamReader(httpResponse.getEntity().getContent()));

				while ((inputLine = in.readLine()) != null) {
					postResponse.append(inputLine);
				}
				LoginResult loginResult = gson.fromJson(postResponse.toString(), LoginResult.class);
				System.out.println("login result token:" + loginResult.getToken());
				System.out.println("return result:" + postResponse);
				request.getSession().setAttribute("email", email);
				request.getSession().setAttribute("fname", loginResult.getFname());
				request.getSession().setAttribute("lname", loginResult.getLname());
				request.getSession().setAttribute("phone", loginResult.getPhone());
				
				System.out.println("redirect.....");
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			} else {
				System.out.println("unsuccessfull request result code:" + httpResponse.getStatusLine().getStatusCode());
				request.getRequestDispatcher("/signin.jsp").forward(request, response);
			}

		} catch (Exception ex)

		{
			ex.printStackTrace();
		} finally

		{
			httpClient.close();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
