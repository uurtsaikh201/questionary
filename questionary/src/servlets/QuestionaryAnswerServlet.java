package servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Host;
import com.datastax.driver.core.Metadata;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.Session;

/**
 * Servlet implementation class QuestionaryAnswerServlet
 */
@WebServlet("/QuestionaryAnswerServlet")
public class QuestionaryAnswerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	private String filePath = "d:\\temp";
	private int maxFileSize = 50 * 1024;
	private File file;

	public QuestionaryAnswerServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		Map<Integer, QuestionTO> questionMap = (Map<Integer, QuestionTO>) request.getSession()
				.getAttribute("questionMap");

		String fileName = null;
		if (isMultipart) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setRepository(new File("D:\\temp"));

			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(maxFileSize);
			InputStream inputStream = null;
			try {
				List fileItems = upload.parseRequest(request);
				Iterator i = fileItems.iterator();
				Integer questionId = 0;
				FileItem fi = null;
				String userAnswer="";
				while (i.hasNext()) {
					fi = (FileItem) i.next();
					
					System.out.println("i:" + fi.getContentType() + " " + fi.getFieldName() + " " + fi.getName()+" "+fi);
					if (!fi.isFormField()) {

						fileName = fi.getName();
						if (fileName.lastIndexOf("\\") >= 0) {
							file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\")));
						} else {
							file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1));
						}
						System.out.println("filename:" + file.getName() + " " + fileName);
						inputStream = fi.getInputStream();
						fi.write(file);
					} else {
						if (fi.getFieldName().equals("selectedQuestion")) {
							System.out.println("selectedQuestion:" + fi.getString());
							questionId = new Integer(fi.getString());
						}else if (fi.getFieldName().equals("rating")) {
							System.out.println("rating value:"+fi.getString());
							userAnswer=fi.getString();
						}else if (fi.getFieldName().equals("answerChoice")) {
							System.out.println("answerChoice TEST:" +fi.getString());
							userAnswer=fi.getString();
						}
					}
				}
				QuestionTO questionTO = questionMap.get(questionId);
				connect("10.81.4.37");
				Session dbSession = cluster.newSession();
				InputStream fis;

				SimpleDateFormat parser = new SimpleDateFormat("dd-MM-yyyy");
				try {

					String email = request.getSession().getAttribute("email").toString();
					String fname = request.getSession().getAttribute("fname").toString();
					String lname = request.getSession().getAttribute("lname").toString();
					Long phone = 0L;
					try {
						if (request.getSession().getAttribute("phone") != null) {
							phone = new Long(request.getSession().getAttribute("phone").toString());
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					if (inputStream != null) {
						fis = inputStream;

						byte[] b = new byte[fis.available() + 1];
						fis.read(b);
						ByteBuffer buffer = ByteBuffer.wrap(b);
						PreparedStatement ps = dbSession.prepare("insert into test_keyspace.question_answer " + "( "
								+ "id," + "" + "answer_file,answer_file_name,q_description,"
								+ "q_expire_date,q_options,q_title," + "q_type,question_id,u_email"
								+ ",u_fname,u_lname,u_phone)" + " values(now()," + "?,?,?," + "?,?,?," + "?,?,?,"
								+ "?,?,?)");

						BoundStatement boundStatement = new BoundStatement(ps);
						String options = "";
						if (questionTO.getOptions() != null) {
							for (String option : questionTO.getOptions()) {
								options += "'" + option + "',";
							}
							options = options.substring(0, options.length() - 1);
							System.out.println("options:" + options);
						}

						dbSession.execute(boundStatement.bind(buffer, fileName, questionTO.getDescription(),
								parser.parse(questionTO.getExpireDate()), options, questionTO.getTitle(),
								questionTO.getType(), questionId, email, fname, lname,
								new java.math.BigDecimal(phone)));
					}else {
						PreparedStatement ps = dbSession.prepare("insert into test_keyspace.question_answer " + "( "
								+ "id," + "" + "answer_text,q_description,"
								+ "q_expire_date,q_options,q_title," + "q_type,question_id,u_email"
								+ ",u_fname,u_lname,u_phone)" + " values(now()," + "?,?," + "?,?,?," + "?,?,?,"
								+ "?,?,?)");

						BoundStatement boundStatement = new BoundStatement(ps);
						String options = "";
						if (questionTO.getOptions() != null) {
							for (String option : questionTO.getOptions()) {
								options += "'" + option + "',";
							}
							options = options.substring(0, options.length() - 1);
							System.out.println("options:" + options);
						}

						dbSession.execute(boundStatement.bind( userAnswer, questionTO.getDescription(),
								parser.parse(questionTO.getExpireDate()), options, questionTO.getTitle(),
								questionTO.getType(), questionId, email, fname, lname,
								new java.math.BigDecimal(phone)));
					}
				} catch (Exception e) {
					
					e.printStackTrace();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} else {
			Integer questionId = new Integer(request.getParameter("selectedQuestion").toString());

		}
		response.sendRedirect("index.jsp");
	}

	public Cluster cluster;

	public void connect(String node) {
		cluster = Cluster.builder().addContactPoint(node).build();
		Metadata metadata = cluster.getMetadata();
		System.out.printf("Connected to cluster: %s\n", metadata.getClusterName());
		for (Host host : metadata.getAllHosts()) {
			System.out.printf("Datatacenter: %s; Host: %s; Rack: %s\n", host.getDatacenter(), host.getAddress(),
					host.getRack());
		}
	}

	public void close() {
		cluster.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
