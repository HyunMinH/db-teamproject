<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>  </h2>
	<br>
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
	

	String product_id = request.getParameter("submit").substring("delete_".length());
	
	
	try{
		String query = "delete from contained where product_id='" + product_id + "'";
		System.out.println(query);
		
		pstmt = conn.prepareStatement(query);
		pstmt.executeUpdate();
		
		pstmt.close();
		response.sendRedirect("shopping_bag_success.jsp");
		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>


<%
	conn.close();
%>

</body>
</html>