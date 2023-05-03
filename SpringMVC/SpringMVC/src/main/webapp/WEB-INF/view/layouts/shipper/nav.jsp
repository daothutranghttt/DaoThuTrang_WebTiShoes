<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav class="navigation" id="navigation">
	<div class="wrapper-nav">
		<a href="/SpringMVC/shipper"> <!-- DASHBOARD -->
			<ul class="dashboard selected">
				<li>
					<div class="menu" id="sub-menu-dashboard">
						<img
							src="<c:url value="/assets/images/icons/icons8-home-page-96.png"/>"
							alt="">
						<h3>Dashboard</h3>
					</div>
				</li>
			</ul>
		</a>
		<ul>
			<!-- ORDER -->
			<li>
				<div class="menu" id="sub-menu-order">
					<img
						src="<c:url value="/assets/images/icons/icons8-purchase-order-100.png"/>"
						alt="">
					<h3>Order</h3>
					<p class="dropdown-sub-menu-order dropdown-menu">></p>
				</div>
			</li>
		</ul>

		<div class="sub-menu-order none">
			<!-- SUB MENU ORDER -->
			<a href="/SpringMVC/shipper/order-management">
				<ul class="sub-menu-ul" id="">
					<li>Management</li>
				</ul>
			</a> <a href="/SpringMVC/shipper/delivery">
				<ul class="sub-menu-ul" id="">
					<li>Delivery</li>
				</ul>
			</a>
			<a href="/SpringMVC/shipper/confirm-delivery">
				<ul class="sub-menu-ul" id="">
					<li>QR CODE</li>
				</ul>
			</a>
		</div>

		<ul>
			<!-- SHOES -->
			<li>
				<div class="menu" id="sub-menu-shoes">
					<img
						src="<c:url value="/assets/images/icons/icons8-user-100.png"/>"
						alt="">
					<h3>Profile</h3>
					<p class="dropdown-sub-menu-order dropdown-menu">></p>
				</div>

			</li>
		</ul>

		<div class="sub-menu-shoes none">
			<!-- SUB MENU SHOES -->
			<a href="/SpringMVC/admin/product">
				<ul class="sub-menu-ul" id="">
					<li>Product</li>
				</ul>
			</a> <a href="/SpringMVC/admin/color-size">
				<ul class="sub-menu-ul" id="">
					<li>Color-Size</li>
				</ul>
			</a> <a href="/SpringMVC/admin/gallery">
				<ul class="sub-menu-ul" id="">
					<li>Gallery</li>
				</ul>
			</a> <a href="/SpringMVC/admin/brand-style-gender">
				<ul class="sub-menu-ul" id="">
					<li>B-S-G</li>
				</ul>
			</a>
		</div>
		<ul class="other-menu">
			<li>
				<div class="menu" id="sub-menu-poster">
					<img
						src="<c:url value="/assets/images/icons/icons8-settings-100.png"/>"
						alt="">
					<h3>Setting</h3>
					<p class="dropdown-sub-menu-order dropdown-menu">></p>
				</div>
			</li>
		</ul>
		<!-- SUB MENU POSTER -->
		<div class="sub-menu-poster none">
			<a href="/SpringMVC/admin/poster/most-loved">
				<ul class="sub-menu-ul" id="">
					<li>Most loved</li>
				</ul>
			</a> <a href="/SpringMVC/admin/poster/new-arrivals">
				<ul class="sub-menu-ul" id="">
					<li>New arrivals</li>
				</ul>
			</a>
		</div>
	</div>
</nav>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	if ('scrollRestoration' in history) {
		history.scrollRestoration = 'manual';
	}
</script>
<script>
	var arrDiv = document.getElementsByClassName("menu");
	var arrP = document.getElementsByClassName("dropdown-menu");
	$(document).ready(function() {
		$(".menu").click(function() {
			var classSubMenu = "." + this.id;
			$(classSubMenu).toggle("none");
			for (let i = 0; i < arrP.length; i++) {
				if (arrP[i].className.includes(this.id)) {
					$(arrP[i].firstElementChild).toggleClass("rotate");
				}
			}
		});
	});
</script>
<script type="text/javascript">
	document.getElementById('navigation').addEventListener('scroll',
			function() {
				let x = this.scrollTop;
				if (parseInt(x) <= 40) {
					$("#shadow-nav").removeClass("menu-inner-shadow");
				} else {
					$("#shadow-nav").addClass("menu-inner-shadow");
				}
			}, false);
</script>
<script>
	$('.other').click(function() {
		$(".other-menu").removeClass("none", 10000, "easeInBack");
	});
</script>