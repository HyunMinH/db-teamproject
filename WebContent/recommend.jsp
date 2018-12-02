<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
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
 	out.println("<h2>" + request.getParameter("user_name") + " 에게 상품을 추천합니다.  </h2>");
 	
 %>


<%
/*
	String query = "select * "
		+ " from retailer"
		+ " where name='" + request.getParameter("retailer_name") + "'";

	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	rs.next();
	String retailer_id = rs.getString(3);
	pstmt.close();
	*/
	
%>

<% 
	
	
%>


<%
	conn.close();
%>

</body>
</html>