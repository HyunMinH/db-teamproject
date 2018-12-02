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
 	<h2>메인 페이지</h2>
 	<br>
 <%
 	String user_id = "id84";
 	out.println("<button action=\"redirectNextPage(\"order_history.jsp\"," + user_id + ");" + "\">" + "구매내역" + "</button>");
 	out.println("<button action=\"redirectNextPage(\"shopping_bag.jsp\"," + user_id + ");" + "\">" + "장바구니" + "</button>");
 	out.println("<button action=\"redirectNextPage(\"edit_info.jsp\"," + user_id + ");" + "\">" + "정보 수정" + "</button>");
 	out.println("<button action=\"redirectNextPage(\"recommend.jsp\"," + user_id + ");" + "\">" + "추천상품" + "</button>");

 %>
 	<br>
 
 <script>
 function redirectNextPage(path, user_id){
	 response.redirect(path+"?user_id="+user_id);
 }
 </script>

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