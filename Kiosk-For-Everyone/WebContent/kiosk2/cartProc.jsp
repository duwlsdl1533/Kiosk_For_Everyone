<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //한글처리
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<title>카트담기</title>
</head>
<body>
<%
   String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";
   String dbUser = "system";
   String dbPass = "1234";
   Connection conn = null; // DBMS와 Java연결객체
   ResultSet rs = null; // SQL구문의 실행결과를 저장
   
   //insert용
   PreparedStatement pstmt = null; // SQL구문을 실행
   int today_idx = Integer.parseInt(request.getParameter("idx"));
   String td = request.getParameter("today");
   request.setAttribute("idx", today_idx);
   request.setAttribute("today", td);
   try {
      
      Class.forName("oracle.jdbc.driver.OracleDriver");
      conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
      
      String mn = request.getParameter("mn");
      String nextMn = request.getParameter("nextMn");
      
      
      System.out.println("지금 메뉴 선택한것은? *********  " + mn +"다음 메뉴는?? : "+nextMn);
      String query = null;
   
      String sql = null;
      
      if(mn.equals("coffee")){
         query = "INSERT INTO COFFEE_ORDER(IDX,TODAY,CF_NAME,CF_CNT,CF_FEE) VALUES(?,?,?,?,?)";
         
         /* sql = "insert into  ALLLIST (name, cnt, id) select cf_name, cf_cnt, id from COFFEE_ORDER"; */
         System.out.println("1.♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣");
         System.out.println(today_idx+" |  "+td);
         System.out.println(query);
         System.out.println("1.♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣");
           //담긴 커피 메뉴명
            String selected_cf = request.getParameter("selected_cf");
            String pick_cff[] = selected_cf.split(",");
         //담긴 커피마다의 잔수
            String cfcnt = request.getParameter("cf_cnt");
            String pick_cfcnt[] = cfcnt.split(",");
         //커피 가격 
            String cffee = request.getParameter("cf_fee");
            String pick_cffee[] = cffee.split(",");
            
            if(pick_cff.length> 1){
              for(int i=0; i < pick_cfcnt.length ; i++){
		            pstmt = conn.prepareStatement(query);
                      if(!pick_cff[i].equals("")){
                         pstmt.setInt(1,today_idx);
                         pstmt.setString(2,td);
                         pstmt.setString(3, pick_cff[i]);
                         pstmt.setInt(4, Integer.parseInt(pick_cfcnt[i]));
                         pstmt.setInt(5, Integer.parseInt(pick_cffee[i]));   
                         pstmt.executeUpdate();
                   }
                         pstmt.close();
                  }
            }
            if(nextMn.equals("cf")){
              request.getRequestDispatcher("../kiosk2/Coffee.jsp").forward(request,response);
              }
              if(nextMn.equals("ade")){
              request.getRequestDispatcher("../kiosk2/Ade.jsp").forward(request,response);
              }
              if(nextMn.equals("smt")){
              request.getRequestDispatcher("../kiosk2/Smoothie.jsp").forward(request,response);
              }
              if(nextMn.equals("bt")){
              request.getRequestDispatcher("../kiosk2/Bottle.jsp").forward(request,response);
              }
              if(nextMn.equals("bd")){
              request.getRequestDispatcher("../kiosk2/Bread.jsp").forward(request,response);
              }
              if(nextMn.equals("pay")){
               request.getRequestDispatcher("../kiosk2/payment.jsp").forward(request,response);
              }
              
      }
      if(mn.equals("ade")){
    	  
          query = "INSERT INTO ADE_ORDER(IDX,TODAY,ADE_NAME,ADE_CNT,ADE_FEE) VALUES(?,?,?,?,?)";
          System.out.println("2.♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣");
          System.out.println(query);
          System.out.println("2.♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣");
           //담긴 커피 메뉴명
            String selected_ade = request.getParameter("selected_ade");
            String pick_adef[] = selected_ade.split(",");
            
         //담긴 커피마다의 잔수
            String adecnt = request.getParameter("ade_cnt");
            String pick_adecnt[] = adecnt.split(",");
          //가격 
            String adefee = request.getParameter("ade_fee");
            String pick_adefee[] = adefee.split(",");
           for(int i=0; i < pick_adecnt.length ; i++){
           		 pstmt = conn.prepareStatement(query);
                   if(!pick_adef[i].equals("")){
                      pstmt.setInt(1,today_idx);
                      pstmt.setString(2,td);
                      pstmt.setString(3, pick_adef[i]);
                      pstmt.setInt(4, Integer.parseInt(pick_adecnt[i]));
                      pstmt.setInt(5, Integer.parseInt(pick_adefee[i]));
                      pstmt.executeUpdate();
                    pstmt.close();
                }
            }
           if(nextMn.equals("cf")){
              request.getRequestDispatcher("../kiosk2/Coffee.jsp").forward(request,response);
              }
           if(nextMn.equals("ade")){
              request.getRequestDispatcher("../kiosk2/Ade.jsp").forward(request,response);
              }
             if(nextMn.equals("smt")){
             request.getRequestDispatcher("../kiosk2/Smoothie.jsp").forward(request,response);
             }
             if(nextMn.equals("bt")){
             request.getRequestDispatcher("../kiosk2/Bottle.jsp").forward(request,response);
             }
             if(nextMn.equals("bd")){
             request.getRequestDispatcher("../kiosk2/Bread.jsp").forward(request,response);
             }
             if(nextMn.equals("pay")){
              request.getRequestDispatcher("../kiosk2/payment.jsp").forward(request,response);
             }
      }
      if(mn.equals("smoothie")){
          query = "INSERT INTO SMT_ORDER(IDX,TODAY,SMT_NAME,SMT_CNT,SMT_FEE) VALUES(?,?,?,?,?)";
          System.out.println("3.♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣");
          System.out.println(query);
          System.out.println("3.♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣");
           //담긴 커피 메뉴명
            String selected_smt = request.getParameter("selected_smt");
            String pick_smtf[] = selected_smt.split(",");
            
         //담긴 커피마다의 잔수
            String smtcnt = request.getParameter("smt_cnt");
            String pick_smtcnt[] = smtcnt.split(",");
          //가격 
            String smtfee = request.getParameter("smt_fee");
            String pick_smtfee[] = smtfee.split(",");
           for(int i=0; i < pick_smtcnt.length ; i++){
	            pstmt = conn.prepareStatement(query);
                   if(!pick_smtf[i].equals("")){
                      pstmt.setInt(1,today_idx);
                      pstmt.setString(2,td);
                      pstmt.setString(3, pick_smtf[i]);
                      pstmt.setInt(4, Integer.parseInt(pick_smtcnt[i]));
                      pstmt.setInt(5, Integer.parseInt(pick_smtfee[i]));
                      pstmt.executeUpdate();
                    pstmt.close();
                }
               }
           if(nextMn.equals("cf")){
              request.getRequestDispatcher("../kiosk2/Coffee.jsp").forward(request,response);
              }
           if(nextMn.equals("ade")){
              request.getRequestDispatcher("../kiosk2/Ade.jsp").forward(request,response);
              }
              if(nextMn.equals("smt")){
              request.getRequestDispatcher("../kiosk2/Smoothie.jsp").forward(request,response);
              }
              if(nextMn.equals("bt")){
              request.getRequestDispatcher("../kiosk2/Bottle.jsp").forward(request,response);
              }
              if(nextMn.equals("bd")){
              request.getRequestDispatcher("../kiosk2/Bread.jsp").forward(request,response);
              }
              if(nextMn.equals("pay")){
               request.getRequestDispatcher("../kiosk2/payment.jsp").forward(request,response);
              }
      }
      if(mn.equals("bottle")){
          query = "INSERT INTO BT_ORDER(IDX,TODAY,BT_NAME,BT_CNT,BT_FEE) VALUES(?,?,?,?,?)";
            
           //담긴 커피 메뉴명
            String selected_bt = request.getParameter("selected_bt");
            String pick_btf[] = selected_bt.split(",");
            
         //담긴 커피마다의 잔수
            String btcnt = request.getParameter("bt_cnt");
            String pick_btcnt[] = btcnt.split(",");
          //가격 
            String btfee = request.getParameter("bt_fee");
            String pick_btfee[] = btfee.split(",");
           for(int i=0; i < pick_btcnt.length ; i++){
	            pstmt = conn.prepareStatement(query);
                   if(!pick_btf[i].equals("")){
                      pstmt.setInt(1,today_idx);
                      pstmt.setString(2,td);
                      pstmt.setString(3, pick_btf[i]);
                      pstmt.setInt(4, Integer.parseInt(pick_btcnt[i]));
                      pstmt.setInt(5, Integer.parseInt(pick_btfee[i]));
                      pstmt.executeUpdate();
                    pstmt.close();
                }
               }
           if(nextMn.equals("cf")){
              request.getRequestDispatcher("../kiosk2/Coffee.jsp").forward(request,response);
              }
           if(nextMn.equals("ade")){
              request.getRequestDispatcher("../kiosk2/Ade.jsp").forward(request,response);
              }
              if(nextMn.equals("smt")){
              request.getRequestDispatcher("../kiosk2/Smoothie.jsp").forward(request,response);
              }
              if(nextMn.equals("bt")){
              request.getRequestDispatcher("../kiosk2/Bottle.jsp").forward(request,response);
              }
              if(nextMn.equals("bd")){
              request.getRequestDispatcher("../kiosk2/Bread.jsp").forward(request,response);
              }
              if(nextMn.equals("pay")){
              request.getRequestDispatcher("../kiosk2/payment.jsp").forward(request,response);
              }
      }
      if(mn.equals("bread")){
          query = "INSERT INTO BRD_ORDER(IDX,TODAY,BRD_NAME,BRD_CNT,BRD_FEE) VALUES(?,?,?,?,?)";
            
           //담긴 커피 메뉴명
            String selected_bd = request.getParameter("selected_bd");
            String pick_bdf[] = selected_bd.split(",");
            
         //담긴 커피마다의 잔수
            String bdcnt = request.getParameter("bd_cnt");
            String pick_bdcnt[] = bdcnt.split(",");
          //가격 
            String bdfee = request.getParameter("bd_fee");
            String pick_bdfee[] = bdfee.split(",");
           for(int i=0; i < pick_bdcnt.length ; i++){
	            pstmt = conn.prepareStatement(query);
                   if(!pick_bdf[i].equals("")){
                      pstmt.setInt(1,today_idx);
                      pstmt.setString(2,td);
                      pstmt.setString(3, pick_bdf[i]);
                      pstmt.setInt(4, Integer.parseInt(pick_bdcnt[i]));
                      pstmt.setInt(5, Integer.parseInt(pick_bdfee[i]));
                      pstmt.executeUpdate();
                    pstmt.close();
                }
               }
           if(nextMn.equals("cf")){
              request.getRequestDispatcher("../kiosk2/Coffee.jsp").forward(request,response);
              }
           if(nextMn.equals("ade")){
              request.getRequestDispatcher("../kiosk2/Ade.jsp").forward(request,response);
              }
              if(nextMn.equals("smt")){
              request.getRequestDispatcher("../kiosk2/Smoothie.jsp").forward(request,response);
              }
              if(nextMn.equals("bt")){
              request.getRequestDispatcher("../kiosk2/Bottle.jsp").forward(request,response);
              }
              if(nextMn.equals("bd")){
              request.getRequestDispatcher("../kiosk2/Bread.jsp").forward(request,response);
              }
              if(nextMn.equals("pay")){
               request.getRequestDispatcher("../kiosk2/payment.jsp").forward(request,response);
              }
      }
// session.setAttribute("idx",today_idx);
         conn.close();
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
                    System.out.println("psmt 접속성공");
                     pstmt.close();
             } else {
               throw new Exception("pstmt 에러");
            }
      } catch (SQLException e) {
         e.getStackTrace();
      }
   }
   System.out.println("The end");
   
//    request.getRequestDispatcher("/kiosk2/Smoothie.jsp").forward(request,response);
   
%>
<!-- <script type="text/javascript"> 
          self.window.alert("커피를 담았슴다.");
          request.getRequestDispatcher("/kiosk2/Ade.jsp").forward(request,response);
           location.href="/kiosk2/Ade.jsp"; 
 </script> -->
</body>
</html>