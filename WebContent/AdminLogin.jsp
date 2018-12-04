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
	
	boolean loginSuccess = false;

	String query = "select pw from admin where id = "
			+ "'" + id + "'";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	if(rs.next())
	{
		String input = rs.getString(1);
		
		if(input.equals(request.getParameter("pw")))
		{
			loginSuccess = true;
		}
		
		if(loginSuccess == true)
		{
			out.println("Admin login succedded");
			
			session.setAttribute("id", id);                 // 세션에 "id" 이름으로 id 등록
			response.sendRedirect("admin/index.html");              
		}
			
	}
	
	query = "select count(*) from admin where id = '"
			+ id
			+ "'";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	ResultSetMetaData rsmd = rs.getMetaData();
	
	rs.next();
	
	if(rs.getString(1).equals("0"))
	{
		out.println("<script>alert('There is no matching admin ID');</script>");
		
	}
	
	else
	{
		out.println("<script>alert('Please check admin password');</script>");
	}
%>
</body>
</html>