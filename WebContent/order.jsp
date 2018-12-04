<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.util.Date" %>
<%@ page language="java" import="java.util.Map" %>
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
 	out.println("<h2>" + " 구매하기~ </h2>");
 	
 %>


<%

	/*	주문할 상품의 id와 갯수를 저장 	*/
	HashMap<String, String> product_list = new HashMap<String,String>();

	Enumeration<String> enumer = request.getParameterNames();
	while(enumer.hasMoreElements()){
		String key = enumer.nextElement();
		
		/*	주문할 아이템에 관련된 attribute이면		*/
		if(key.contains("product_")){
			String product_id = key.substring(key.indexOf("product_") + "product_".length());
			String product_num = request.getParameter(key);
			product_list.put(product_id, product_num);
		}
	}
	
	
	
	
	/*	마지막 order_number를 가져	*/
	String query = "select order_number"
			+ "from order_history order by cast(order_number as unsigned ) desc";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	rs.next();
	String last_order_number = rs.getString(1);
	
	pstmt.close();
	
	/*	order_history 생	성	*/
	query = "insert into order_history values('" +  request.getParameter("customer_id")
	+ "', '" + request.getParameter("shipping_destination") + "', '"
	+ new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + "', " 
	+ last_order_number + 1 + "')";

	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	pstmt.close();
	
	/*	address를 가지고 retailer의 id를 가져오기 	*/
	query = "select retailer_id from retailer where address='seoul'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	rs.next();
	String retailer_id = rs.getString(1);
	pstmt.close();
	
	
	/*	retailer의 stock들을 가져오기 	*/
	String product_list_str = "(";
	Iterator<String> iter = product_list.values().iterator();
	while(iter.hasNext()){
		product_list_str += "'" + iter.next() + "'";
		
		if(iter.hasNext())
			product_list_str += ',';
	}
	product_list_str += ")";
	
	System.out.println(product_list_str);
	
	query = "select stock from product_id, be_in_stock where retailer_id='" + retailer_id + "'"
			+ "and product id in " + product_list_str;
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	HashMap<String,String> retailer_product_list = new HashMap<String, String>();
	while(rs.next()){
		retailer_product_list.put(rs.getString(1), rs.getString(2));
	}
	pstmt.close();
	
	/*	stock들이 다 있는지 검사 	*/
	boolean can_buy = true;
	for(iter = product_list.values().iterator(); iter.hasNext();){
		String product_id = iter.next();
		int product_num = Integer.parseInt(product_list.get(product_id));
		int retailer_product_num = Integer.parseInt(retailer_product_list.get(product_id));
	
		if(product_num <= retailer_product_num){
			can_buy = false;
			return;
		}
	}
	
	/*	만약 구입할 수 없다면 있다면 	*/
%>

<%
	
%>

<%
	conn.close();
%>

</body>
</html>