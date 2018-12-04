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
 	out.println("<h2>" + (String)session.getAttribute("id") + " 의 장바구니 </h2>");
 	
 %>
<form action="MainPage.jsp" method="post">
		<input type="submit" value="메인으로 가기"/>
	</form>
<form action="shopping_bag_delete.jsp" method="POST" >
<%

	String query = "select name, item_num, price, product_id"
		+ " from (shopping_bag natural join contained) natural join item"
		+ " where user_id='" + (String)session.getAttribute("id") + "'";

	

	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	
	out.println("<th>"+ "  상품 이름  " +"</th>");
	out.println("<th>"+ "  구매 갯수  " +"</th>");
	out.println("<th>"+ "  개당 가격  " +"</th>");
	out.println("<th>"+ " 삭제 " + "</th>");
	
	String product_list = "";
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>");
		product_list += "&product_" + rs.getString(4) + "=" + rs.getString(2);
		out.println("<td>" + "<input type=\"submit\"" + "name=\"submit\" + value=\"delete_" + rs.getString(4) +  "\"/>" + "</td>");
		out.println("</tr>");
	}
	
	out.println("</table>");
	
	
	System.out.println(product_list);
	
	pstmt.close();
	
	
%>
</form>
<%
	query = "select address"
		+ " from customer "
		+ " where id='" + (String)session.getAttribute("id") + "'";


	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	rs.next();
	String shipping_destination = rs.getString(1);
	
	pstmt.close();
%>

<form action="order.jsp?user_id=<%=(String)session.getAttribute("id")%><%=product_list%>&shipping_destination=<%=shipping_destination%>" method="POST">
	<input type="submit" value="구입하기"/>
</form>


<%
	
%>

<%
	conn.close();
%>

</body>
</html>