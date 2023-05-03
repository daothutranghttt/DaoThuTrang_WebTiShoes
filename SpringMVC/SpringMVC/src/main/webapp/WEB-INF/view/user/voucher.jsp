<!DOCTYPE html>
<html lang="en">
<title>Voucher :)</title>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<c:url value="/assets/css/bootstrap.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/js/bootstrap.js"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/index.css"/>">
<link rel="stylesheet"
	href="<c:url value="/assets/css/bootstrap.min.css"/>">
<link rel="stylesheet"
	href="<c:url value="/assets/js/bootstrap.min.js"/>">
<link rel="stylesheet"
	href="<c:url value="/assets/https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/login.css"/>">
<link rel="stylesheet"
	href="<c:url value="/assets/css/swiper-bundle.min.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/slide.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/contact.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/home.css"/>">
<link rel="stylesheet"
	href='<c:url value="/assets/css/login-icon.css"/>'>

<link rel="stylesheet" href="<c:url value="/assets/css/products.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/zoom-img.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/navscroll.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/hearder.css"/>">
<style>
.ok-btn button {
	border: 1px solid;
	background: #0086ff;
	color: white;
	font-size: 20px;
	box-shadow: 0 0 5px #666;
}

.content-products {
	margin-top: 50px;
}

.welcome {
	box-shadow: 0px 5px 15px;
}

.voucher img {
	width: 100%;
}

.voucher {
	display: flex;
	width: 100%;
}

.vch-wrap {
	width: 80%;
	margin-left: 10%;
	margin-top: 40px;
}

.vch-ele {
	position: relative;
	background: white;
	width: 49%;
	height: 170px;
	display: flex;
	cursor: pointer;
}

.vch-ele-left {
	position: relative;
	height: 100%;
	display: flex;
}

span.half-circle-top, span.half-circle-bottom {
	display: flex;
	position: absolute;
	background: #0c1022;
	width: 26px;
	height: 14px;
	left: 62%;
}

span.half-circle-top {
	border-radius: 0 0 30px 30px;
	margin-top: -1px;
}

span.half-circle-bottom {
	border-radius: 30px 30px 0 0;
	bottom: 0;
	margin-bottom: -1px;
}

.vch-list {
	display: flex;
	justify-content: space-between;
	margin-bottom: 24px;
}

.vch-discount {
	color: #2AB28A;
	display: flex;
	font-size: 28px;
	font-weight: bold;
	position: absolute;
	top: 17px;
	left: 60px;
	align-items: center;
}

.vch-discount p {
	margin: 0;
	font-size: 50px;
	margin-left: 12px;
}

.btn-save {
	position: absolute;
	bottom: 18px;
	left: 71.3%;
}

.btn-save button {
	cursor: pointer;
	width: 70px;
	height: 30px;
	border: 0;
	border-radius: 40px;
	background: none;
	color: #2ab28a;
	font-size: 20px;
	font-weight: bold;
}

.btn-save button:focus {
	outline-style: none;
}

.vch-content {
	position: absolute;
	color: white;
	font-size: 14px;
	top: 81px;
	left: 47px;
}

.line1, .vch-title {
	display: flex;
}

.vch-title {
	display: flex;
	width: 100%;
	text-align: center;
	justify-content: center;
}

.line1 p {
	margin: 0;
	color: yellow;
	font-weight: bold;
}

.vch-ele-right {
	color: black;
	width: 100%;
	text-align: center;
	padding: 38px 36px;
}

.vch-title p {
	font-size: 18px;
	font-weight: bold;
}
</style>
<body style="color: white;">
	<header class="container-xl header-content">
		<form method="post">
			<jsp:include page="../layouts/user/header.jsp"></jsp:include>
			<!--########################################3   START page CONTACT ###########################################-->
			<div class="voucher">
				<img src="<c:url value="/assets/images/logo/voucher1.png"/>"
					alt="images-order">
			</div>

			<div class="vch-wrap">
				<c:set var="count" value="${ 0 }" />
				<c:forEach var="it" items="${ listVoucher }" varStatus="index">
					<c:set var="idx" value="${ index.getIndex() }" />
					<c:if test="${ idx % 2 ==0  }">
						<div class="vch-list">
							<div class="vch-ele" id="${ it.key.id }">
								<div class="vch-ele-left">
									<img src="<c:url value="/assets/images/logo/bg-voucher.png"/>"
										alt="images-order">
									<div class="vch-discount">
										Sales off
										<p>${ it.key.vcdiscount }%</p>
									</div>
									<div class="btn-save">
										<button id="save" name="save">Save</button>
									</div>
									<div class="vch-content">
										<div class="line1">
											Apply for orders from
											<p>&nbsp;$${ it.key.applyfor }</p>
										</div>
										<div class="line1">1 slot/customer</div>
										<div class="line1">Applies to all products.</div>
									</div>
								</div>
								<div class="vch-ele-right">
									<c:if test="${ it.value == 0 }">
										<div class="vch-title">In effect until</div>
										<div class="vch-title">
											<fmt:parseDate value="${ it.key.end_date }"
												pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime"
												type="both" />
											<p>
												<fmt:formatDate pattern="HH:mm" value="${ parsedDateTime }" />
											</p>
											&nbsp;day&nbsp;
											<p>
												<fmt:formatDate pattern="dd/MM" value="${ parsedDateTime }" />
											</p>
										</div>
										<div class="vch-title">Limited</div>
									</c:if>
									<c:if test="${ it.value == 1 }">
										<div class="vch-title">Start from</div>
										<div class="vch-title">
											<fmt:parseDate value="${ it.key.start_date }"
												pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime"
												type="both" />
											<c:if
												test="${ parsedDateTime.hours==0 && parsedDateTime.minutes==0 }">
												<p>
													<fmt:formatDate pattern="HH:mm" value="${ parsedDateTime }" />
												</p>
											</c:if>
											<c:if
												test="${ parsedDateTime.hours != 0 || parsedDateTime.minutes != 0 }">
												<p>
													<fmt:formatDate pattern="HH:mm" value="${ parsedDateTime }" />
												</p>
											</c:if>
											&nbsp;day&nbsp;
											<p>
												<fmt:formatDate pattern="dd/MM" value="${ parsedDateTime }" />
											</p>
										</div>
										<div class="vch-title">Not Start</div>
									</c:if>
								</div>
								<span class="half-circle-top"></span> <span
									class="half-circle-bottom"></span>
							</div>
					</c:if>
					<c:if test="${ idx % 2 == 1 }">
						<div class="vch-ele" id="${ it.key.id }">
							<div class="vch-ele-left">
								<img src="<c:url value="/assets/images/logo/bg-voucher.png"/>"
									alt="images-order">
								<div class="vch-discount">
									Sales off
									<p>${ it.key.vcdiscount }%</p>
								</div>
								<div class="btn-save">
									<button id="save" name="save">Save</button>
								</div>
								<div class="vch-content">
									<div class="line1">
										Apply for orders from
										<p>&nbsp;$${ it.key.applyfor }</p>
									</div>
									<div class="line1">1 slot/customer</div>
									<div class="line1">Applies to all products.</div>
								</div>
							</div>
							<div class="vch-ele-right">
								<c:if test="${ it.value == 0 }">
									<div class="vch-title">In effect until</div>
									<div class="vch-title">
										<fmt:parseDate value="${ it.key.end_date }"
											pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime"
											type="both" />
										<p>
											<fmt:formatDate pattern="HH:mm" value="${ parsedDateTime }" />
										</p>
										&nbsp;day&nbsp;
										<p>
											<fmt:formatDate pattern="dd/MM" value="${ parsedDateTime }" />
										</p>
									</div>
									<div class="vch-title">Limited</div>
								</c:if>
								<c:if test="${ it.value == 1 }">
									<div class="vch-title">Start from</div>
									<div class="vch-title">
										<fmt:parseDate value="${ it.key.start_date }"
											pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime"
											type="both" />
										<p>
											<fmt:formatDate pattern="HH:mm" value="${ parsedDateTime }" />
										</p>
										&nbsp;day&nbsp;
										<p>
											<fmt:formatDate pattern="dd/MM" value="${ parsedDateTime }" />
										</p>
									</div>
									<div class="vch-title">Not Start</div>
								</c:if>
							</div>
							<span class="half-circle-top"></span> <span
								class="half-circle-bottom"></span>
						</div>
			</div>
			</c:if>
			<c:set var="count" value="${ idx }" />
			</c:forEach>
			<c:if test="${ count % 2 == 0}">
				</div>
			</c:if>
			</div>
		</form>
		<jsp:include page="product-body.jsp"></jsp:include>
	</header>


	<jsp:include page="../layouts/user/footer.jsp"></jsp:include>

	<jsp:include page="../layouts/user/search.jsp"></jsp:include>

	<script type="text/javascript">
		var id_user = "${ userID }";
		$(".vch-ele").click(function() {
			var id = this.id;
			var btn = $('button', this)[0];
			$(btn).text("Saved");
			var xhr = new XMLHttpRequest();

			xhr.open("GET", "/SpringMVC/voucher/save/" + id_user + "_" + id);
			xhr.onload = function() {
			};
			xhr.send();
		});
	</script>
	<script>
		function test($a) {
			for (let i = 1; i <= 10; i++) {
				if (i == $a) {
					var span_Text = document.getElementById("span_Id" + $a).innerText;
					document.querySelector('input[name="search"]').value = span_Text;
				}
			}
		}
	</script>

	<script type="text/javascript">
		window.addEventListener("scroll", function() {
			var div = document.getElementById('nav-search');
			var div1 = document.getElementsByClassName('hidden-poster2');
			if (window.scrollY > 80) {
				div.style.visibility = 'visible';
			} else {
				div.style.visibility = 'hidden';
			}
			if (window.scrollY > 2280 && window.scrollY < 2380) {
				div1.style.visibility = 'hidden';
			} else {
				div1.style.visibility = 'visible';
			}
		})
	</script>

	<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>

	<!-- Initialize Swiper -->
	<script>
		var swiper = new Swiper(".mySwiper", {
			effect : "coverflow",
			grabCursor : true,
			centeredSlides : true,
			slidesPerView : "auto",
			coverflowEffect : {
				rotate : 0,
				stretch : 0,
				depth : 150,
				modifier : 1,
				slideShadows : true,
			},
			loop : true,
		});
	</script>
	<!-- auto play header slide -->
	<script type="text/javascript">
		var counter = 1;
		setInterval(function() {
			document.getElementById('radio' + counter).checked = true;
			counter++;
			if (counter > 4) {
				counter = 1;
			}
		}, 5000);
	</script>

	<script>
		function bigImg(x) {
			var listkeys = document.getElementById("listkeys");
			listkeys.style.visibility = 'visible';
		}

		function normalImg(x) {
			var listkeys = document.getElementById("listkeys");
			listkeys.style.visibility = 'hidden';
		}
	</script>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script src="js/login.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>

</html>