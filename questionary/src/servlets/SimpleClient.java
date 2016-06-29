package servlets;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Host;
import com.datastax.driver.core.Metadata;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;

public class SimpleClient {
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

	public static void main(String[] args) {
		SimpleClient client = new SimpleClient();
		client.connect("10.81.4.37");
		Session session = client.cluster.newSession();
		ResultSet results = session.execute("SELECT * FROM test_keyspace.questions");
		for (Row row : results) {
			List<String> options = row.getList("options", java.lang.String.class);
			System.out.println("options:" + options);
		}

		FileInputStream fis;
		try {
			fis = new FileInputStream("d://question_table.PNG");
			byte[] b = new byte[fis.available() + 1];
			int length = b.length;
			fis.read(b);
			ByteBuffer buffer = ByteBuffer.wrap(b);
			String id = UUID.randomUUID().toString();
			/*
			 * PreparedStatement ps = session.prepare(
			 * "insert into test_keyspace.question_answer " + "( " + "id," + ""
			 * + "answer_file,answer_file_name," +
			 * "q_description,q_expire_date,q_options," +
			 * "q_title,q_type,question_id" + ",u_email,u_fname,u_lname," +
			 * " u_phone)" + " values(now()," + "?,?,?," + "?,?,?," + "?,?,?," +
			 * "?,?)"); List<String> options=new ArrayList<String>();
			 * options.add("tom"); options.add("test"); BoundStatement
			 * boundStatement = new BoundStatement(ps);
			 * session.execute(boundStatement.bind(buffer,"test.jpg","desc", new
			 * Date(), options, "Title", "Image", 1, "uuj476@mail.usask.ca",
			 * "Uurtsaikh", "Jamsrandorj", new
			 * java.math.BigDecimal(3062504386L)));
			 */
			PreparedStatement ps = session.prepare("insert into test_keyspace.question_answer " + "( " + "id," + ""
					+ "answer_file,answer_file_name,q_description,"
					+ "q_expire_date,q_options,q_title,"
					+ "q_type,question_id,u_email"
					+ ",u_fname,u_lname,u_phone)"
					+ " values(now(),"
					+ "?,?,?," + "?,?,?," + "?,?,?," + "?,?,?)");
			List<String> options = new ArrayList<String>();
			options.add("tom");
			options.add("test");
			BoundStatement boundStatement = new BoundStatement(ps);
			session.execute(boundStatement.bind(
					buffer, "test.jpg", "desc",
					new Date(), "test", "Title",
					"Image", 1,"uuj476@mail.usask.ca", 
					"Uurtsaikh", "Jamsrandorj", new java.math.BigDecimal(3062504386L)));

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		client.close();
	}
}