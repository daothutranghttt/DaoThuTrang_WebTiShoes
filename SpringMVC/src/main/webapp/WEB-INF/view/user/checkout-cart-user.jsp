<!DOCTYPE html>
<html lang="en">
<title>Checkout :)</title>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="<c:url value="/assets/css/checkoutcart.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/bootstrap.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/js/bootstrap.js"/>">
<link rel="stylesheet"
	href="<c:url value="/assets/css/bootstrap.min.css"/>">
<link rel="stylesheet"
	href="<c:url value="/assets/js/bootstrap.min.js"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/login.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/color.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/message.css"/>">
<link rel="stylesheet"
	href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />">
	<link rel="stylesheet"
	href="<c:url value="/assets/css/voucher1234.css"/>">
<style>

.payment-method, .order, .customer-info {
    height: 540px;
}
.products-checkout {
    max-height: 240px;
}
.none {
	display: none;
}

div#avatar-user img {
	width: 80px;
	height: 80px;
	margin-top: 10px;
	border-radius: 50px;
}

input.cancel, input.ok {
	width: 120px;
}

input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

/* Firefox */
input[type=number] {
	-moz-appearance: textfield;
}

input#phone {
	font-size: 20px !important;
}

.input-voucher {
	display: flex;
	width: unset;
}

.input-voucher img {
	height: 24px;
}

.voucher {
	justify-content: space-between;
}

.input-voucher {
	cursor: pointer;
}

.input-voucher:hover {
	color: #0086ff;
}

.input-voucher p {
	text-decoration: underline;
	text-underline-offset: 2px;
}

.disable {
	opacity: .5;
}
</style>
<body>
	<form action="/SpringMVC/cart/checkout/user-cart/${ id }" method="post"
		id="myform">
		<div class="nav">
			<c:set var="item" value="${ back_home }"></c:set>
			<c:if test="${ item == 'home'}">
				<div class="back">
					<a href="/SpringMVC"><img
						src="<c:url value="/assets/images/icons/back52.png"/>"
						alt="back-icon">Back</a>
				</div>
			</c:if>
			<c:if test="${ item == 'cart'}">
				<div class="back">
					<a href="/SpringMVC/cart/${ user.id }"><img
						src="<c:url value="/assets/images/icons/back52.png"/>"
						alt="back-icon">Back</a>
				</div>
			</c:if>
			<c:if test="${ user != null }">
				<div class="avt" id="avatar-user">
					<img src="<c:url value="/assets/images/users/${ user.avatar }"/>"
						alt="">
				</div>
			</c:if>
			<c:if test="${ user == null }">
				<div class="avt">
					<img src="<c:url value="/assets/images/users/avt-default.jpg"/>"
						alt="">
				</div>
			</c:if>
			<c:if test="${ user != null }">
				<div class="login none">
					<div class="container-xl icon-user">
						<button type="button" class="icon-user btn btn-primary"
							data-toggle="modal" data-target="#login">
							<img class="icon-user"
								src="<c:url value="/assets/images/icons/user48.png"/>"
								alt="icon-user">
						</button>
						<div class="modal fade" id="login" tabindex="-1" role="dialog"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<button type="button" class="btn btn-secondary close"
										data-dismiss="modal">
										<img class="close-login-icon"
											src="<c:url value="/assets/images/icons/close48.png"/>"
											alt="icon-close" width="32px">
									</button>
									<div class="login_form_container">
										<div class="login_form">
											<h2>Login</h2>
											<div class="input_group">
												<i class="fa fa-user"></i> <input type="text"
													placeholder="Username" class="input_text"
													autocomplete="off" />
											</div>
											<div class="input_group">
												<i class="fa fa-unlock-alt"></i> <input type="password"
													placeholder="Password" class="input_text"
													autocomplete="off" />
											</div>
											<div class="button_group" id="login_button">
												<a>Login</a>
											</div>
											<div class="fotter">
												<a>Forgot Password ?</a> <a>SingUp</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${ user == null }">
				<div class="login">
					<div class="container-xl icon-user">
						<button type="button" class="icon-user btn btn-primary"
							data-toggle="modal" data-target="#login">
							<img class="icon-user"
								src="<c:url value="/assets/images/icons/user48.png"/>"
								alt="icon-user">
						</button>
						<div class="modal fade" id="login" tabindex="-1" role="dialog"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<button type="button" class="btn btn-secondary close"
										data-dismiss="modal">
										<img class="close-login-icon"
											src="<c:url value="/assets/images/icons/close48.png"/>"
											alt="icon-close" width="32px">
									</button>
									<div class="login_form_container">
										<div class="login_form">
											<h2>Login</h2>
											<div class="input_group">
												<i class="fa fa-user"></i> <input type="text"
													placeholder="Username" class="input_text"
													autocomplete="off" />
											</div>
											<div class="input_group">
												<i class="fa fa-unlock-alt"></i> <input type="password"
													placeholder="Password" class="input_text"
													autocomplete="off" />
											</div>
											<div class="button_group" id="login_button">
												<a>Login</a>
											</div>
											<div class="fotter">
												<a>Forgot Password ?</a> <a>SingUp</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
		</div>
		<div class="checkout">
			<!-- Consignee information -->
			<div class="customer-info">
				<h4>Consignee information</h4>
				<div class="name-customer">
					<input type="text" id="fullname" name="fullname"
						value="${ user.fullname }" placeholder="Full name">
				</div>
				<div class="phone-customer">
					<input type="number" id="phone" name="phone"
						value="${ user.phone_number }" placeholder="Phone number" min="0">
				</div>
				<div class="mail-customer">
					<input type="text" id="email" name="email" value="${ user.email }"
						placeholder="Email">
				</div>
				<div class="city-customer">
					<input type="text" id="city" name="city" value="${ city }"
						placeholder="City">
				</div>
				<div class="town-customer">
					<input type="text" id="town" name="town" value="${ town }"
						placeholder="Town">
				</div>
				<div class="village-customer">
					<input type="text" id="village" name="village" value="${ village }"
						placeholder="Village">
				</div>
				<div class="note-customer">
					<textarea id="note" name="note" placeholder="Note"></textarea>
				</div>
			</div>

			<!-- Payment methods -->
			<div class="payment-method">
				<h4>Shipping methods</h4>
				<div class="shipping" id="radio1">
					<input type="radio" name="Delivery" id="rad1" checked>
					<div>&emsp;Delivery to your place</div>
					<div>&emsp;&emsp;&emsp;$11.00</div>

				</div>
				<div class="content-sm" id="content-sm">Buy products over $50
					will get free shipping</div>

				<h4 class="pm">Payment methods</h4>
				<div class="shipping" id="radio2" onclick="radio(this)">
					<input type="radio" name="paymentmethods" id="rad2" value="COD"
						checked>
					<div class="icon-cod">
						&emsp;Payment on delivery (COD) <img
							src="<c:url value="/assets/images/icons/cash-on-delivery.png"/>"
							alt="">
					</div>
				</div>
				<div class="content-pm" id="content-pm" style="visibility: visible;">You
					only have to pay when you receive the goods.</div>
				<div class="shipping" id="radio3" onclick="radio(this)">
					<input type="radio" name="paymentmethods" id="rad3"
						value="payByCard">
					<div class="icon-credit">
						&emsp; Pay by credit card <img
							src="<c:url value="/assets/images/icons/credit-card.png"/>"
							alt="">
					</div>
				</div>
				<div class="content-bank none" id="content-bank"
					style="visibility: visible;">
					<div>Choose a</div>
					<div class="bank">
						<div class="bank" id="Paypal" onclick="bank(this)">
							<img
								src="<c:url value="/assets/images/icons/icons8-paypal-96.png"/>"
								alt="">
						</div>
					</div>
				</div>
			</div>

			<!-- Order -->
			<div class="order">

				<input type="hidden" name="id_prod" id="id_prod"
					value="${ prod_checkout.id }">
				<h4>Order information</h4>

				<div class="products-checkout">
					<c:forEach var="cart" items="${ listCart }">
						<div class="list_prod_checkout">
							<div class="img-product-checkout">
								<img
									src="<c:url value="/assets/images/products/${ cart.color_size.prod.thumbnail }"/>"
									alt="">
							</div>
							<table>
								<tr>
									<th colspan="2">${ cart.color_size.prod.title }</th>
								</tr>
								<tr>
									<td colspan="2">${ cart.color_size.color.color_name }-${ cart.color_size.size.size_number }</td>
								</tr>
								<tr>
									<c:if test="${ cart.color_size.prod.discount > 0 }">
										<th class="price"><b> $<fmt:formatNumber
													type="number" maxFractionDigits="2"
													value="${ cart.color_size.prod.price - cart.color_size.prod.price * cart.color_size.prod.discount/100 }" />
										</b></th>
									</c:if>
									<c:if test="${ cart.color_size.prod.discount <= 0 }">
										<th class="price"><b> $<fmt:formatNumber
													type="number" maxFractionDigits="2"
													value="${ cart.color_size.prod.price }" />
										</b></th>
									</c:if>
									<td class="amount"><i>x${ cart.quantity }</i></td>
								</tr>
							</table>
						</div>
						<input type="hidden" class="prod-id"
							id="${ cart.color_size.prod.id }" name="${ cart.quantity }">
					</c:forEach>
				</div>

				<div class="voucher">
					<div class="input-voucher">
						<img
							src="<c:url value="/assets/images/icons/icons8-voucher-64.png"/>"
							alt="images-order"> Shop voucher
					</div>
					<div class="input-voucher">
						<p>Select or enter a voucher</p>
						&nbsp;<b>></b>
					</div>
				</div>
				
				<hr>
				<div class="calculator">
					<table>
						<tr>
							<td class="txt">
								<div class="total-products-cost">Total products cost</div>
							</td>
							<td class="price"><b>$<fmt:formatNumber type="number"
										maxFractionDigits="2" value="${ total }" /></b></td>
						</tr>
						<tr>
							<td class="txt">
								<div class="shipping-chargers">Shipping charges</div>
							</td>
							<td class="price"><b>$11.00</b></td>
						</tr>
						<c:if test="${ total >= 50.0 }">
							<tr>
								<td class="txt">
									<div class="shipping-chargers">Free ship</div>
								</td>
								<td class="price-free"><b>-$11.00</b></td>
							</tr>
						</c:if>
						<c:if test="${ vcdiscount != null }">
							<tr>
								<td class="txt">
									<div class="shipping-chargers">Voucher</div>
								</td>
								<td class="price-free"><b>-${ vcdiscount }</b></td>
							</tr>
						</c:if>
						<tr>
							<td colspan="2">
								<hr>
							</td>
						</tr>
						<c:if test="${ total >= 50.0 }">
							<c:set var="fee" value="${ 0 }"></c:set>
						</c:if>
						<c:if test="${ total < 50.0 }">
							<c:set var="fee" value="${ 11.0 }"></c:set>
						</c:if>
						<tr>
							<td class="txt">
								<div class="total-payment-calculator">
									<span class="txt-total-payment">Total payment</span>
								</div>
							</td>
							<c:if test="${ vcdiscount != null }">
								<td class="price"><span class="total-payment"> <b>$<fmt:formatNumber
												type="number" maxFractionDigits="2"
												value="${ total + fee - vcdiscount }" />
									</b>
								</span></td>
							</c:if>
							<c:if test="${ vcdiscount == null }">
								<td class="price"><span class="total-payment"> <b>$<fmt:formatNumber
												type="number" maxFractionDigits="2" value="${ total + fee }" />
									</b>
								</span></td>
							</c:if>
						</tr>
					</table>
				</div>
			</div>
			<!--  end div class order -->
		</div>
		<!--  end div class checkout -->
		<div class="btn-order">
			<input type="button" name="order" id="order" value="Order">
		</div>
		<input type="hidden" name="cartid" value="${ id }">
		<input type="hidden" name="vchid" id="vchid" value="${ vchid }">
		<input type="hidden" name="total" id="total" value="${ total }">
		<input type="hidden" name="userid" id="userid" value="${ user_id }">
		
		<c:if test="${ vchprice != null }">
			<input type="hidden" name="vchprice" id="vchprice"
				value="${ vchprice }">
		</c:if>
		<c:if test="${ vchprice == null }">
			<input type="hidden" name="vchprice" id="vchprice" value="0">
		</c:if>
	</form>
	
	<div class="wrap-vc none" id="wrap-vc"></div>
	<div class="list-vch none" id="list-vch">
		<div class="close-vch">
			<div>Voucher</div>
			<img id="close-vch" alt=""
				src="<c:url value="/assets/images/icons/icons8-close-60.png"/>">
		</div>

		<div class="vc-list">
			<c:forEach var="it" items="${ listVoucher }" varStatus="index">
				<c:if test="${ it.value == 1  }">
					<div class="vc-ele disable">
				</c:if>
				<c:if test="${ it.value == 0  }">
					<c:if test="${ it.key.voucher.applyfor <= limit }">
						<div class="vc-ele">
					</c:if>
					<c:if test="${ it.key.voucher.applyfor > limit }">
						<div class="vc-ele disable">
					</c:if>
				</c:if>
				<div class="vc-discount">${ it.key.voucher.vcdiscount }%</div>
				<div class="vc-content">
					<div>
						Apply for orders from <span id="price-vc">$${
							it.key.voucher.applyfor }</span>
					</div>
					<div>Applies to all products</div>
					<c:if test="${ it.value == 0 }">
						<fmt:parseDate value="${ it.key.voucher.end_date }"
							pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime" type="both" />
						<div style="color: red;">
							Expires: <b> <fmt:formatDate pattern="HH:mm"
									value="${ parsedDateTime }" />
							</b> day <b> <fmt:formatDate pattern="dd/MM/yyyy"
									value="${ parsedDateTime }" />
							</b>
						</div>
					</c:if>
					<c:if test="${ it.value == 1 }">
						<fmt:parseDate value="${ it.key.voucher.start_date }"
							pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime" type="both" />
						<c:if
							test="${ parsedDateTime.hours==0 && parsedDateTime.minutes==0 }">
							<div>
								EXP: <b> <fmt:formatDate pattern="dd/MM/yyyy"
										value="${ parsedDateTime }" />
								</b>
							</div>
						</c:if>
						<c:if
							test="${ parsedDateTime.hours!=0 || parsedDateTime.minutes!=0 }">
							<div>
								EXP: <b> <fmt:formatDate pattern="HH:mm"
										value="${ parsedDateTime }" />
								</b> day <b> <fmt:formatDate pattern="dd/MM/yyyy"
										value="${ parsedDateTime }" />
								</b>
							</div>
						</c:if>
					</c:if>
				</div>
				<div class="vc-radio-btn">
					<c:if test="${ it.value == 0  }">
						<c:if test="${ it.key.voucher.applyfor <= limit }">
							<c:if test="${ vcid != null }">
								<c:if test="${ vcid == it.key.voucher.id }">
									<span class="vch-radio selected-vc" id="${ it.key.voucher.id }"> <img
										id="close-vch" alt=""
										src="<c:url value="/assets/images/icons/icons8-done-64.png"/>">
									</span>
								</c:if>
								<c:if test="${ vcid != it.key.voucher.id }">
									<span class="vch-radio" id="${ it.key.voucher.id }"> <img
										id="close-vch" alt=""
										src="<c:url value="/assets/images/icons/icons8-done-64.png"/>">
									</span>
								</c:if>
							</c:if>
							<c:if test="${ vcid == null }">
								<span class="vch-radio" id="${ it.key.voucher.id }"> <img
									id="close-vch" alt=""
									src="<c:url value="/assets/images/icons/icons8-done-64.png"/>">
								</span>
							</c:if>
						</c:if>
						<c:if test="${ it.key.voucher.applyfor > limit }">
							<span class="vch-radio radio-disable" id="${ it.key.voucher.id }"> <img
								id="close-vch" alt=""
								src="<c:url value="/assets/images/icons/icons8-done-64.png"/>">
							</span>
						</c:if>
					</c:if>
					<c:if test="${ it.value == 1  }">
						<span class="vch-radio radio-disable" id="${ it.key.voucher.id }">
							<img id="close-vch" alt=""
							src="<c:url value="/assets/images/icons/icons8-done-64.png"/>">
						</span>
					</c:if>
				</div>
		</div>
		</c:forEach>
	</div>
	<div class="apply-vc">
		<button type="button" id="applyvch" name="applyvch">Apply</button>
	</div>
	</div>

	<div class="message msg-order message-notify none" id="message-notify">
		<h2 class="msg-h2">
			Message <img alt=""
				src="<c:url value="/assets/images/icons/icons8-notification-100-msg.png"/>">
		</h2>
		<p class="content-msg content-msg-notify"></p>
		<div class="btn-ok-cancel">
			<input class="cancel" id="cancel" type="button" value="Cancel">
			<input class="ok" id="ok-notify" type="button" value="OK">
		</div>
	</div>
	<div class="message msg-order message-done none" id="message-done">
		<h2 class="msg-h2">
			Message <img alt=""
				src="<c:url value="/assets/images/icons/icons8-notification-100-msg.png"/>">
		</h2>
		<p class="content-msg content-msg-done" id="content-msg-done"></p>
		<div class="btn-ok-cancel">
			<input class="ok" id="ok-done" type="button" value="OK">
		</div>
	</div>

	<div class="wrapper importantNone" id="wrapper">
		<div class="message message-notify none" id="message-notify">
			<h2 class="msg-h2">
				Message <img alt=""
					src="<c:url value="/assets/images/icons/icons8-notification-100-msg.png"/>">
			</h2>
			<p class="content-msg" id="content-msg-notify"></p>
			<div class="btn-ok-cancel">
				<input class="ok hover-btn" id="ok-voucher" type="button" value="OK">
			</div>
		</div>
	</div>

	<script>
		var a = document.getElementById("rad2");
		if (a.checked == true) {
			document.getElementById("content-pm").style.visibility = "visible";
			document.getElementById("radio3").style.marginTop = "30px";
		}
		function bank(x) {
			alert(x.id);
		}
	</script>

	<script>
	$("#content-pm").removeClass("none");
	function radio(x) {
		if(x.id == "radio2") {
			document.getElementById("rad2").checked = true;
			$("#content-pm").removeClass("none");
			$("#content-bank").addClass("none");
		} else if(x.id == "radio3") {
			document.getElementById("rad3").checked = true;
			$("#content-pm").addClass("none");
			$("#content-bank").removeClass("none");
		}
		
	}
	</script>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	
	<script type="text/javascript">
		$("#applyvch").click(function() {
			$("#wrap-vc").toggleClass("none");
			$("#list-vch").toggleClass("none");
			
			const arr = document.getElementsByClassName("vch-radio");
			for (let i=0; i<arr.length; i++) {
				var cls = $(arr[i]).attr('class');
				if(cls.includes("selected-vc")) {
					var url = window.location.href;
					var txt="";
					if(url.includes("?vchid")) {
						const arr1 = url.split("?");
						var vchid = arr1[1].split("&")[0];
						txt = url.replace(vchid, "vchid="+arr[i].id);
					} else if(url.includes("&vchid")) {
						var arr1 = url.split("&");
						for (let j=0; j<arr1.length; j++) {
							if(arr1[j].includes("vchid")) {
								txt = url.replace(arr1[j], "vchid="+arr[i].id);
							}
						}
					} else if(!url.includes("vchid") && url.includes("?")) {
						txt = url + "&vchid=" + arr[i].id;
					} else {
						txt = url + "?vchid=" + arr[i].id;
					}
					var xhr = new XMLHttpRequest();
					xhr.open("GET", "");
					xhr.onload = function() {
						window.location.assign(txt);
					};
					xhr.send();
				}
			}
		});
	</script>

	<script type="text/javascript">
		$("#close-vch").click(function() {
			$("#wrap-vc").toggleClass("none");
			$("#list-vch").toggleClass("none");
		});
	</script>

	<script type="text/javascript">
		$(".input-voucher").click(function() {
			$("#wrap-vc").toggleClass("none");
			$("#list-vch").toggleClass("none");
		});
	</script>

	<script type="text/javascript">
		$(".vch-radio").click(function() {
			var id = this.id;
			var check = this.className;
			if(!check.includes("disable")) {
				const arr = document.getElementsByClassName("vch-radio");
				for (let i=0; i<arr.length; i++) {
					if(arr[i].id == id) {
						$(arr[i]).toggleClass("selected-vc");
					} else {
						$(arr[i]).removeClass("selected-vc");
					}
				}
			}
		});
	</script>

	<script type="text/javascript">
		$("#ok-done").click(function() {
			$("#message-done").addClass("none");
		});
		$("#ok-voucher").click(function() {
			$("#wrapper #message-notify").addClass("none");
		});
		$("#cancel").click(function() {
			$("#message-notify").addClass("none");
		});
	</script>

	<script type="text/javascript"> //message voucher status
		if(${vcstatus != null}) {
			var status = "${ vcstatus }";
			if(status == "outofdate" ) {
				$("#wrapper").removeClass("importantNone");
				$("#wrapper #message-notify").removeClass("none");
				$("#wrapper #content-msg-notify").text("Sorry! The event has ended.");
			}
			if(status == "notstartedyet" ) {
				$("#wrapper").removeClass("importantNone");
				$("#wrapper #message-notify").removeClass("none");
				$("#wrapper #content-msg-notify").text("Sorry! The event has not started yet.");
			}
			if(status == "notexists" ) {
				$("#wrapper").removeClass("importantNone");
				$("#wrapper #message-notify").removeClass("none");
				$("#wrapper #content-msg-notify").text("Sorry! Voucher does not exist.");
			}
			if(status == "notenough") {
				if(${ applyfor != null }) {
					$("#wrapper").removeClass("importantNone");
					$("#wrapper #message-notify").removeClass("none");
					var error = "Sorry! Voucher is only applicable for orders of ${ applyfor } or more.";
					$("#wrapper #content-msg-notify").text(error);
				}
			}
			if(status == "used" ) {
				$("#wrapper").removeClass("importantNone");
				$("#wrapper #message-notify").removeClass("none");
				$("#wrapper #content-msg-notify").text("Sorry! You have used this voucher.");
			}
			
		}
	</script>

	<script type="text/javascript">
		const validateEmail = (email) => {
		  	return email.match(
		    	/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
		  	);
		};
		$("#order").click(function() {
			var get = $(this);
			var fullname = $("#fullname").val();
			var email = $("#email").val();
			var phone = $("#phone").val();
			var city = $("#city").val();
			var town = $("#town").val();
			var village = $("#village").val();
			var method = document.getElementById("rad3").checked;
			
			var error = "";
			if(fullname == "") {
				error = "Full name is empty!";
			} else if(phone == "") {
				error = "Phone number is empty!";
			} else if(email == "") {
				error = "Email address is empty!";
			} else if(!validateEmail(email)) {
				error = "Invalid email format!";
			} else if(city == "") {
				error = "City is empty!";
			} else if(town == "") {
				error = "Town is empty!";
			} else if(village == "") {
				error = "Village is empty!";
			}
			if (error == "") {
				var status = "${ vcstatus }";
				if(status == "start" || status == null || status == "") {
					if(method == true) {
						var product = "";
						var liArr = document.querySelectorAll('.prod-id');
						for(let i=0; i<liArr.length; i++) {
							if(i==0) {
								product += liArr[i].id +"_"+liArr[i].name;
							} else {
								product += "/"+liArr[i].id +"_"+liArr[i].name;
							}
						}
						if(product != "") {
							$('#myform').attr('action', "/SpringMVC/authorize_payment?product="+product);
							$(get).attr("type", "submit");
						}
					} else {
						$(get).attr("type", "submit");
					}
				} else {
					var url = window.location.href;
					var xhr = new XMLHttpRequest();
					xhr.open("GET", "");
					xhr.onload = function() {
						window.location.assign(url.split("?")[0]);
					};
					xhr.send();
				}
			} else {
				$("#wrapper").removeClass("importantNone");
				$("#wrapper #message-notify").removeClass("none");
				$("#wrapper #content-msg-notify").text(error);
			}
		});
	</script>

	<script type="text/javascript">
		var url = window.location.href;
		$("#apply").click(
				function() {
					var vch = $('#voucher_code').val();
					if (vch == "" || vch == null) {
						$("#message-done").removeClass("none");
						$("#content-msg-done").text(
								"You have not entered the voucher!");
					} else {
						var url_new = "";
						if (url.includes("?")) {
							if(url.includes("?voucher")) {
								var arr1 = url.split("?")[1];
								var arr2 = arr1.split("&")[0];
								url_new = url.replace(arr2, "voucher="+vch);
							}
						} else {
							url_new = url + "?voucher=" + vch;
						}
						var xhr = new XMLHttpRequest();
						xhr.open("GET", "");
						xhr.onload = function() {
							window.location.assign(url_new);
						};
						xhr.send();
					}
				});
	</script>
	
	<script src="<c:url value="/assets/js/color.js" />" defer></script>
	<script src="js/login.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
</body>

</html>