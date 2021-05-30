package CafeKiosk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteController {
	/*전역변수를 써서 다른 함수에서도 close할수 있도록*/
	Connection conn = null; // DBMS와 Java연결객체
	Statement stmt = null; // SQL구문을 실행
	ResultSet rs = null; // SQL구문의 실행결과를 저장
	PreparedStatement pstmt = null; // SQL구문을 실행
	public DeleteController() throws SQLException{
		
		 String user = "SYSTEM";
		   String pw = "1234";
		   String url = "jdbc:oracle:thin:@localhost:1521:XE";
		try {
			//오늘 주문 번호 확인
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pw);
			stmt = conn.createStatement();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	//결제
//	@SuppressWarnings("rawtypes")
	public void deleteControl(HttpServletRequest request,HttpServletResponse response) throws Exception{
		response.setContentType("text/plain; charset=utf-8");
		PrintWriter out = response.getWriter();
		String del_query = null;
		try {
			//insert용
			   int idx = Integer.parseInt(request.getParameter("idx"));
			   String td = request.getParameter("today");
			   del_query = "DELETE FROM COFFEE_ORDER WHERE IDX="+idx+" AND TODAY='"+td+"'";
		       System.out.println("============================================커피끝＃＃");
		       System.out.println(idx + " 한장씩 너를지울때마다!!   오늘의 : " +td);
		       System.out.println(del_query);
		       System.out.println("============================================커피끝＃＃");
		       pstmt = conn.prepareStatement(del_query);
		       pstmt.executeUpdate();
		       pstmt.close();
		       System.out.println("커피는 지웟어요~~~~~~~~~~~~~~~~~~~~~");
		       Thread.sleep(300); //1초 대기
		       del_query = "DELETE FROM ADE_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'";
		       pstmt = conn.prepareStatement(del_query);
		       pstmt.executeUpdate();
		       
		       pstmt.close();
		       Thread.sleep(300); //1초 대기
		       del_query = "DELETE FROM SMT_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'";
		       pstmt = conn.prepareStatement(del_query);
		       pstmt.executeUpdate();
		      
		       pstmt.close();
		       Thread.sleep(300); //1초 대기
			   del_query = "DELETE FROM BT_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'";
			   pstmt = conn.prepareStatement(del_query);
		       pstmt.executeUpdate();
		      
		       pstmt.close();
		       Thread.sleep(300); //1초 대기
				del_query = "DELETE FROM BRD_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'";
				pstmt = conn.prepareStatement(del_query);
			       pstmt.executeUpdate();
			       pstmt.close();
			       Thread.sleep(300); //1초 대기
			       
			       request.setAttribute("idx", idx);
				   request.setAttribute("today", td);
		    	   out.println("pass");
			}catch(Exception e){
			e.getStackTrace();
			}finally{
			try{ // 연결된 DB를 종료
				if (conn != null) {
						System.out.println("데이터베이스와 연결 성공");
					conn.close();
				} else {
					throw new Exception("데이터베이스를 연결할 수 없습니다.");
				}
				if (pstmt != null) {
						System.out.println("delete psmt 접속성공");
					pstmt.close();
			 	} else {
					throw new Exception("psmt 에러");
				}
			} catch (SQLException e) {
				e.getStackTrace();
			}
		}
	}
}
