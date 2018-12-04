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
 	int numOfProduct = Integer.parseInt(request.getParameter("num"));
	
	System.out.println(numOfProduct);
	
	String user_id = (String)session.getAttribute("id");
	String query;
	
	String product_id = request.getParameter("product_id"); //여기에 product id를 받아 옵니다!
	
	query = "select product_id from contained where user_id = '"+user_id+"'";
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	int i = 1;
	
	boolean newProduct = true;
	
	while(rs.next())
	{
		if(rs.getString(1).equals(product_id))
		{
			newProduct = false;
			System.out.println("here!!!!!!" +rs.getString(1));
			break;
		}
		
		i++;
	}
	
	
	if(newProduct == true)
	{
		query = "insert into contained VALUES('"
				+user_id
				+"', '"
				+product_id
				+"', "
				+numOfProduct
				+")";
	}
	
	else
	{
		query = "select item_num from contained where user_id = '"+ user_id +"' and product_id = '"+product_id+"';";
		
		System.out.println(query);
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		
		rs.next();
		//numOfProduct += Integer.parseInt(rs.getString(1));
		
		query = "update contained set item_num = item_num + "+ numOfProduct + " where product_id = '"+product_id+"' and user_id = '"+user_id+"';";
	}
	
	
	System.out.println(query);
	
	pstmt = conn.prepareStatement(query);
	pstmt.executeUpdate();

	response.sendRedirect("ShoppingbagSuccess.jsp");
%>





