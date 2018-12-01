<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

	String serverIP = "localhost";
	String portNum = "3306";
	String dbName = "comp322";
	String url = "jdbc:mysql://" +serverIP + ":" +portNum + "/" + dbName;
	String user = "root";
	String pass = "1234qwer";
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, pass);
%>

<%
	String id = request.getParameter("id");
	String idQ = "select password from customer where id = "
			+"'" + id + "'";
	
	boolean loginSuccess = false;

	pstmt = conn.prepareStatement(idQ);
	rs = pstmt.executeQuery();
	
	rs.next();
	
	String password = rs.getString(1);
	
	if(password.equals(request.getParameter("pw")))
	{
		loginSuccess = true;
	}
	
	if(loginSuccess == true)
	{
		out.println("Login succedded");
		response.sendRedirect("example.jsp?id=" + id);
	}
	
	else
	{
		out.println("Login failed");
		
		out.println(rs);
		out.println("rs: "+rs);
		
		out.println("id: "+id);
		out.println("pw: "+password);
		
	}
	
	
	
%>

	

 %>
</body>
</html>