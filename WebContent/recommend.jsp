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

%>

<h2> 신규 고객 상품 추천 서비스!</h2>
<h4> 가장 인기있는 세 품목을 홍보합니다!</h4>

<br>
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
	String query = "select product_id from included group by product_id order by sum(included_num) desc;";

	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	String product_id;
	int included_num;
	
	String r1,r2,r3;
	String n1,n2,n3;
	
	rs.next();

	r1 = rs.getString(1);
	rs.next();

	r2 = rs.getString(1);
	rs.next();

	r3 = rs.getString(1);

	query = "select name from item where product_id = '"+r1+"'";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	rs.next();
	
	n1 = rs.getString(1);	
	
	out.println("<h4>구매율 1등 상품 : " + n1+ "</h4>");
	
	out.println("<br>");
	
	query = "select name from item where product_id = '"+r2+"'";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	rs.next();
	
	n2 = rs.getString(1);	
	
	out.println("<h4>구매율 2등 상품: " + n2+ "</h4>");
		
	out.println("<br>");

	
	query = "select name from item where product_id = '"+r3+"'";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	rs.next();
	
	n3 = rs.getString(1);	
	
	out.println("<h4>구매율 3등 상품: " + n3+ "</h4>");
		
	out.println("<br>");

	query = "select name from item where product_id = '"+r1+"'";

		
%>


<%
	conn.close();
%>

</body>
</html>