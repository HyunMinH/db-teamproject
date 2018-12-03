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
 	out.println("<h2>" + request.getParameter("user_id") + " 회원 정보 수정  </h2>");
 	
 %>


<%

	String query = "select address"
		+ " from retailer group by retailer.address";

	

	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	out.println("<form action=\"edited.jsp\" method=\"POST\"");
	
	out.println("password : <input type=\"text\" name=\"pw\"/>");
	
	out.println("first_name : <input type=\"text\" name=\"first_name\"/>");
	
	out.println("last_name : <input type=\"text\" name=\"last_name\"/>");
	
	
	out.println("address : <select name=\"address\"");
	while(rs.next()){
		out.println("   <option value=\""+ rs.getString(1) +"\">"+ rs.getString(1) +"</option>");
	}
	out.println("</select>");
	
	out.println("age : <input type=\"text\" name=\"age\"/>");
	
	out.println("sex : <select name=\"sex\"/>");
	out.println("<option value=F>F</option>");
	out.println("<option value=M>M</option>");
	out.println("</select>");
	
	out.println("phone_number : <input type=\"text\" name=\"phone_number\"/>");
	
	out.println("email : <input type=\"text\" name=\"email\"/>");
	
	out.println("<input type=\"submit\" value=\"수정하기\"");
	out.println("</form>");
	
	pstmt.close();
	
%>


<%
	conn.close();
%>

</body>
</html>