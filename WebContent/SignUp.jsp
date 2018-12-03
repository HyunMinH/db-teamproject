<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2></h2>
<%
	String serverIP = "localhost";
	String portNum = "3306";
	String dbName = "comp322";
	String url = "jdbc:mysql://" +serverIP + ":" +portNum + "/"+ dbName;
	String user = "root";
	String pass = "1234qwer";
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, pass);
%>

<%
	
	
	String query = "select count(*) from customer where id = '"
	+ request.getParameter("new_id")
	+ "'";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	
	rs.next();
	if(rs.getString(1).equals("0"))
	{
		/* System.out.println(request.getParameter("new_id"));
		System.out.println(request.getParameter("new_password"));
		System.out.println(request.getParameter("new_first_name"));
		System.out.println(request.getParameter("new_last_name"));
		System.out.println(request.getParameter("new_address"));
		System.out.println(request.getParameter("new_age"));
		System.out.println(request.getParameter("new_job"));
		System.out.println(request.getParameter("new_sex"));
		System.out.println(request.getParameter("new_phone_number"));
		System.out.println(request.getParameter("new_email")); */
		
		Member m = new Member();
		
		
		m.id = request.getParameter("new_id");
		m.password = request.getParameter("new_password");
		m.first_name = request.getParameter("new_first_name");
		m.last_name = request.getParameter("new_last_name");
		m.address = request.getParameter("new_address");
		m.age = request.getParameter("new_age");
 		m.job = request.getParameter("new_job");
		m.sex = request.getParameter("new_phone_number");
		m.email = request.getParameter("new_email");
		
		
	}
	else
	{
		out.println(rs.getString(1));
		out.println("That id exists. Please use another id");
	}
	
	
	
	pstmt.close();
%>


<%
	conn.close();
%>

</body>
</html>