package servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;

import com.google.gson.Gson;

/**
 * Servlet implementation class QuestionServlet
 */
@WebServlet("/QuestionServlet")
public class QuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QuestionServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getParameter("action") != null) {
			if (request.getParameter("action").equals("delete")) {
				try {
					String url = "http://mgl.usask.ca:8080/question/api/questions/delete/";
					String deleteId = request.getParameter("id");
					URL obj = new URL(url + deleteId);
					HttpURLConnection con = (HttpURLConnection) obj.openConnection();

					// optional default is GET
					con.setRequestMethod("GET");

					// add request header
					String USER_AGENT = "Mozilla/5.0";
					con.setRequestProperty("User-Agent", USER_AGENT);

					int responseCode = con.getResponseCode();
					System.out.println("\nSending 'GET' request to URL : " + url);
					System.out.println("Response Code : " + responseCode);

					BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
					String inputLine;
					StringBuffer responseString = new StringBuffer();

				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (request.getParameter("action").equals("create")) {
				try {
					String title = request.getParameter("title");
					String description = request.getParameter("description");

					String options = request.getParameter("options");

					String questionType = request.getParameter("questiontype");
					Question question=new Question();
					question.setExpireDate(request.getParameter("expiredate"));
					question.setDescription(description);
					question.setOptions(options);
					question.setQuestionType(new Integer(questionType));
					question.setTitle(title);
					Gson gson = new Gson();
					
					String json = gson.toJson(question);
					CloseableHttpClient httpClient = HttpClientBuilder.create().build();

					String inputLine;
					StringBuffer postResponse = new StringBuffer();

					HttpPost postRequest = new HttpPost("http://mgl.usask.ca:8080/question/api/questions");
					StringEntity params = new StringEntity(json.toString());
					System.out.println("json:" + json);
					postRequest.addHeader("content-type", "application/json");

					postRequest.setEntity(params);

					HttpResponse httpResponse = httpClient.execute(postRequest);
					if (httpResponse.getStatusLine().getStatusCode() == 200) {
						BufferedReader in = new BufferedReader(
								new InputStreamReader(httpResponse.getEntity().getContent()));

						while ((inputLine = in.readLine()) != null) {
							postResponse.append(inputLine);
						}
						System.out.println("postResponse:"+postResponse);
						
					} else {
						System.out.println(
								"unsuccessfull request result code:" + httpResponse.getStatusLine().getStatusCode());
					//	request.getRequestDispatcher("/signin.jsp").forward(request, response);
					}

				} catch (Exception ex)
				

				{
					ex.printStackTrace();
				}
			}else if (request.getParameter("action").equals("update")) {
				try {
					System.out.println("updating...");
					String title = request.getParameter("title");
					String description = request.getParameter("description");

					String options = request.getParameter("options");

					String questionType = request.getParameter("questiontype");
					Question question=new Question();
					question.setExpireDate(request.getParameter("expiredate"));
					question.setDescription(description);
					question.setOptions(options);
					question.setQuestionType(new Integer(questionType));
					question.setTitle(title);
					Gson gson = new Gson();
					
					String json = gson.toJson(question);
					CloseableHttpClient httpClient = HttpClientBuilder.create().build();

					String inputLine;
					StringBuffer postResponse = new StringBuffer();
					System.out.println("request:"+"http://mgl.usask.ca:8080/question/api/questions/"+request.getParameter("id"));
					HttpPut postRequest = new HttpPut("http://mgl.usask.ca:8080/question/api/questions/"+request.getParameter("id"));
					StringEntity params = new StringEntity(json.toString());
					System.out.println("json:" + json);
					postRequest.addHeader("content-type", "application/json");

					postRequest.setEntity(params);

					HttpResponse httpResponse = httpClient.execute(postRequest);
					if (httpResponse.getStatusLine().getStatusCode() == 200) {
						BufferedReader in = new BufferedReader(
								new InputStreamReader(httpResponse.getEntity().getContent()));

						while ((inputLine = in.readLine()) != null) {
							postResponse.append(inputLine);
						}
						System.out.println("postResponse:"+postResponse);
						//request.getRequestDispatcher("/index.jsp").forward(request, response);
					} else {
						System.out.println(
								"unsuccessfull request result code:" + httpResponse.getStatusLine().getStatusCode());
					//	request.getRequestDispatcher("/signin.jsp").forward(request, response);
					}

				} catch (Exception ex)

				{
					ex.printStackTrace();
				}
			}
		}
		
		response.sendRedirect("index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	/**
	 * @see HttpServlet#doDelete(HttpServletRequest, HttpServletResponse)
	 */
	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
