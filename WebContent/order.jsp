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
	conn.setAutoCommit(false);
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
			
			System.out.println(product_id + " : " + product_num);
		}
	}
	
	
	
	/*	마지막 order_number를 가져	*/
	String query = "select order_number"
			+ " from order_history order by cast(order_number as unsigned ) desc";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	rs.next();
	String last_order_number = rs.getString(1);
	
	pstmt.close();
	
	/*	address를 가지고 retailer의 id를 가져오기 	*/
	query = "select retailer_id from retailer where address='" + request.getParameter("shipping_destination") + "'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	rs.next();
	String retailer_id = rs.getString(1);
	pstmt.close();
	
	
	/*	retailer의 stock들을 가져오기 	*/
	String product_list_str = "(";
	Iterator<String> iter = product_list.keySet().iterator();
	while(iter.hasNext()){
		product_list_str += "'" + iter.next() + "'";
		
		if(iter.hasNext())
			product_list_str += ',';
	}
	product_list_str += ")";
	
	System.out.println(product_list_str);
	
	HashMap<String,String> retailer_product_list = new HashMap<String, String>();
	try{
		if(product_list_str.equals("()") == false){
			query = "select product_id, stock from be_in_stock where retailer_id='" + retailer_id + "'"
					+ " and product_id in " + product_list_str;
			System.out.println(query);
			
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
	
			while(rs.next()){
				retailer_product_list.put(rs.getString(1), rs.getString(2));
			}
			pstmt.close();
		}
	}
	catch(SQLException e){
		conn.close();
		e.printStackTrace();
	}
	
	/*	stock들이 다 있는지 검사 	*/
	boolean can_buy = true;
	if(product_list.keySet().size() == 0)
		can_buy = false;
	for(iter = product_list.keySet().iterator(); iter.hasNext();){
		String product_id = iter.next();
		System.out.println(product_id);
		int product_buy_num = Integer.parseInt(product_list.get(product_id));
		int retailer_product_num = -1;
		if(retailer_product_list.containsKey(product_id))
			retailer_product_num = Integer.parseInt(retailer_product_list.get(product_id));
	
		System.out.println(product_buy_num + " , " + retailer_product_num);
		if(product_buy_num >= retailer_product_num){
			can_buy = false;
			break;
		}
	}

	
	/*	만약 구입할 수 없다면 있다면 	*/
	try{
		if(can_buy == false){
			conn.close();
			response.sendRedirect("order_fail.jsp?user_id=" + request.getParameter("customer_id"));
		}else{
			/*	order_history 생	성	*/
			query = "insert into order_history values('" +  request.getParameter("user_id")
			+ "', '" + request.getParameter("shipping_destination") + "', '"
			+ new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + "', '" 
			+ (Integer.parseInt(last_order_number) + 1) + "')";
			System.out.println(query);
		
			pstmt = conn.prepareStatement(query);
			int rs_update = pstmt.executeUpdate(query);
			System.out.println(rs_update);
			
			conn.commit();
			pstmt.close();
			
			/*	order_into 생성  	*/
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.HOUR, 2);
				
			query = "insert into order_into values('" + (Integer.parseInt(last_order_number) + 1) + "', '" + retailer_id + "',' " + 
					new SimpleDateFormat("yyyy-MM-dd").format(c.getTime()) + "')";
			pstmt = conn.prepareStatement(query);
			pstmt.executeUpdate();
			pstmt.close();
			conn.commit();
			
			/*	retailer의 stock을 줄이고 included의 included 생성 	*/
			for(iter = product_list.keySet().iterator();iter.hasNext();){
				String product_id = iter.next();
				query = "update be_in_stock set stock=stock-" + product_list.get(product_id)
				+ " where product_id='" + product_id +"'";
				System.out.println(query);
				pstmt = conn.prepareStatement(query);
				pstmt.executeUpdate();
				pstmt.close();
				
				
				query = "insert into included values('" + product_id + "', '" + (Integer.parseInt(last_order_number) + 1) + "',' " 
				+ product_list.get(product_id) + "')";
				pstmt = conn.prepareStatement(query);
				pstmt.executeUpdate();
				pstmt.close();
				
				conn.commit();
			}
			
			query = "delete from contained where user_id='" + request.getParameter("user_id") + "'";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.executeUpdate();
			
			conn.commit();
			pstmt.close();
			conn.close();
			response.sendRedirect("order_success.jsp?user_id=" + request.getParameter("customer_id"));
		}
	}catch(SQLException e){
		e.printStackTrace();
		conn.close();
	}
%>


</body>
</html>