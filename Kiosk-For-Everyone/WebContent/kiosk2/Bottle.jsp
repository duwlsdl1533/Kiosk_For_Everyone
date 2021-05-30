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
<%@ page import="java.util.*"%>
<% 
	request.setCharacterEncoding("UTF-8"); //한글처리
	String td = null;
	int idx = 0;
	idx = (int)request.getAttribute("idx");
	td = (String)request.getAttribute("today");
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
	//int idx = (int)request.getAttribute("idx");
	System.out.println(idx + "    병화면에서 idx잡기!!");
	//String td = (String)request.getAttribute("today");
	System.out.println(idx + "    병화면에서 날짜찾기!!");
	request.setAttribute("idx", idx);
	request.setAttribute("today", td);
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
<script type="text/javascript">
var cf =['사과주스','오렌지주스','자몽주스','생수'];
var cff =['4500','3500','5000','3000'];

//장바구니에 담을 커피목록
var selected_bt =[];
// 장바구니에 담을 커피메뉴마다 잔수 
var bt_cnt =[];
//장바구니에 담을 커피메뉴마다 가격
var bt_fee =[];

//결제 금액 정산용
var bottleFee = 0;

function addCart(idx){
	   var amount= $('#cf_amount'+idx).val();
	   var selFare = cff[idx-1] * amount;
	   alert(cf[idx-1]+' '+amount+'잔을 담았습니다.');
	   //장바구니 비동기화
	   ajaxCart(cf[idx-1],amount);
	   //결제금액 정산
	   bottleFee = bottleFee + selFare;
//	    cartIdx += 1;
	   //커피의 잔 수를 배열에 넣음
	   selected_bt[idx-1] = cf[idx-1];
	   bt_cnt[idx-1] = amount;
	   //커피의 잔 수마다 가격 넣음
	   bt_fee[idx-1] = selFare;
	}
//주문현황
function ajaxCart(mn,amount){
	var innerHtml = "";
	innerHtml += "<li>"+mn +" "+amount+"잔</li>";
// 	innerHtml += "<tr><td>"+mn +" "+amount+"잔</td></tr>";
 	   $('#cartBody').append(innerHtml);	
	  /*  $('#cartList').append(innerHtml);	 */
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
	innerHtml = "<tr><td>총 주문금액 : "+bottleFee+" 원</td></tr>";
    $('#TotalFee').html(innerHtml);
}
function buttonClick(str){
	var form = document.getElementById("bottleForm");
	//장바구니에 담은 커피명
	form.selected_bt.value = selected_bt;
	form.btFee.value = bottleFee;
	form.bt_cnt.value = bt_cnt;
	form.bt_fee.value = bt_fee;
	form.nextMn.value = str;
	$("#bottleForm").attr("action","../kiosk2/cartProc.jsp");
	if(str == 'cf'){
		form.mn.value = 'bottle';
	}
	else if(str == 'ade'){
		form.mn.value = 'bottle';
	}
	else if(str == 'smt'){
		form.mn.value = 'bottle';
	}
	else if(str == 'bt'){
		form.mn.value = 'bottle';
	}
	else if(str == 'bd'){
		form.mn.value = 'bottle';
	}
	else if(str == 'pay'){
		form.mn.value = 'bottle';
	}
	form.submit();
} 
</script>
<title>병음료 화면</title>
</head>
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

<body bgcolor="#ffefb3">
	<form id="bottleForm" name="bottleForm" method="POST">
	<!-- 	현재 메뉴가 무엇인지 -->
	<input type="hidden" id="mn" name="mn" value="" />
	<!-- 	선택한 다음페이지가 무엇인지 -->
	<input type="hidden" id="nextMn" name="nextMn" value="" />
	<input type="hidden" id="idx" name="idx" value="<%=idx%>" />
	<input type="hidden" id="today" name="today" value=<%=td %> />
	<input type="hidden" id="selected_bt" name="selected_bt" value="" />
	<input type="hidden" id="btFee" name="btFee" value="" />
	<input type="hidden" id="bt_cnt" name="bt_cnt" value="" />
	<input type="hidden" id="bt_fee" name="bt_fee" value="" />
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
			<td><img src="../image/BottlePicture/사과쥬스.jpg" width=200 height=200></td>
			<td><img src="../image/BottlePicture/오렌지주스.jpg" width=200 height=200></td>
			<td><img src="../image/BottlePicture/자몽쥬스.jpg" width=200 height=200></td>
		</tr> 
		<tr align="center"> 
			<td>사과주스</td>
			<td>오렌지주스</td>
			<td>자몽주스</td>
		</tr> 
		<tr align="center">
				<td><input type="text" id="sell_price1" name="sell_price1" id="one"value="4500" readonly></td>
				<td><input type="text" id="sell_price2" name="sell_price2" id="two" value="3500" readonly></td>
				<td><input type="text" id="sell_price3" name="sell_price3" id="three" value="5000" readonly></td>
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
			<td><img src="../image/BottlePicture/생수.jpg" width=200 height=200></td>
		</tr> 
		<tr align="center"> 
			<td>생수</td>
		</tr> 
		<tr align="center">
				<td><input type="text" id="sell_price4" name="sell_price4" id="one"value="3000" readonly></td>
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
		</tr> 
	</table>
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
         </tbody>
      </table>
   </div>   
  		<input type="button" id="reset" name="reset" value="초기화" onClick="resetCart(); return false;">
	    <button type="button" onclick="TotalFee(); return false;">현재가격</button> <br><br>
	<!-- <button type="button" onClick="TotalFee();">
		결제하기</button>  <br><br> -->
	<div id="TotalFee" >
      <table>
         <tbody id="TotalFee">
         
      </table>
	 </div>   
	</form>
</body>
</html>