<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Bill :)</title>
</head>

<link rel="stylesheet" href="<c:url value='/assets/css/bill.css'/>">
<style>
.barcode img {
    height: 100%;
    width: 100%;
}
.barcode {
    height: 36px;
    display: flex;
}
</style>

<body>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store");
	if (session.getAttribute("bill") != null) {
		String bill = String.valueOf(session.getAttribute("bill"));
		if (bill.equals("false")) {
			response.sendRedirect("/SpringMVC/admin/order-management");
		}
	}
	%>

	<div class="header">
		<div class="back">
			<img src="<c:url value="/assets/images/icons/back52.png"/>" alt="">
		</div>
		<div class="print">
			<img
				src="<c:url value="/assets/images/icons/icons8-send-to-printer-40.png"/>"
				alt="">
		</div>
	</div>
	<div class="wrap">
		<div class="wrapper">
			<div class="row row1">
				<div class="col logo">
					<img src="<c:url value="/assets/images/logo/result.png"/>" alt="">
				</div>
				<div class="col">
					<div class="barcode">
						<img
							src="<c:url value="/assets/images/barcode/${ orderById.barcode  }"/>"
							alt="">
					</div>
					<p>
						Bill of lading: <b>${ orderById.bill }</b>
					</p>

				</div>
			</div>
			<div class="row row2">
				<div class="col row2-col1">
					<h4>From:</h4>
					<p>Tishoes store</p>
					<p>Cong Hoa Village, Kim Thanh, Hai Duong</p>
					<p>TEL: 0346 643 755</p>
				</div>
				<div class="col row2-col2">
					<h4>To:</h4>
					<p>${ orderById.fullname }</p>
					<p>${ orderById.address }</p>
					<p>TEL: ${ orderById.phone_number }</p>
				</div>
			</div>
			<div class="row row3">
				<div class="col row3-col1">
					<h4>Description (QTY: 2)</h4>
					<c:forEach var="item" items="${ orderDetailsById }"
						varStatus="index">
						<p>${ index.getIndex() + 1 }.${ item.prod.title }, QTY: ${ item.quantity }</p>
					</c:forEach>
					<div class="note">
						<p>Note: Some products may be hidden due to the long list.</p>
					</div>
				</div>
				<div class="col row3-col2">
					<div class="qrcode">
						<img
							src="<c:url value="/assets/images/qrcode/${ orderById.qrcode  }"/>"
							alt="">
					</div>
					<div class="order-date">
						<p>Order date:</p>
						${ orderById.order_date }
					</div>
				</div>
			</div>
			<div class="row-1">
				<div class="col row-1-col1">
					<p>Total payment</p>
					<h1>$${ total }</h1>
				</div>
				<div class="col row-1-col2">
					<div class="signature">
						<h3>Consignee's signature</h3>
						<p>Confirm the goods are intact</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(".back").click(function () {
		history.back();
	});
</script>
<script type="text/javascript">
	var id_order="";
	if(${ orderid != null }) {
		id_order = "${ orderid }";
	}
	$(".print").click(function () {
		if(id_order != "") {
			var xhr = new XMLHttpRequest();
			xhr.open("GET", "/SpringMVC/admin/order-management?id_order="
					+ id_order
					+ "&status=2&endbill");
			xhr.onload = function() {
				window.location.assign("/SpringMVC/admin/order-management");
			};
			xhr.send();
		}
	});
</script>
</html>