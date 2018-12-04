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
 	out.println("<h2>" + request.getParameter("user_id") + " 의 장바구니 </h2>");
 	
 %>


<%

	String query = "select name, item_num, price"
		+ " from (shopping_bag natural join contained) natural join item"
		+ " where user_id='" + request.getParameter("user_id") + "'";

	

	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	
	out.println("<th>"+ "  상품 이름  " +"</th>");
	out.println("<th>"+ "  구매 갯수  " +"</th>");
	out.println("<th>"+ "  개당 가격  " +"</th>");
	
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>");
		out.println("</tr>");
	}
	
	out.println("</table>");
	
	out.println("<form action=\"order.jsp?" + request.getParameter("user_id") + "\" action=\"POST\" />");
	out.println("<input type=\"submit\" value=\"구입하기\"/>");
	out.println("</form>");
	
	pstmt.close();
	
	
%>

<%
	
%>

<%
	conn.close();
%>

</body>
</html>