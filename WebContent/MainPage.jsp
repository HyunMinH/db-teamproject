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
 <script>
 function redirectNextPage(action, user_id){
	 if(action == 1){
		document.form1.action = "order_history.jsp?user_id=" + user_id;
	 }else if(action == 2){
		 document.form1.action = "shopping_bag.jsp?user_id=" + user_id;
	 }else if(action == 3){
		 document.form1.action = "edit_info.jsp?user_id=" + user_id;
	 }else if(action == 4){
		 document.form1.action = "recommend.jsp?user_id=" + user_id;
	 }
	 
	 document.form1.submit();
 }
 </script>
 	<h2>메인 페이지</h2>
 	<br>
 <%
 	String user_id = "id84";
 
 	out.println("<form name=\"form1\" method=\"POST\">");
 	out.println("<input type=\"button\" value=\"구매내역\" onclick=\"redirectNextPage(1,'" + user_id + "')\"/>");
 	out.println("<input type=\"button\" value=\"장바구니\" onclick=\"redirectNextPage(2,'" + user_id + "')\"/>");
 	out.println("<input type=\"button\" value=\"정보 수정\" onclick=\"redirectNextPage(3,'" + user_id + "')\"/>");
 	out.println("<input type=\"button\" value=\"추천상품\" onclick=\"redirectNextPage(4,'" + user_id + "')\"/>");
 	out.println("</form>");

 %>
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
	
	
%>


<%
	conn.close();
%>

</body>
</html>