<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<img id="samll_logo" src="../image/samll_logo.jpg" border="0" width="600px" height="150px">
<link rel="stylesheet" type="text/css" href="../css/menuselect.css"/>
<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8"); //한글처리
	String td = null;
	int idx = 0;
	if(request.getParameter("idx") == null){
		idx = (int)request.getAttribute("idx");
	}
	if(request.getAttribute("idx") == null){
		idx = Integer.parseInt(request.getParameter("idx"));
	}
	if(request.getParameter("today") == null){
		td = (String)request.getAttribute("today");
	}
	if((String)request.getAttribute("today") == null){
		td = request.getParameter("today");
	}
    System.out.println("==============================");
// 	td = (String)request.getAttribute("today");
	System.out.println(idx + "    커피에서 idx잡기!!");
	request.setAttribute("idx", idx);
	request.setAttribute("today", td);
	System.out.println(td + "    커피에서 날짜 찾기!!");
	System.out.println("==============================");
%>
<script type="text/javascript">

var cf =['아이스아메리카노','아메리카노','오늘의 커피','에스프레소','아이스 카페라떼','카푸치노','아이스 카라멜마키아또','카라멜 마키아또','아이스 카푸치노'];
var cff =['4000','4000','3500','3000','4500','5000',' 5500','5500','5000'];

//장바구니에 담을 커피목록
var selected_cf =[];
// 장바구니에 담을 커피메뉴마다 잔수 
var cf_cnt =[];
//장바구니에 담을 커피메뉴마다 가격
var cf_fee =[];

//결제 금액 정산용
var coffeeFee = 0;

function addCart(idx){
   var amount= $('#cf_amount'+idx).val();
   var selFare = cff[idx-1] * amount;
   alert(cf[idx-1]+' '+amount+'잔을 담았습니다.');
   //장바구니 비동기화
   ajaxCart(cf[idx-1],amount);
   //결제금액 정산
   coffeeFee = coffeeFee + selFare;
//    cartIdx += 1;
   //커피의 메뉴이름을 배열에 넣음
   selected_cf[idx-1] = cf[idx-1];
   //해당메뉴의 잔 수
   cf_cnt[idx-1] = amount;
   //커피의 잔 수마다 가격 넣음
   cf_fee[idx-1] = selFare;
}

//주문현황
function ajaxCart(ab,amount){
	var innerHtml = "";
	innerHtml += "<li>"+ab +" "+amount+"잔</li>";
	  /*  $('#cartList').append(innerHtml);	 */
// 	innerHtml += "<tr><td>"+mn +" "+amount+"잔</td></tr>";
 	   $('#cartBody').append(innerHtml);	
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
	var fw_url = "/kiosk2/Coffee.jsp?";
	$.ajax({
		url  : "/kiosk2/deleteProc.jsp?idx="+idx+"&today="+td,
        type : "post",
		datatype : String,
		success : function(data) {
			console.log(data);
			if(data.trim() == "pass"){
				alert('초기화 성공하여 커피메뉴로 돌아갑니다');
				alert(td);
// 				response.sendRedirect("/kiosk2/Coffee.jsp");
				location.href="/kiosk2/Coffee.jsp?idx="+idx+"&today="+td; 
			}
			if(data.trim() == "fail"){
				alert('초기화 하지 못했어요');
			}
		}
		});
}
//커피가격
function TotalFee(){
 	var innerHtml = "";
	innerHtml = "<tr><td>총 주문금액 : "+coffeeFee+" 원</td></tr>";
    $('#TotalFee').html(innerHtml);
}

function buttonClick(str){
	var form = document.getElementById("coffeeForm");
	//장바구니에 담은 커피명
	form.selected_cf.value = selected_cf;
	form.cfFee.value = coffeeFee;
	form.cf_cnt.value = cf_cnt;
	form.cf_fee.value = cf_fee;
	//다음으로 선택한 메뉴명
	form.nextMn.value = str;
	//어떤 메뉴에서 넘어왔는지
	form.mn.value = 'coffee';
	$("#coffeeForm").attr("action","../kiosk2/cartProc.jsp");
	form.submit();
} 

function upNdown(stat,idx){
	var form = document.getElementById("coffeeForm");
	var nowVal = $("#cf_amount"+idx).val();
	
	if(stat == 'm'){
		nowVal--;
// 		form.cf_amount1.value--;
	}
	if(stat == 'p'){
		nowVal++;
// 		form.cf_amount1.value++;
	}
	if(nowVal < 0){
		alert('0 잔은 안돼요');
		nowVal = 0;
// 		form.cf_amount1.value = 0;
	}
	if(idx == 1){
		form.cf_amount1.value = nowVal;
	}
	if(idx == 2){
		form.cf_amount2.value = nowVal;
	}
	if(idx == 3){
		form.cf_amount3.value = nowVal;
	}
	if(idx == 4){
		form.cf_amount4.value = nowVal;
	}
	if(idx == 5){
		form.cf_amount5.value = nowVal;
	}
	if(idx == 6){
		form.cf_amount6.value = nowVal;
	}
	if(idx == 7){
		form.cf_amount7.value = nowVal;
	}
	if(idx == 8){
		form.cf_amount8.value = nowVal;
	}
	if(idx == 9){
		form.cf_amount9.value = nowVal;
	}
	$("#cf_amount"+idx).val(nowVal);
}

</script>
	<title>커피화면</title>
	</head>
	<body bgcolor="#ffefb3">
	<form id="coffeeForm" name="coffeeForm" method="POST">
	<!-- 현재 모드는 무슨 모드인가 new or update -->
<!-- 	현재 메뉴가 무엇인지 -->
	<input type="hidden" id="mn" name="mn" value="" />
<!-- 	선택한 다음페이지가 무엇인지 -->
	<input type="hidden" id="nextMn" name="nextMn" value="" />
	<input type="hidden" id="idx" name="idx" value=<%=idx %> />
	<input type="hidden" id="today" name="today" value=<%=td %> />
	<input type="hidden" id="selected_cf" name="selected_cf" value="" />
	<input type="hidden" id="cfFee" name="cfFee" value="" />
	<input type="hidden" id="cf_cnt" name="cf_cnt" value="" />
	<input type="hidden" id="cf_fee" name="cf_fee" value="" />

		<br>
		<button id="go_cf" onclick="buttonClick('cf');">커피</button>
		<button id="go_ade" onclick="buttonClick('ade');">에이드</button>
		<button id="go_smt" onclick="buttonClick('smt');">스무디</button>
		<button id="go_bt" onclick="buttonClick('bt');">병음료</button>
		<button id="go_bd" onclick="buttonClick('bd');">빵류</button>
		<button id="go_pay" onclick="buttonClick('pay');">결제하기</button>    
		<br><br><br>
		<table frame="void" align="center" border="1" width="300" height="300"> 
			<tr> 
	         <td style="border: hidden;"><img src="../image/CoffeePicture/아이스아메리카노.jpg" width=200 height=200></td>
	         <td style="border: hidden;"><img src="../image/CoffeePicture/핫아메리카노.jpg" width=200 height=200></td>
	         <td style="border: hidden;"><img src="../image/CoffeePicture/오늘의 커피.jpg" width=200 height=200></td>
	      	</tr> 
			<tr> 
				 <td style="border: hidden;">아이스 아메리카노</td>
		         <td style="border: hidden;">아메리카노</td>
		         <td style="border: hidden;">오늘의 커피</td>
			</tr> 
			<tr>
				<td style="border: hidden;"><input type="text" id="sell_price1" name="sell_price1" id="one"value="4000"></td>
				<td style="border: hidden;"><input type="text" id="sell_price2" name="sell_price2" id="two" value="4000"></td>
				<td style="border: hidden;"><input type="text" id="sell_price3" name="sell_price3" id="three" value="3500"></td>
			</tr> 
	      <tr align="center"> 
	         <td style="border: hidden;">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            
	            <input type="button" id="min1" value="-" onclick="upNdown('m',1);">
        	    <input type="text" style="border: none; background: transparent;" id="cf_amount1" name="cf_amount1" value="0" size="3">   
	            <input type="button" id="plus1" value="+" onclick="upNdown('p',1);">   <br>
<!-- 	            <input type="button" value="-" onclick="javascript:this.form.cf_amount1.value--;">    -->
<!-- 	            <input type="text" style="border: none; background: transparent;" id="cf_amount1" name="cf_amount1" value="0" size="3" onclick="change_cnt();"> -->
<!-- 	            <input type="button" value="+" onclick="javascript:this.form.cf_amount1.value++;"><br> -->
	            <input type="button" id="ok1" name="bt1" value="확인" onClick="addCart(1);">
	            
	         </td>
	         <td style="border: hidden;">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" id="min2" value="-" onclick="upNdown('m',2);">
        	    <input type="text" style="border: none; background: transparent;" id="cf_amount2" name="cf_amount2" value="0" size="3">   
	            <input type="button" id="plus2" value="+" onclick="upNdown('p',2);">  <br>
<!-- 	            <input type="button" value="-" onclick="javascript:this.form.cf_amount2.value--;">    -->
<!-- 	            <input type="text" style="border: none; background: transparent;"  id="cf_amount2" name="cf_amount2" value="0" size="3" onchange="change();"> -->
<!-- 	            <input type="button" value="+" onclick="javascript:this.form.cf_amount2.value++;"><br> -->
	            <input type="button" id="ok2" name="bt1" value="확인" onClick="addCart(2);">
	            
	         </td>
	         <td style="border: hidden;">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" id="min3" value="-" onclick="upNdown('m',3);">
        	    <input type="text" style="border: none; background: transparent;" id="cf_amount3" name="cf_amount3" value="0" size="3">   
	            <input type="button" id="plus3" value="+" onclick="upNdown('p',3);"> <br> 
	            <!-- <input type="button" value="-" onclick="javascript:this.form.cf_amount3.value--;">   
	            <input type="text" style="border: none; background: transparent;"  id="cf_amount3" name="cf_amount3" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount3.value++;"><br> -->
	            <input type="button" id="ok3" name="bt1" value="확인" onClick="addCart(3);">
	           
	         </td>
	      </tr>
			<tr align="center"> 
				<td style="border: hidden;"><img src="../image/CoffeePicture/에스프레소.jpg" width=200 height=200></td>
				<td style="border: hidden;"><img src="../image/CoffeePicture/아이스카페라떼.jpg" width=200 height=200></td>
				<td style="border: hidden;"><img src="../image/CoffeePicture/카페라떼.jpg" width=200 height=200></td>
			</tr> 
			<tr align="center"> 
				<td style="border: hidden;">에스프레소</td>
				<td style="border: hidden;">아이스 카페라떼</td>
				<td style="border: hidden;">카푸치노</td>
			</tr> 
			<tr align="center"> 
				<td style="border: hidden;"><input type="text" style="border: none; background: transparent;" id="sell_price4" name="sell_price4" value="3000" readonly></td>
				<td style="border: hidden;"><input type="text" style="border: none; background: transparent;" id="sell_price5" name="sell_price5" value="4500" readonly></td>
				<td style="border: hidden;"><input type="text" style="border: none; background: transparent;" id="sell_price6" name="sell_price6" value="5000" readonly></td>
			</tr> 
	      <tr align="center"> 
	         <td style="border: hidden;">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" id="min4" value="-" onclick="upNdown('m',4);">
        	    <input type="text" style="border: none; background: transparent;" id="cf_amount4" name="cf_amount4" value="0" size="3">   
	            <input type="button" id="plus4" value="+" onclick="upNdown('p',4);">  <br>
	            <!-- <input type="button" value="-" onclick="javascript:this.form.cf_amount4.value--;">   
	            <input type="text" style="border: none; background: transparent;"  id="cf_amount4" name="cf_amount4" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount4.value++;"><br> -->
	            <input type="button" id="ok4" name="bt1" value="확인" onClick="addCart(4);">
	            <br>
	         </td>
	         <td style="border: hidden;">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" id="min5" value="-" onclick="upNdown('m',5);">
        	    <input type="text" style="border: none; background: transparent;" id="cf_amount5" name="cf_amount5" value="0" size="3">   
	            <input type="button" id="plus5" value="+" onclick="upNdown('p',5);">  <br>
	            <!-- <input type="button" value="-" onclick="javascript:this.form.cf_amount5.value--;">   
	            <input type="text" style="border: none; background: transparent;" id="cf_amount5" name="cf_amount5" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount5.value++;"><br> -->
	            <input type="button" id="ok5" name="bt1" value="확인" onClick="addCart(5);">
	            <br>
	         </td>
	         <td style="border: hidden;">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" id="min6" value="-" onclick="upNdown('m',6);">
        	    <input type="text" style="border: none; background: transparent;" id="cf_amount6" name="cf_amount6" value="0" size="3">   
	            <input type="button" id="plus6" value="+" onclick="upNdown('p',6);">  <br>
	            <!-- <input type="button" value="-" onclick="javascript:this.form.cf_amount6.value--;">   
	            <input type="text" style="border: none; background: transparent;" id="cf_amount6" name="cf_amount6" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount6.value++;"><br> -->
	            <input type="button" id="ok6" name="bt1" value="확인" onClick="addCart(6);">
	            <br>
	         </td>
	      </tr>
			<tr style="border-right: hidden;" align="center"> 
				<td style="border: hidden;"><img src="../image/CoffeePicture/아이스카라멜마키아또.jpg" width=200 height=200></td>
				<td style="border: hidden;"><img src="../image/CoffeePicture/카라멜마키아또.jpg" width=200 height=200></td>
				<td style="border: hidden;"><img src="../image/CoffeePicture/아이스카푸치노.jpg" width=200 height=200></td>
			</tr> 
			<tr style="border-right: hidden;" align="center"> 
				<td style="border: hidden;">아이스 카라멜마키아또</td>
				<td style="border: hidden;">카라멜마키아또</td>
				<td style="border: hidden;">아이스 카푸치노</td>
			</tr> 
			<tr style="border: hidden;" align="center"> 
				<td style="border: hidden;"><input type="text" style="border: none; background: transparent;" id="sell_price7"name="sell_price7" value="5500" readonly></td>
				<td style="border: hidden;"><input type="text" style="border: none; background: transparent;" id="sell_price8" name="sell_price8" value="5500" readonly></td>
				<td style="border: hidden;"><input type="text" style="border: none; background: transparent;" id="sell_price9" name="sell_price9" value="5000" readonly></td>
			</tr> 
	      <tr align="center"> 
	         <td style="border: hidden;">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" id="min7" value="-" onclick="upNdown('m',7);">
        	    <input type="text" style="border: none; background: transparent;" id="cf_amount7" name="cf_amount7" value="0" size="3">   
	            <input type="button" id="plus7" value="+" onclick="upNdown('p',7);">  <br>
	            <!-- <input type="button" value="-" onclick="javascript:this.form.cf_amount7.value--;">   
	            <input type="text" style="border: none; background: transparent;" id="cf_amount7" name="cf_amount7" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount7.value++;"><br> -->
	            <input type="button" id="ok7" name="bt1" value="확인" onClick="addCart(7);">
	            <br>
	         </td>
	         <td style="border: hidden;">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" id="min8" value="-" onclick="upNdown('m',8);">
        	    <input type="text" style="border: none; background: transparent;" id="cf_amount8" name="cf_amount8" value="0" size="3">   
	            <input type="button" id="plus8" value="+" onclick="upNdown('p',8);">  <br>
	            <!-- <input type="button" value="-" onclick="javascript:this.form.cf_amount8.value--;">   
	            <input type="text" style="border: none; background: transparent;"  id="cf_amount8" name="cf_amount8" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount8.value++;"><br> -->
	            <input type="button" id="ok8" name="bt1" value="확인" onClick="addCart(8);">
	            <br>
	         </td>
	         <td style="border: hidden;">
	            <!-- <input type="hidden" name="sell_price" value="5500"> -->
	            <input type="button" id="min9" value="-" onclick="upNdown('m',9);">
        	    <input type="text" style="border: none; background: transparent;" id="cf_amount9" name="cf_amount9" value="0" size="3">   
	            <input type="button" id="plus9" value="+" onclick="upNdown('p',9);">  <br>
	            <!-- <input type="button" value="-" onclick="javascript:this.form.cf_amount9.value--;">   
	            <input type="text" style="border: none; background: transparent;" id="cf_amount9" name="cf_amount9" value="0" size="3" onchange="change();">
	            <input type="button" value="+" onclick="javascript:this.form.cf_amount9.value++;"><br> -->
	            <input type="button" id="ok9" name="bt1" value="확인" onClick="addCart(9);">
	            <br>
         </td>
	      </tr>
		</table>
		</p>
	<h1>장바구니</h1><br><br>
	<div id="cartList">
      <table>
         <tbody id="cartBody">
         
         </tbody>
         <tr>
			<td>메뉴</td>
			<td>수량</td>
			<td>가격</td>
		</tr>
         <c:forEach var="ls" items="${ab}">
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
         
      </table>
   </div>   
	    <input type="button" id="reset" name="reset" value="초기화" onClick="resetCart(); return false;">
	    <button type="button" onclick="TotalFee(); return false;">현재가격</button> <br><br>

		<div id="Total" >
	      <table>
	         <tbody id="TotalFee">
	         
	         </tbody>
	      </table>
   		</div>   
   </form> 
</body>
</html>