<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

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
 
 
 <br>
 	
<%
	
	String query = "select large_category, count(*) "
		+ " from category group by large_category";

	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	out.println("<form action=\"category_small.jsp?user_id=" + (String)session.getAttribute("id") +"\" method=\"POST\">");
	out.println("Large Category : <select id=\"large_category\" name=\"large_category\">");
	
	out.print("<option value=\"default\">---selected---</option>");
	while(rs.next()){
		out.print("<option value=\"");
		out.print(rs.getString(1)+"\">");
		out.print(rs.getString(1));
		out.println("</option>  ");
	}
	out.println("</select>");
	out.println("<input type=\"submit\" value=\"검색\"/>");
	out.println("</form>");
	pstmt.close();
	
%>

<%
	conn.close();
%>

</body>
</html>