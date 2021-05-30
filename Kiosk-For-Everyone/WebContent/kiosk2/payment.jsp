<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% 
	int idx = (int)request.getAttribute("idx");
	System.out.println(idx + "    결제창에서 idx잡기!!");
	request.setAttribute("idx", idx);
	String td = (String)request.getAttribute("today");
	System.out.println(idx + "   결제창에서 날짜찾기!!");
	request.setAttribute("idx", idx);
	request.setAttribute("today", td);
	request.setCharacterEncoding("UTF-8"); //한글처리
%>
<link rel="stylesheet" type="text/css" href="../css/pay.css"/>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body>
<br><br><br><br><br><br><br><br><br><br>
<img id="start" src="../image/Thankyou.jpg" border="0" width="800px" height="800px">
	<jsp:useBean id="payCtrl" class="CafeKiosk.payController"/>
	<jsp:useBean id="a1" class="CafeKiosk.kioskController"/>
	<jsp:useBean id="a2" class="CafeKiosk.kioskController"/>
	<jsp:useBean id="a3" class="CafeKiosk.kioskController"/>
	<jsp:useBean id="a4" class="CafeKiosk.kioskController"/>
	<jsp:useBean id="a5" class="CafeKiosk.kioskController"/>
	<c:set var="pay" value="<%=payCtrl.paymentControll(request) %>"/> 
	<c:set var="ab" value="<%=a1.CoffeeList(request) %>"/>
	<c:set var="bc" value="<%=a2.AdeList(request) %>"/> 
	<c:set var="cd" value="<%=a3.SmoothieList(request) %>"/> 
	<c:set var="de" value="<%=a4.BottleList(request) %>"/> 
	<c:set var="ef" value="<%=a5.BreadList(request) %>"/> 
		<div id="cartList">
	      <table>
	         <tbody id="cartBody">
	             <tr style="width:100%;" >
					<td style="text-align:center; width:10%;">주문번호</td><br>
					<td style="text-align:center; width:10%;">날짜</td><br>
					<td style="text-align:center; width:10%;">최종가격</td><br>
					<!-- <td style="text-align:center; width:10%;">커피가격</td>
					<td style="text-align:center; width:10%;">에이드가격</td>
					<td style="text-align:center; width:10%;">스무디가격</td>
					<td style="text-align:center; width:10%;">병음료 가격</td>
					<td style="text-align:center; width:10%;">빵가격</td> -->
				</tr>
				<tr>
					<c:forEach var="ls" items="${pay}">
					 	<td style="text-align:center;width:10%;">${ls.get("IDX")}</td>
						<td style="text-align:center;width:10%;">${ls.get("TODAY")}</td>
						<td style="text-align:center;width:10%;">${ls.get("TOTAL")}</td>
					<%-- 	<td style="text-align:center;width:12%;">${ls.get("CF_SUM")}</td>
						<td style="text-align:center;width:12%;">${ls.get("ADE_SUM")}</td>
						<td style="text-align:center;width:12%;">${ls.get("SMT_SUM")}</td>
						<td style="text-align:center;width:12%;">${ls.get("BT_SUM")}</td>
						<td style="text-align:center;width:12%;">${ls.get("BRD_SUM")}</td> --%>
					</c:forEach>                     
				</tr>
			</tbody>
		</table>
	</div> <br><br><br>
	<input type="button" id="pay_card" name="reset" value="결제하기" >
	<input type="button" id="pay_samsung" name="reset" value="samsung Pay">
</body>