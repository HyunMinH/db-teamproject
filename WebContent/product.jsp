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

 	<h2>상품 구매</h2>
 	<br>

<%
	String query = "SELECT * "
		+ " from category "
	+ " where large_category='" + request.getParameter("large_category")  + "'"
	+ " and middle_category='" + request.getParameter("middle_category") + "'";

	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	rs.next();
	String category_id = rs.getString(1);
%>

<%
	query = "SELECT * "
		+ " from category "
	+ " where large_category='" + request.getParameter("large_category")  + "'"
	+ " and small_category='" + request.getParameter("small_category") + "'";
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	out.println("<form action = \"add_product.jsp\" method=\"POST\">");
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	
	out.println("<th>"+ "  이름  " +"</th>");
	out.println("<th>"+ "  재고  " +"</th>");
	out.println("<th>"+ "  재고 증가량  " +"</th>");
	
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(5)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>");
		out.println("<td>" + "<input type=\"text\"" + "name=\"" + rs.getString(1) +  "\"" + "/>" + "</td>");
		out.println("</tr>");
	}
	
	out.println("</table>");
	
	out.println("</form>");
	pstmt.close();
%>


<%
	conn.close();
%>

</body>
</html>