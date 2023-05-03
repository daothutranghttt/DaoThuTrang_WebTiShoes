<!DOCTYPE html>
<html lang="en">
<title>Products :)</title>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<link rel="stylesheet" href="<c:url value="/assets/css/products.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/zoom-img.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/home.css"/>">
<link rel="stylesheet"
	href='<c:url value="/assets/css/login-icon.css"/>'>
<link rel="stylesheet" href="<c:url value="/assets/css/navscroll.css"/>">
<link rel="stylesheet" href="<c:url value="/assets/css/hearder.css"/>">
<style>
.not-page {
	cursor: default !important;
	border: 0 !important;
	pointer-events: none !important;
}

.not-page:hover {
	border: 0;
	background: none !important;
}

.disabledbutton {
	pointer-events: none;
	opacity: 0.4;
}

.page-number:hover {
	background: gray !important;
}
.number-page-selected {
	background: #0086ff !important;
}
.number-page-selected:hover {
	background: #0086ff !important;
}
.slide-number-page span {
background: none;
cursor: pointer;
}
.backward-page, .forward-page {
	cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 3px;
}
.forward-page i,.backward-page i {
    font-size: 32px;
}
</style>
<body style="color: white;">
	<header class="container-xl header-content">

		<div class="back-header">
			<jsp:include page="../layouts/user/header.jsp"></jsp:include>
		</div>

		<!--########################################3   START PRODUCTS   ###########################################-->
		<div class="title-page">
			<h3>Shoes</h3>
			<span><a href="/welcome-to-uchiha-shoes/">Home</a> / <a
				href="products">All shoes</a></span>
		</div>
		<jsp:include page="product-body.jsp"></jsp:include>

		<jsp:include page="../layouts/user/footer.jsp"></jsp:include>
	</header>
</body>

</html>