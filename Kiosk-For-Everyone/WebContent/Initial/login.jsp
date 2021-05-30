<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="../css/login.css?after"/>
<head>
<meta charset="UTF-8">
<title>로그인화면</title>
</head>
<body>
<br><br>
<h2>휴대폰으로 주문을 원하시면, QR코드를 스캔주세요 </h2>
<img src="../image/qr.png" width=200 height=200>
<script type="text/javascript">
function loginCheck(){
   var form = document.loginform;
   if( !form.id.value )
   {
      alert( "아이디를 입력하세요" );
      form.id.focus();
      return;
   } 
   /* if( !form.password.value )
   {
      alert( "비밀번호를 입력하세요" );
      form.password.focus();
      return;
   } */
   form.submit();
} 

</script>
<br><br><br>
<h1>전화번호를 입력해주세요</h1>
<br>
<div>
<form action="loginDB.jsp" method="post" name = "loginform" id="loginform">
   <table border="1" >
      <tr>
         <td id="title">전화번호</td>
         <td colspan="2"> 
         <input type="text" name = "id" maxlength="20" id="text"  style="width:300px;height:70px;font-size:30px;">
         </td>
      </tr>
      <tr>
      <td> <input type="button" name = "login" value = "로그인" onclick="loginCheck();" id="loginbt"></td>
      <td> <input type="button" name = "nonmembers" value="비회원주문" onclick="location.href='../kiosk2/nonmemberstart.jsp'" id="nomember"></td>
      </tr>
   </table>
</form>
</div>
</body>
</html>