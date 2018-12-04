<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

	String serverIP = "localhost";
	String portNum = "3306";
	String dbName = "comp322";
	String url = "jdbc:mysql://" +serverIP + ":" +portNum + "/" + dbName;
	String user = "root";
	String pass = "1234qwer";
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, pass);
%>

<%
	String id = request.getParameter("id");
	String idQ = "select password from customer where id = "
			+"'" + id + "'";
	
	boolean loginSuccess = false;

	pstmt = conn.prepareStatement(idQ);
	rs = pstmt.executeQuery();
	
	if (rs.next())
	{
		
		String password = rs.getString(1);
		
		if(password.equals("admin") &&id.equals("admin"))
		{
			response.sendRedirect("index.jsp");
		}
		
		if(password.equals(request.getParameter("pw")))
		{
			loginSuccess = true;
		}
		
		
		if(loginSuccess == true)
		{
			out.println("Login succedded");
/* 			response.sendRedirect("MainPage.jsp?id=" + id);
 */			
			session.setAttribute("id", id);                 // 세션에 "id" 이름으로 id 등록
			response.sendRedirect("MainPage.jsp");               // 로그인 성공 메인페이지 이동
			
		}
	}
	
	String query = "select count(*) from customer where id = '"
			+ id
			+ "'";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	ResultSetMetaData rsmd = rs.getMetaData();
	
	rs.next();
	
	if(rs.getString(1).equals("0"))
	{
		out.println("<script>alert('There is no matching ID');</script>");
		
	}
	
	else
	{
		out.println("<script>alert('Please check your password');</script>");
	}

%>

<%

%>
</body>
</html>