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
 	out.println("<h2>" + request.getParameter("product_name") + " 상세 정보 </h2>");
 	
 	String user_id = (String)session.getAttribute("id");
 	
 	System.out.println(user_id);
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
	
	/*price 
	| product_id 
	| name      
	| weight 
	| sales_volume 
	| country_of_origin 
	| shelf_life 
	| calorie 
	| carbohydrate 
	| fat  
	| protein 
	| sugars 
	| saturated_fat 
	| trans_fat 
	| cholesterol 
	| category_id 
	| producer_id*/
	
	String query = "select * from item where name = '" + request.getParameter("product_name") + "';";
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	
	System.out.println("user id  ="  + user_id);
		
	rs.next();
	
	out.println("<h4>" +  "가격" +" : " + rs.getString(1)+"원" +   "<h4/>");
	out.println("<h4>" +  "등록번호"+" : " + rs.getString(2) + "<h4/>");
	out.println("<h4>" +  "제품명"+" : " + rs.getString(3)  + "<h4/>");
	out.println("<h4>" +  "중량"+" : " + rs.getString(4) +"g "+ "<h4/>");
	out.println("<h4>" +  "부피"+" : " + rs.getString(5)+"mL"  +"<h4/>");
	out.println("<h4>" + "원산지"+" : " + rs.getString(6)  + "<h4/>");
	out.println("<h4>" + "유통기한"+" : " + rs.getString(7)+"까지"  +"<h4/>");
	out.println("<h4>" + "칼로리"+" : " + rs.getString(8)+"kcal"  + "<h4/>");
	out.println("<h4>" + "탄수화물"+" : " + rs.getString(9) +"g"  + "<h4/>");
	out.println("<h4>" + "지방"+" : " + rs.getString(10) + "g" +"<h4/>");
	out.println("<h4>" + "단백질"+" : " + rs.getString(11)+ "g" + "<h4/>");
	out.println("<h4>" + "당류"+" : " + rs.getString(12)+ "g"  +"<h4/>");
	out.println("<h4>" + "포화지방"+" : " + rs.getString(13)+ "g"  + "<h4/>");
	out.println("<h4>" + "트랜스지방"+" : " + rs.getString(14) + "g" +"<h4/>");
	out.println("<h4>" + "콜레스테롤"+" : " + rs.getString(15) + "g" +"<h4/>");
	out.println("<h4>" + "카테고리"+" : " + rs.getString(16)+ " (대분류-소분류 순서)"  + "<h4/>" );
	out.println("<h4>" + "제조자"+" : " + rs.getString(17) + "<h4/>");

	String product_id = rs.getString(2);
	%>

	  
 		 <form action = "product_detail_handling.jsp?product_id=<%=product_id%>&user_id=<%=(String)session.getAttribute("id")%>" method="POST">
	 		<h2>주문수량을 선택하세요 </h2>
	
	  <h4>주문수량</h4>: <input type="number" name = "num" />
	 		<input type="submit" value = "확인" />
	 
	 	<br/>
	 </form>

	 <% 

	 %>

	 <%
	 	conn.close();
%>

</body>
</html>