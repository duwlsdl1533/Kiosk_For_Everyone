<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숫자 감소</title>

<%
request.setCharacterEncoding("UTF-8");

String Del_amount = request.getParameter("DelAmount");

String Del_name = (String)session.getAttribute("D");
String price = (String)session.getAttribute("p");

if(Del_amount == null){
	response.sendRedirect("NumDelect.jsp");
}
else{ 
	 int Del_num = Integer.parseInt(Del_amount); 

	System.out.println(Del_name);
	System.out.println(Del_amount);
	System.out.println(price);
%>

<% // 변수 선언

	Connection conn = null; 
 	PreparedStatement pstmt = null; 
	Statement stmt = null;
	ResultSet rs = null;
	
	String user = "SYSTEM";
	String pwd = "1234";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	
		// 데이터베이스를 접속하기 위한 드라이버 SW 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
		// 데이터베이스에 연결하는 작업 수행
		conn = DriverManager.getConnection(url, user, pwd);
		
		stmt = conn.createStatement();
	
		String name_sql = "select amount from KIOSK where name = ?";
		pstmt = conn.prepareStatement(name_sql);
		pstmt.setString(1, Del_name);
		rs = pstmt.executeQuery();
		
		int amount = 0;
		int nnum=0;
		String num = null;
	
		while(rs.next()){
			num = rs.getString("amount");
			nnum=Integer.parseInt(num);
			System.out.println(num);
		}
		
		if(nnum!=0){
			amount = nnum - Del_num;
		}
		else{
			amount=nnum;
		}
		
		System.out.println(amount);
		
		if(amount==0){
			String del_sql = "delect from KIOSK where name = ?";
			pstmt = conn.prepareStatement(name_sql);
			pstmt.setString(1, Del_name);
			pstmt.executeUpdate();
			pstmt.close(); 
		}
		else{
			System.out.println(Del_name);
			int menuprice = amount *  Integer.parseInt(price);
			
			String sql = "update KIOSK set amount = ?, price = ? where name = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, amount);
			pstmt.setInt(2, menuprice);
			pstmt.setString(3, Del_name);
			
			pstmt.executeUpdate();
		}
		
		pstmt.close(); 
		
		
}
%>

</head>
<body>
<script>
location.href="ReOrder.jsp";
</script>


</body>
</html>