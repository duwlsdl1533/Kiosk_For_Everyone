<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<jsp:useBean id="login" class="VO.loginVO" scope="page"/>
<jsp:setProperty name="login" property="*"/>
<%   
   String id = request.getParameter("id");
   session.setAttribute("id", id);
   
   System.out.println(id);

   
   Connection conn = null; // DBMS와 Java연결객체
   Statement stmt = null; // SQL구문을 실행
   ResultSet rs = null; // SQL구문의 실행결과를 저장
   PreparedStatement pstmt = null; 
   PreparedStatement ID_pstmt = null; 
   
   String user = "SYSTEM";
   String pw = "1234";
   String url = "jdbc:oracle:thin:@localhost:1521:XE";
   
   int result = 0;
   String redirectUrl = "";
   
   try {
      
      Class.forName("oracle.jdbc.driver.OracleDriver");
      // 데이터베이스에 연결하는 작업 수행
      conn = DriverManager.getConnection(url, user, pw);
      String sql = "merge into members  USING dual on(id = ?) when not matched then INSERT (id) VALUES (?)";
      
      System.out.println(sql);
      stmt = conn.createStatement();
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, id);
      pstmt.setString(2, id);
      
      rs = pstmt.executeQuery();
      
      
      conn.close();
   }catch(Exception e){
      e.getStackTrace();
   }finally{
      try{ // 연결된 DB를 종료
         if (conn != null) {
//             System.out.println("데이터베이스와 연결 성공");
            conn.close();
         } else {
            throw new Exception("데이터베이스를 연결할 수 없습니다.");
         }
         if (stmt != null) {
//             System.out.println("psmt 접속성공");
            stmt.close();
         } else {
            throw new Exception("psmt 에러");
         }
      } catch (Exception e) {
         e.getStackTrace();
      }
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인</title>
</head>
<script>
function submit(){
	document.phone.submit();	
}

</script>
<body onload="submit()";>

<form name = "phone"  action="../kiosk2/start.jsp" method="post" display:none>
	<textarea name = "id" class = "id"><%=id%></textarea> 
</form>
</body>
</html>