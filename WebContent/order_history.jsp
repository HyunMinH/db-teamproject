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
 	out.println("<h2>" + (String)session.getAttribute("id") + " 구매 이력  </h2>");
 	
 %>

<%

	String query = "select item.name, shipping_destination, order_date, included_num, retailer.name, price, order_number "
		+ " from ((order_history natural join included) natural join order_into) natural join item, retailer"
		+ " where customer_id='" + (String)session.getAttribute("id") + "' and retailer.retailer_id = order_into.retailer_id";


	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	
	
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	
	String temp ="";
	boolean first = true;
	
	while(rs.next())
	{

		String order_number = rs.getString(7);
		System.out.println(order_number);
		
		if(temp.equals(order_number) == false)
		{
			if(first == false)
				out.println("</table>");
			out.println("<br>");
			out.println("<table border=\"1\">");
			first = false;
		}
		
		out.println("<th>"+ "  배송 번호 " +"</th>");
		out.println("<th>"+ "  날짜  " +"</th>");
		out.println("<th>"+ "  상품 이름  " +"</th>");
		out.println("<th>"+ "  구매 갯수  " +"</th>");
		out.println("<th>"+ "  개당 가격  " +"</th>");
		out.println("<th>"+ " 배달 매장 이름  " +"</th>");
		out.println("<th>"+ "  배송 도착지 " +"</th>");
			
			out.println("<tr>");

		out.println("<td>"+rs.getString(7)+"</td>"); // 주문일자 
		out.println("<td>"+rs.getString(3)+"</td>"); // 주문일자 
		out.println("<td>"+rs.getString(1)+"</td>"); // 상품 이름 
		out.println("<td>"+rs.getString(4)+"</td>"); // 갯수 
		out.println("<td>"+rs.getString(6)+"</td>"); // 가격 
		out.println("<td>"+rs.getString(5)+"</td>"); // 배달 매장 이름 
		out.println("<td>"+rs.getString(2)+"</td>"); // 배송 도착지 
			
			
		out.println("</tr>");
			
		
		temp = order_number;
	}
	
	
	
	pstmt.close();
	
	
%>

<% 
	
	
%>


<%
	conn.close();
%>

</body>
</html>