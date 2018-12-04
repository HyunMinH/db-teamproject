<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="java.util.*" %>

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
 	out.println("<h2>" + (String)session.getAttribute("id") + " 회원 정보 수정  </h2>");
 	
 %>


<%

	String query = "update customer set ";
	boolean have_edit = false;
	
	Enumeration<String> parameter_names = request.getParameterNames();
	while(parameter_names.hasMoreElements()){
		String key = parameter_names.nextElement();
		
		/*	수정할 user 아이템에 관련된 attribute이면		*/
		if(key.contains("user_") && key.equals((String)session.getAttribute("id")) == false){
			System.out.println(key);
			String attr_name = key.substring("user_".length());
			String attr_value = request.getParameter(key);
			
			if(attr_value.equals("") == false){
				query += attr_name + "='" + attr_value + "',";
				have_edit = true;
			}
		}
	}
	
	if(have_edit == false){
		response.sendRedirect("edit_fail.jsp");
	}
	
	
	query = query.substring(0, query.length()-1) + " where id='" + (String)session.getAttribute("id") + "'";
	System.out.println(query);
	
	

	try{
		pstmt = conn.prepareStatement(query);
		pstmt.executeUpdate();
		
		pstmt.close();
		response.sendRedirect("edit_success.jsp");
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>


<%
	conn.close();
%>

</body>
</html>