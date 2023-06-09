<!DOCTYPE html>
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="<c:url value ="/assets/css/re-admin-order3.css"/>">
<link rel="stylesheet"
	href="<c:url value='/assets/css/admin-login.css'/>">
<link rel="stylesheet"
	href="<c:url value='/assets/css/re-search3.css'/>">
<link rel="stylesheet"
	href="<c:url value='/assets/css/re-message.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/css/re-admin3.css'/>">
<link rel="stylesheet"
	href="<c:url value='/assets/css/dashboard-shipper2.css'/>">
<link rel="stylesheet"
	href="<c:url value='/assets/css/admin.css'/>">
	<link rel="stylesheet"
	href="<c:url value='/assets/css/message.css'/>">
<c:if test="${ management == 'true' }">
	<title>Delivery :)</title>
</c:if>

<c:if test="${ orderdetails == 'true' }">
	<title>Order details :)</title>
	<style>
th#date {
	min-width: 105px;
}

.table-order thead {
	background-color: white;
}

.table-product-order-edit {
	max-height: 250px !important;
	overflow-y: scroll;
}

div#customer-infor-form div {
	float: right;
	display: flex;
	width: 98.3%;
	justify-content: right;
	font-size: 20px;
	align-items: center;
	font-weight: bold;
	color: black;
}

p#total {
	margin-left: 20px;
	color: #ff4200;
	font-size: 32px;
	font-weight: bold;
	margin-top: 4px;
}
</style>
</c:if>

<style>
.btn-details-order {
	background-color: purple !important;
}

.status-input {
	width: 100% !important;
	min-width: 200px;
}

.btn-confirm {
	background-color: #0086ff;
	border: 0;
	width: 32px;
	height: 32px;
	border-radius: 5px 0 0 5px;
	box-shadow: -1px 0 2px #29333f;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: 10px;
}

.btn-confirm img {
	width: 80%;
}

.message input {
	width: unset !important;
	height: unset !important;
}

.selected-order {
	width: 100% !important;
	height: 28px;
	padding: 0px 5px 0 5px;
	border: 0;
	font-size: 18px;
	border-left: 2px solid #0086ff;
	min-width: 200px;
}

div#status-select {
	width: 37.2%;
}
.admin-qrcode-icon img {
	width: 100%;
}

.admin-qrcode-icon {
	cursor: pointer;
	position: absolute;
	right: 290px;
	width: 50px;
	height: 50px;
	top: 8px;
}
</style>

<body>
	<%
	if (session.getAttribute("shipperID") == null) {
		response.sendRedirect("/SpringMVC/shipper/login");
	}
	%>
	<jsp:include page="../layouts/shipper/s-header.jsp"></jsp:include>
	<div class="admin-body">
		<jsp:include page="../layouts/shipper/nav.jsp"></jsp:include>
		<!-- ORDER MANAGEMENT -->

		<c:if test="${ management == 'true' }">
			<section class="admin-order-management">
				
				<div class="title title-order-management">
					<img
						src="<c:url value="/assets/images/icons/icons8-calendar-96.png"/>"
						alt="">
					<h1>ORDER MANAGEMENT</h1>
				</div>
		</c:if>

		<c:if test="${ orderdetails == 'true' }">
			<section class="admin-order-management">
				<div class="title title-edit-new">
					<img
						src="<c:url value="/assets/images/icons/icons8-eye-64-title.png"/>"
						alt="">
					<h1>ORDER DEATAILS</h1>
				</div>
		</c:if>

		<c:if test="${ management == 'false' && orderdetails == 'false' }">
			<section class="admin-order-management importantNone">
		</c:if>


		<div class="nav-history">
			<div class="origin">
				<img
					src="<c:url value="/assets/images/icons/icons8-home-page-64.png"/>"
					alt=""> <a href="/SpringMVC/shipper">Home</a>
			</div>
			<div>
				<p>/</p>
				<img
					src="<c:url value="/assets/images/icons/icons8-purchase-order-100-nav.png"/>"
					alt=""> <a href="">Order</a>
			</div>

			<div>
				<p>/</p>
				<img
					src="<c:url value="/assets/images/icons/icons8-calendar-96.png"/>"
					alt=""> <a href="/SpringMVC/shipper/order-management">Management</a>
			</div>

			<c:if test="${ orderdetails == 'true' }">
				<div class="editnewordershipper-nav">
					<p>/</p>
					<img
						src="<c:url value="/assets/images/icons/icons8-eye-64-title.png"/>"
						alt=""> <a href="">Order details</a>
				</div>
			</c:if>

		</div>
		<c:if test="${ management == 'true' }">
			<div class="table-order table-order-add">
		</c:if>
		<c:if test="${ management == 'false' }">
			<div class="table-order table-order-add importantNone">
		</c:if>
		<table class="order">
			<thead>
				<tr>
					<th>ID</th>
					<th>Full name</th>
					<th>Email</th>
					<th>Phone number</th>
					<th style="min-width: 150px;">Address</th>
					<th id="date" style="min-width: 105px;">Order date</th>
					<th>Note</th>
					<th style="text-align: center;">Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="liOrder" items="${ listOrder }" varStatus="index">
					<tr>
						<c:if
							test="${ liOrder.status.id == 2 || liOrder.status.id == 3 || liOrder.status.id == 4 }">
							<c:if test="${ liOrder.request == 0 }">
								<td>${ liOrder.id }</td>
								<td>${ liOrder.fullname }</td>
								<td>${ liOrder.email }</td>
								<td>${ liOrder.phone_number }</td>
								<td>${ liOrder.address }</td>
								<td>${ liOrder.order_date }</td>
								<td>${ liOrder.note }</td>

								<td class="td-action">
									<button class="btn-confirm-order" id="${ liOrder.id }">
										<img
											src="<c:url value="/assets/images/icons/icons8-done-64.png"/>"
											alt="">
									</button>
									<button class="btn-details-order" id="${liOrder.id }">
										<img
											src="<c:url value="/assets/images/icons/icons8-eye-64.png"/>"
											alt="">
									</button>
								</td>
							</c:if>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<c:if test="${ orderdetails == 'false' }">
		<div class="edit-new-order-form importantNone">
	</c:if>
	<c:if test="${ orderdetails == 'true'}">
		<div class="edit-new-order-form">
	</c:if>

	<div class="customer-infor">

		<div class="customer-infor-form">
			<div class="id">
				<p>ID</p>
				<input type="text" value="${ orderById.id }" readonly>
			</div>
			<div class="id">
				<p>Discount</p>
				<input type="text" value="${ orderById.discount_at }" readonly>
			</div>
			<div class="address">
				<p>Voucher</p>
				<input type="text" value="${ orderById.voucher.code }" readonly>
			</div>
			<div class="id">
				<p>Bill</p>
				<input type="text" value="${ orderById.bill }" readonly>
			</div>
			<div class="phone-number">
				<p>Method</p>
				<input type="text" value="${ orderById.method }" readonly>
			</div>
		</div>
		<div class="customer-infor-form">
			<div class="fullname">
				<p>Full name</p>
				<input type="text" value="${ orderById.fullname }" readonly>
			</div>
			<div class="email">
				<p>Email</p>
				<input type="text" value="${ orderById.email }" readonly>
			</div>
			<div class="phone-number">
				<p>Phone number</p>
				<input type="text" value="${ orderById.phone_number }" readonly>
			</div>
			<div class="address">
				<p>Status</p>
				<input type="text" value="${ orderById.status.status_name }"
					readonly>
			</div>
			<div class="id">
				<p>Note</p>
				<input type="text" value="${ orderById.note }" readonly>
			</div>
		</div>

		<c:if test="${ orderdetails == 'true'}">
			<div class="customer-infor-form">
				<div class="id" id="status-select">
					<p>Address</p>
					<input class="status-input" type="text"
						value="${ orderById.address }" readonly>
				</div>
				<div class="fullname">
					<p>Order date</p>
					<input type="text" value="${ orderById.order_date }" readonly>
				</div>
				<div class="email">
					<p>Updated at</p>
					<input type="text" value="${ orderById.updated_at }" readonly>
				</div>
				<div class="id">
					<p>Request</p>
					<input type="text" value="Not delivery" readonly>
				</div>
			</div>
		</c:if>
		<div class="customer-infor-form table-product-order-edit">
			<table class="order product-order">
				<thead>
					<tr>
						<th></th>
						<th>Name</th>
						<th>Price</th>
						<th class="td-display-center">Color</th>
						<th class="td-display-center">Size</th>
						<th class="td-display-center">Quantity</th>

					</tr>
				</thead>
				<tbody>
					<c:forEach var="liProdInOrder" items="${ orderDetailsById }"
						varStatus="index">
						<tr>
							<td class="td-img-product"><img
								src="<c:url value='/assets/images/products/${ liProdInOrder.prod.thumbnail }'/>"
								alt="img-prod"></td>

							<td>${ liProdInOrder.prod.title }</td>
							<td>$${ liProdInOrder.price_at }</td>

							<td class="td-display-center">${ liProdInOrder.color.color_name }</td>
							<td class="td-display-center">${ liProdInOrder.size.size_number }</td>
							<td class="td-display-center quantity-order">${ liProdInOrder.quantity }
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="customer-infor-form" id="customer-infor-form">
			<div>
				Total:
				<p id="total">$${ total }</p>
			</div>
		</div>



	</div>

	</div>
	<jsp:include page="../layouts/shipper/s-footer.jsp"></jsp:include>
	</section>

	</div>

	<div class="message msg-order message-notify none" id="message-notify">
		<h2 class="msg-h2">
			Message <img alt=""
				src="<c:url value="/assets/images/icons/icons8-notification-100-msg.png"/>">
		</h2>
		<p class="content-msg content-msg-notify">
			Are you sure you want to <b>countermand</b> this order?
		</p>
		<div class="btn-ok-cancel">
			<input class="cancel" id="cancel" type="button" value="Cancel">
			<input class="ok" id="ok-notify" type="button" value="OK">
		</div>
	</div>

	<div class="message none" id="take-order">
		<h2 class="msg-h2">
			Message <img alt=""
				src="<c:url value="/assets/images/icons/icons8-notification-100-msg.png"/>">
		</h2>
		<p class="content-msg"></p>
		<div class="btn-ok-cancel">
			<input class="ok" id="ok-notify" type="button" value="OK">
		</div>
	</div>

	<div class="msg-done importantNone">Done!</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


	<script type="text/javascript">
		var take_order = "";
		if(${ sessionScope.takeorder != null }) {
			take_order = "${sessionScope.takeorder}";
		}
		if(take_order == "true") {
			$("#take-order").removeClass("none");
			$("#take-order .content-msg").text("Order received successfully!");
			$('.ok').click(function() {
				$(".message-notify").addClass("none");
				var xhr = new XMLHttpRequest();
				xhr.open("GET", "/SpringMVC/shipper/order-management?ok");
				xhr.onload = function() {
					window.location.assign("/SpringMVC/shipper/order-management");
				};
				xhr.send();
			});
		}
		if(take_order == "false") {
			$("#take-order").removeClass("none");
			$("#take-order .content-msg").text("Order received unsuccess!");
			$('.ok').click(function() {
				$(".message-notify").addClass("none");
				var xhr = new XMLHttpRequest();
				xhr.open("GET", "/SpringMVC/shipper/order-management?ok");
				xhr.onload = function() {
					window.location.assign("/SpringMVC/shipper/order-management");
				};
				xhr.send();
			});
		}
	</script>

	<script>
		$('.cancel').click(function() {
			$(".message").addClass("none");
			location.reload();
		});
	</script>
	<script>
		$('.btn-confirm-order').click(function() {
			$(".message-notify").removeClass("none");
			$(".message-notify .content-msg").text("Are you sure you want to take this order?");
			var id_order = this.id;
			$('.ok').click(function() {
				$(".message-notify").addClass("none");
				var xhr = new XMLHttpRequest();
				xhr.open("GET", "/SpringMVC/shipper/order-management?id_order="+ id_order);
				xhr.onload = function() {
					window.location.assign("/SpringMVC/shipper/order-management");
				};
				xhr.send();
			});
		});
		$('.cancel').click(function() {
			$(".message").addClass("none");
		});
	</script>
	<script>
		$('.cancel').hover(function() {
			$(".ok").removeClass("hover-btn");
			$(".ok").removeClass("font-size-btn-msg");
			$(".cancel").addClass("hover-btn");
			$(".cancel").addClass("font-size-btn-msg");
		});
		$('.ok').hover(function() {
			$(".cancel").removeClass("hover-btn");
			$(".cancel").removeClass("font-size-btn-msg");
			$(".ok").addClass("hover-btn");
			$(".ok").addClass("font-size-btn-msg");
		});
	</script>
	<!-- ADD NEW ONCLICK-->
	<script>
		$('.editnewordershipper').click(
				function() {
					var id_order = this.id;
					var xhr = new XMLHttpRequest();
					xhr.open("GET", window.location.href + "/edit-order");
					// What to do when server responds
					xhr.onload = function() {
						window.location.assign(window.location.href
								+ "/edit-order?id_order=" + id_order);
					};
					xhr.send();
				});
		$('.btn-details-order').click(
				function() {
					var id_order = this.id;
					var xhr = new XMLHttpRequest();
					xhr.open("GET", window.location.href + "/order-details");
					// What to do when server responds
					xhr.onload = function() {
						window.location.assign(window.location.href
								+ "/order-details?id_order=" + id_order);
					};
					xhr.send();
				});
	</script>

</body>

</html>