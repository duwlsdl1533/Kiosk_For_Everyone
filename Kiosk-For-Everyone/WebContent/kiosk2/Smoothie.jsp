<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<img id="samll_logo" src="../image/samll_logo.jpg" border="0" width="600px" height="150px">
<link rel="stylesheet" type="text/css" href="../css/menuselect.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="java.util.*"%>
<% 
	request.setCharacterEncoding("UTF-8"); //한글처리
	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	String td = null;
	int idx = 0;
	idx = (int)request.getAttribute("idx");
	td = (String)request.getAttribute("today");
	System.out.println(idx + "    스무디에서 idx잡기!!");
	request.setAttribute("idx", idx);
// 	String td = (String)request.getAttribute("today");
	request.setAttribute("today", td);
	System.out.println(td + "    스무디에서 날짜 찾기!!");
	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
%>
<script type="text/javascript">
var cf =['녹차 스무디','망고 스무디','딸기 스무디','요거트 스무디','체리 스무디'];
var cff =['5500','5000','5500','6000','6000'];

//장바구니에 담을 커피목록
var selected_smt =[];
// 장바구니에 담을 커피메뉴마다 잔수 
var smt_cnt =[];
//장바구니에 담을 커피메뉴마다 가격
var smt_fee =[];

//결제 금액 정산용
var smtFee = 0;

function addCart(idx){
   var amount= $('#cf_amount'+idx).val();
   var selFare = cff[idx-1] * amount;
   alert(cf[idx-1]+' '+amount+'잔을 담았습니다.');
   //장바구니 비동기화
   ajaxCart(cf[idx-1],amount);
   //결제금액 정산
   smtFee = smtFee + selFare;
//    cartIdx += 1;
   //커피의 잔 수를 배열에 넣음
   selected_smt[idx-1] = cf[idx-1];
   smt_cnt[idx-1] = amount;
   //커피의 잔 수마다 가격 넣음
   smt_fee[idx-1] = selFare;
}
//주문현황
function ajaxCart(mn,amount){
	var innerHtml = "";
	// innerHtml += "<tr><td>"+mn +" "+amount+"잔</td></tr>";
	  // $('#cartBody').append(innerHtml);	 
	innerHtml += "<li>"+mn +" "+amount+"잔</li>";
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
	innerHtml = "<tr><td>총 주문금액 : "+smtFee+" 원</td></tr>";
    $('#TotalFee').html(innerHtml);
}

function buttonClick(str){
	var form = document.getElementById("smoothieForm");
	//장바구니에 담은 커피명
	form.selected_smt.value = selected_smt;
	form.smtFee.value = smtFee;
	form.smt_cnt.value = smt_cnt;
	form.smt_fee.value = smt_fee;
	form.nextMn.value = str;
	$("#smoothieForm").attr("action","../kiosk2/cartProc.jsp");
	if(str == 'cf'){
		form.mn.value = 'smoothie';
	}
	else if(str == 'ade'){
		form.mn.value = 'smoothie';
	}
	else if(str == 'smt'){
		form.mn.value = 'smoothie';
	}
	else if(str == 'bt'){
		form.mn.value = 'smoothie';
	}
	else if(str == 'bd'){
		form.mn.value = 'smoothie';
	}
	else if(str == 'pay'){
		form.mn.value = 'smoothie';
	}
	form.submit();
} 
</script>
<title>스무디 화면</title>
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

	<form id="smoothieForm" name="smoothieForm" method="POST">
	<!-- 	현재 메뉴가 무엇인지 -->
	<input type="hidden" id="mn" name="mn" value="" />
	<!-- 	선택한 다음페이지가 무엇인지 -->
	<input type="hidden" id="nextMn" name="nextMn" value="" />
	<input type="hidden" id="idx" name="idx" value="<%=idx%>" />
	<input type="hidden" id="today" name="today" value=<%=td %> />
	<input type="hidden" id="selected_smt" name="selected_smt" value="" />
	<input type="hidden" id="smtFee" name="smtFee" value="" />
	<input type="hidden" id="smt_cnt" name="smt_cnt" value="" />
	<input type="hidden" id="smt_fee" name="smt_fee" value="" />
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
			<td><img src="../image/SmoothiePicture/녹차스무디.jpg" width=200 height=200></td>
			<td><img src="../image/SmoothiePicture/망고스무디.jpg" width=200 height=200></td>
			<td><img src="../image/SmoothiePicture/딸기스무디.jpg" width=200 height=200></td>
		</tr> 
		<tr align="center"> 
			<td>녹차 스무디</td>
			<td>망고 스무디</td>
			<td>딸기 스무디</td>
		</tr> 
		<tr align="center">
				<td><input type="text" id="sell_price1" name="sell_price1" id="one"value="5500" readonly></td>
				<td><input type="text" id="sell_price2" name="sell_price2" id="two" value="5000" readonly></td>
				<td><input type="text" id="sell_price3" name="sell_price3" id="three" value="5500" readonly></td>
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
			<td><img src="../image/SmoothiePicture/요거트스무디.jpg" width=200 height=200></td>
			<td><img src="../image/SmoothiePicture/체리스무디.jpg" width=200 height=200></td>
		</tr> 
		<tr align="center"> 
			<td>요거트 스무디</td>
			<td>체리 스무디</td>
		</tr> 
		<tr align="center">
				<td><input type="text" id="sell_price4" name="sell_price4" id="one"value="6000" readonly></td>
				<td><input type="text" id="sell_price5" name="sell_price5" id="two" value="6000" readonly></td>
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
         
      </table>
   </div>   
    <input type="button" id="reset" name="reset" value="초기화" onClick="resetCart(); return false;">
	    <button type="button" onclick="TotalFee(); return false;">가격보기</button> <br><br>
	<!-- <button type="button" onClick="TotalFee();">
		결제하기</button>  <br><br> -->
	<div id="Total" >
      <table>
         <tbody id="TotalFee">
         
         </tbody>
		</table>
		</div>
	</form>
</body>
</html>