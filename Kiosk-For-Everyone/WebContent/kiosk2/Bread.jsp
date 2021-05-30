<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript" src="../js/jquery-1.7.1.js"> </script>
<head>
<img id="samll_logo" src="../image/samll_logo.jpg" border="0" width="600px" height="150px">
<link rel="stylesheet" type="text/css" href="../css/menuselect.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="java.util.*"%>
<% 	
	request.setCharacterEncoding("UTF-8"); //한글처리
	String td = null;
	int idx = 0;
	idx = (int)request.getAttribute("idx");
	td = (String)request.getAttribute("today");
	System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	//int idx = (int)request.getAttribute("idx");
	System.out.println(idx + "    빵화면에서 idx잡기!!");
	request.setAttribute("idx", idx);
	//String td = (String)request.getAttribute("today");
	request.setAttribute("td", td);
	System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
%>
<script type="text/javascript">
var cf =['블루베리베이글','뺑 오 쇼콜라','하트파이','단호박 에그샌드위치','에그에그 샌드위치','크로크무슈','레드벨벳크림치즈케이크','치즈케이크','호두 당근케이크'];
var cff =['5800','6000','6500','6500','7000','7000',' 7500','7000','7000'];
//장바구니에 담을 커피목록
var selected_bd =[];
// 장바구니에 담을 커피메뉴마다 잔수 
var bd_cnt =[];
//장바구니에 담을 커피메뉴마다 가격
var bd_fee =[];
//결제 금액 정산용
var breadFee = 0;
function addCart(idx){
	   var amount= $('#cf_amount'+idx).val();
	   var selFare = cff[idx-1] * amount;
	   alert(cf[idx-1]+' '+amount+'개를 담았습니다.');
	   //장바구니 비동기화
	   ajaxCart(cf[idx-1],amount);
	   //결제금액 정산
	   breadFee = breadFee + selFare;
//	    cartIdx += 1;
	   //커피의 잔 수를 배열에 넣음
	   selected_bd[idx-1] = cf[idx-1];
	   bd_cnt[idx-1] = amount;
	   //커피의 잔 수마다 가격 넣음
	   bd_fee[idx-1] = selFare;
	}
//주문현황
function ajaxCart(mn,amount){
	var innerHtml = "";
	innerHtml += "<li>"+mn +" "+amount+"잔</li>";
// 	innerHtml += "<tr><td>"+mn +" "+amount+"잔</td></tr>";
	   $('#cartBody').append(innerHtml);	
   /* $('#cartList').append(innerHtml); */	
}
function resetCart(){
	   $('#cartBody').empty();
	   $('#TotalFee').empty();
	   sumFee = 0;
	   deleteTable();
}

function deleteTable(){
	var idx = $('#idx').val();
	var td = $('#today').val();
	$.ajax({
		url  : "/kiosk2/deleteProc.jsp?idx="+idx+"&today="+td,
        type : "POST",
		datatype : String,
		success : function(data) {
			console.log(data);
			if(data.trim() == "pass"){
				alert('초기화 성공하여 커피메뉴로 돌아갑니다');
				location.href="/kiosk2/Coffee.jsp?idx="+idx+"&today="+td; 
			}
			if(data.trim() == "fail"){
				alert('초기화 하지 못했어요');
			}
		}
		});
}
function TotalFee(){
	var innerHtml = "";
	innerHtml = "<tr><td>총 주문금액 : "+breadFee+" 원</td></tr>";
 $('#TotalFee').html(innerHtml);
}
function buttonClick(str){
	var form = document.getElementById("breadForm");
	//장바구니에 담은 커피명
	form.selected_bd.value = selected_bd;
	form.bdFee.value = breadFee;
	form.bd_cnt.value = bd_cnt;
	form.bd_fee.value = bd_fee;
	form.nextMn.value = str;
	$("#breadForm").attr("action","../kiosk2/cartProc.jsp");
	if(str == 'cf'){
		form.mn.value = 'bread';
	}
	else if(str == 'ade'){
		form.mn.value = 'bread';
	}
	else if(str == 'smt'){
		form.mn.value = 'bread';
	}
	else if(str == 'bt'){
		form.mn.value = 'bread';
	}
	else if(str == 'bd'){
		form.mn.value = 'bread';
	}
	else if(str == 'pay'){
		form.mn.value = 'bread';
	}
	form.submit();
} 
</script>
<title>빵 화면</title>
</head>
<body bgcolor="#ffefb3">
<jsp:useBean id="a1" class="CafeKiosk.kioskController"/>
<jsp:useBean id="a2" class="CafeKiosk.kioskController"/>
<jsp:useBean id="a3" class="CafeKiosk.kioskController"/>
<jsp:useBean id="a4" class="CafeKiosk.kioskController"/>
<jsp:useBean id="a5" class="CafeKiosk.kioskController"/>
<c:set var="ab" value="<%=a1.CoffeeList(request) %>"/>
<c:set var="bc" value="<%=a2.AdeList(request) %>"/> 
<c:set var="cd" value="<%=a3.SmoothieList(request) %>"/> 
<c:set var="de" value="<%=a4.BottleList(request) %>"/> 
<c:set var="ef" value="<%=a5.BreadList(request) %>"/> 

	<form id="breadForm" name="breadForm" method="POST">
	<!-- 	현재 메뉴가 무엇인지 -->
	<input type="hidden" id="mn" name="mn" value="" />
	<!-- 	선택한 다음페이지가 무엇인지 -->
	<input type="hidden" id="nextMn" name="nextMn" value="" />
	<input type="hidden" id="idx" name="idx" value="<%=idx%>" />
	<input type="hidden" id="today" name="today" value=<%=td %> />
	<input type="hidden" id="selected_bd" name="selected_bd" value="" />
	<input type="hidden" id="bdFee" name="bdFee" value="" />
	<input type="hidden" id="bd_cnt" name="bd_cnt" value="" />
	<input type="hidden" id="bd_fee" name="bd_fee" value="" />
	<br>
	<button id="go_cf" onclick="buttonClick('cf');">커피</button>
		<button id="go_ade" onclick="buttonClick('ade');">에이드</button>
		<button id="go_smt" onclick="buttonClick('smt');">스무디</button>
		<button id="go_bt" onclick="buttonClick('bt');">병음료</button>
		<button id="go_bd" onclick="buttonClick('bd');">빵류</button>   
		<button id="go_pay" onclick="buttonClick('pay');">결제하기</button>  
	<br><br><br>
	<table align="center" border="5" width="300" height="300"> 
		<tr align="center"> 
			<td><img src="../image/BreadPicture/블루베리베이글.jpg" width=200 height=200></td>
			<td><img src="../image/BreadPicture/뺑오쇼콜라.jpg" width=200 height=200></td>
			<td><img src="../image/BreadPicture/하트파이.jpg" width=200 height=200></td>
		</tr>
		<tr align="center"> 
			<td>블루베리베이글</td>
			<td>뺑 오 쇼콜라</td>
			<td>하트파이</td>
		</tr> 
		<tr align="center">
				<td><input type="text" id="sell_price1" name="sell_price1" id="one"value="5800"></td>
				<td><input type="text" id="sell_price2" name="sell_price2" id="two" value="6000"></td>
				<td><input type="text" id="sell_price3" name="sell_price3" id="three" value="6500"></td>
			</tr> 
		<tr align="center"> 
			<td>
	            <form name="form" method="get">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" value="-" onclick="javascript:this.form.cf_amount1.value--;">   
	            <input type="text" id="cf_amount1" name="cf_amount1" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount1.value++;"><br>
	            <input type="button" name="bt1" value="확인" onClick="addCart(1);">
	            <br>
	            </form>
	         </td>
	         <td>
	            <form name="form" method="get">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" value="-" onclick="javascript:this.form.cf_amount2.value--;">   
	            <input type="text" id="cf_amount2" name="cf_amount2" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount2.value++;"><br>
	            <input type="button" name="bt1" value="확인" onClick="addCart(2);">
	            <br>
	            </form>
	         </td>
	         <td>
	            <form name="form" method="get">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" value="-" onclick="javascript:this.form.cf_amount3.value--;">   
	            <input type="text" id="cf_amount3" name="cf_amount3" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount3.value++;"><br>
	            <input type="button" name="bt1" value="확인" onClick="addCart(3);">
	            <br>
	            </form>
	         </td>
		</tr> 
		<tr align="center"> 
			<td><img src="../image/BreadPicture/단호박에그샌드위치.jpg" width=200 height=200></td>
			<td><img src="../image/BreadPicture/에그에그샌드위치.jpg" width=200 height=200></td>
			<td><img src="../image/BreadPicture/크로크무슈.jpg" width=200 height=200></td>
		</tr> 
		<tr align="center"> 
			<td>단호박 에그샌드위치</td>
			<td>에그에그 샌드위치</td>
			<td>크로크무슈</td>
		</tr> 
		<tr align="center"> 
				<td><input type="text" id="sell_price4" name="sell_price4" value="7000" readonly></td>
				<td><input type="text" id="sell_price5" name="sell_price5" value="7000" readonly></td>
				<td><input type="text" id="sell_price6" name="sell_price6" value="7500" readonly></td>
			</tr> 
		<tr align="center"> 
			<td>
	            <form name="form" method="get">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" value="-" onclick="javascript:this.form.cf_amount4.value--;">   
	            <input type="text" id="cf_amount4" name="cf_amount4" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount4.value++;"><br>
	            <input type="button" name="bt1" value="확인" onClick="addCart(4);">
	            <br>
	            </form>
	         </td>
	         <td>
	            <form name="form" method="get">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" value="-" onclick="javascript:this.form.cf_amount5.value--;">   
	            <input type="text" id="cf_amount5" name="cf_amount5" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount5.value++;"><br>
	            <input type="button" name="bt1" value="확인" onClick="addCart(5);">
	            <br>
	            </form>
	         </td>
	         <td>
	            <form name="form" method="get">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" value="-" onclick="javascript:this.form.cf_amount6.value--;">   
	            <input type="text" id="cf_amount6" name="cf_amount6" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount6.value++;"><br>
	            <input type="button" name="bt1" value="확인" onClick="addCart(6);">
	            <br>
	            </form>
	         </td>
		</tr> 
		<tr align="center"> 
			<td><img src="../image/BreadPicture/레드벨벳크림치즈케이크.jpg" width=200 height=200></td>
			<td><img src="../image/BreadPicture/치즈케이크.jpg" width=200 height=200></td>
			<td><img src="../image/BreadPicture/호두당근케이크.jpg" width=200 height=200></td>
		</tr> 
		<tr align="center"> 
			<td>레드벨벳 크림치즈케이크</td>
			<td>치즈케이크</td>
			<td>호두 당근케이크</td>
		</tr> 
		<tr align="center"> 
				<td><input type="text" id="sell_price7"name="sell_price7" value="6500" readonly></td>
				<td><input type="text" id="sell_price8" name="sell_price8" value="7000" readonly></td>
				<td><input type="text" id="sell_price9" name="sell_price9" value="7000" readonly></td>
			</tr> 
		<tr align="center"> 
			<td>
	            <form name="form" method="get">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" value="-" onclick="javascript:this.form.cf_amount7.value--;">   
	            <input type="text" id="cf_amount7" name="cf_amount7" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount7.value++;"><br>
	            <input type="button" name="bt1" value="확인" onClick="addCart(7);">
	            <br>
	            </form>
	         </td>
	         <td>
	            <form name="form" method="get">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" value="-" onclick="javascript:this.form.cf_amount8.value--;">   
	            <input type="text" id="cf_amount8" name="cf_amount8" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount8.value++;"><br>
	            <input type="button" name="bt1" value="확인" onClick="addCart(8);">
	            <br>
	            </form>
	         </td>
	         <td>
	            <form name="form" method="get">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" value="-" onclick="javascript:this.form.cf_amount9.value--;">   
	            <input type="text" id="cf_amount9" name="cf_amount9" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount9.value++;"><br>
	            <input type="button" name="bt1" value="확인" onClick="addCart(9);">
	            <br>
	            </form>
	         </td>
		</tr> 
	</table>
	장바구니<br><br>
		<div id="cartList">
      <table>
         <tbody id="cartBody">
         </tbody>
<c:forEach var="ls" items="${ab}">
<tr>
			<td>메뉴</td>
			<td>수량</td>
			<td>가격</td>
		</tr>
				<tr>
					<td>${ls.CF_NAME}</td>
					<td>${ls.CF_CNT}</td>
					<td>${ls.CF_FEE}</td>
				</tr>
		</c:forEach> 
		<c:forEach var="als" items="${bc}">
				<tr>
					<td>${als.ADE_NAME}</td>
					<td>${als.ADE_CNT}</td>
					<td>${als.ADE_FEE}</td>
				</tr>
		</c:forEach> 
		<c:forEach var="sls" items="${cd}">
				<tr>
					<td>${sls.SMT_NAME}</td>
					<td>${sls.SMT_CNT}</td>
					<td>${sls.SMT_FEE}</td>
				</tr>
		</c:forEach> 
		<c:forEach var="btls" items="${de}">
				<tr>
					<td>${btls.BT_NAME}</td>
					<td>${btls.BT_CNT}</td>
					<td>${btls.BT_FEE}</td>
				</tr>
		</c:forEach>
		<c:forEach var="brdls" items="${ef}">
				<tr>
					<td>${brdls.BRD_NAME}</td>
					<td>${brdls.BRD_CNT}</td>
					<td>${brdls.BRD_FEE}</td>
				</tr>
		</c:forEach>
         </tbody>
      </table>
   </div>   
   <input type="button" name="reset" value="초기화" onClick="resetCart(); return false;"> <br><br>
	<!-- <button type="button" onClick="TotalFee();">
		결제하기</button>  <br><br> -->
		<div id="Total" >
	      <table>
	         <tbody id="TotalFee">
	      
         </table>
         </div>
         </form>
</body>
</html>