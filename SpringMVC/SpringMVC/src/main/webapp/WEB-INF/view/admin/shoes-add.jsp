<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<c:if test="${ newProduct == 'true' }">
	<title>Add new product :)</title>
</c:if>
</head>
<link rel="stylesheet"
	href="<c:url value='/assets/css/admin-product.css'/>">
<link rel="stylesheet"
	href="<c:url value='/assets/css/admin-login.css'/>">
<style>
td.td-date {
	min-width: 95px;
}
</style>
<body>
	<jsp:include page="../layouts/admin/login.jsp"></jsp:include>
	<jsp:include page="../layouts/admin/header.jsp"></jsp:include>
	<div class="admin-body">
		<jsp:include page="../layouts/admin/nav.jsp"></jsp:include>
		<c:if test="${ newProduct == 'true' }">
			<section class="admin-shoes-product">
				<div class="title">
					<img
						src="<c:url value="/assets/images/icons/icons8-add-64-title.png"/>"
						alt="">
					<h1>ADD NEW PROCUCT</h1>
				</div>
		</c:if>
		<div class="nav-history">
			<div class="origin">
				<img
					src="<c:url value="/assets/images/icons/icons8-home-page-64.png"/>"
					alt=""> <a href="/SpringMVC/admin">Home</a>
			</div>

			<div>
				<p>/</p>
				<img
					src="<c:url value="/assets/images/icons/icons8-trainers-100-title.png"/>"
					alt=""> <a href="">Shoes</a>
			</div>

			<div>
				<p>/</p>
				<img
					src="<c:url value="/assets/images/icons/icons8-used-product-100-title.png"/>"
					alt=""> <a href="/SpringMVC/admin/product">Product</a>
			</div>


			<c:if test="${ newProduct == 'true' }">
				<div>
					<p>/</p>
					<img
						src="<c:url value="/assets/images/icons/icons8-add-64-title.png"/>"
						alt=""> <a href="">Add new product</a>
				</div>
			</c:if>


		</div>
		<c:if test="${ newProduct == 'true' }">
			<div class="table-add-new-product">
		</c:if>
		<c:if test="${ newProduct == 'false' }">
			<div class="table-add-new-product importantNone">
		</c:if>
		<form action="/SpringMVC/admin/product/add-new-product/savefile"
			method="post" enctype="multipart/form-data">
			<table class="table-new-product">
				<tr>
					<td>
						<div class="id-new-product">
							<p>Title</p>
							<input type="text" id="title" name="title">
						</div>
					</td>
					<td>
						<div class="id-new-product">
							<p>Price</p>
							<input type="number" step="0.01" id="price" name="price">
						</div>
					</td>
					<td>
						<div class="id-new-product">
							<p>Discount</p>
							<input type="number" id="discount" name="discount">
						</div>
					</td>
					<td rowspan="6" class="td-img-display">
						<div class="img-display">
							<img src="" id="preview">
						</div>
						<div class="btn-add-new-product">
							<input type="button" value="Add" id="btn-addnewproduct"
								name="btn-addnewproduct">
						</div>
					</td>
				</tr>

				<tr>
					<td>
						<div class="id-new-product">
							<p>Style</p>
							<select class="selected-add-new-product" id="select-style"
								name="style">
								<option value="" disabled="disabled" selected>Choose
									style</option>
								<c:forEach var="liStyle" items="${ listStyle }">
									<option value="${ liStyle.id }">${ liStyle.style_name }</option>
								</c:forEach>
							</select>
						</div>
					</td>
					<td>
						<div class="id-new-product">
							<p>Gender</p>
							<select class="selected-add-new-product" id="select-gender"
								name="gender">
								<option value="" disabled="disabled" selected>Choose
									gender</option>
								<c:forEach var="liGender" items="${ listGender }">
									<option value="${ liGender.id }">${ liGender.gender_name }</option>
								</c:forEach>
							</select>
						</div>
					</td>
					<td>
						<div class="id-new-product">
							<p>User</p>
							<select class="selected-add-new-product" id="select-user"
								name="user">
								<option value="" disabled="disabled" selected>Choose
									user</option>
								<c:forEach var="liUser" items="${ listUser }">
									<c:if test="${ liUser.role.id == 1 }">
										<option value="${ liUser.id }">${ liUser.fullname }</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="id-new-product">
							<p>Brand</p>
							<select class="selected-add-new-product" id="select-brand"
								name="brand">
								<option value="" disabled="disabled" selected>Choose
									brand</option>
								<c:forEach var="liBrand" items="${ listBrand }">
									<option value="${ liBrand.id }">${ liBrand.brand_name }</option>
								</c:forEach>
							</select>
						</div>
					</td>


					<td>
						<div class="id-new-product">
							<p>Image</p>
							<input type="file" id="filetag" name="filetag">
						</div>
					</td>
				</tr>

				<tr>
					<td colspan="3">
						<div class="phone-number">
							<p>Description</p>
							<textarea maxlength="500" id="txt-description" name="description"></textarea>
						</div>
					</td>
				</tr>

			</table>
		</form>

	</div>
	</section>
	<div class="behind-zoom-img importantNone"></div>

	<div class="message msg-order message-notify none">
		<h2 class="msg-h2">
			Message <img alt=""
				src="<c:url value="/assets/images/icons/icons8-notification-100-msg.png"/>">
		</h2>
		<p class="content-msg content-msg-notify"></p>
		<div class="btn-ok-cancel">
			<input class="cancel" type="button" value="Cancel"> <input
				class="ok ok-notify hover-btn" type="button" value="OK">
		</div>
	</div>
	<div class="message msg-order message-done none">
		<h2 class="msg-h2">
			Message <img alt=""
				src="<c:url value="/assets/images/icons/icons8-notification-100-msg.png"/>">
		</h2>
		<p class="content-msg content-msg-done"></p>
		<div class="btn-ok-cancel">
			<input class="ok ok-done hover-btn" type="button" value="OK">
		</div>
	</div>



	<div class="msg-done importantNone">Done!</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script>
		$("#btn-addnewproduct").click(
				function() {
					var title = $("#title").val();
					var price = $("#price").val();
					var discount = $("#discount").val();
					var style = $('#select-style').find(":selected").val();
					var gender = $('#select-gender').find(":selected").val();
					var user = $('#select-user').find(":selected").val();
					var brand = $('#select-brand').find(":selected").val();
					var file = $('input[type=file]').val();
					var description = $("#txt-description").val();
					var error = "";

					if (title == "") {
						error += "Title is empty! \n";
					} else if (price == "") {
						error += "Price is empty! \n";
					} else if (discount == "") {
						error += "Discount is empty! \n";
					} else if (style == "") {
						error += "You haven't chosen a style yet!! \n";
					} else if (gender == "") {
						error += "You haven't chosen a gender yet!! \n";
					} else if (user == "") {
						error += "You haven't chosen a user yet!! \n";
					} else if (brand == "") {
						error += "You haven't chosen a brand yet!! \n";
					} else if (file == "") {
						error += "You haven't chosen a image yet!! \n";
					} else if (description == "") {
						error += "Description is empty! \n";
					}
					if (error == "") {
						$(this).attr('type', 'submit');
					} else {
						$(".message-done").removeClass("none");
						$(".content-msg-done").text(error);
						$(".content-msg-done").html(
								$(".content-msg-done").html().replace(/\n/g,
										'<br/>'));
						$('.ok-done').click(function() {
							$(".message-done").addClass("none");
						});
					}
				});
	</script>

	<script>
		$('.cancel').click(function() {
			$(".message").addClass("none");
			location.reload();
		});
	</script>

	<script>
		$('.other').click(function() {
			$(".other-menu").removeClass("none", 10000, "easeInBack");
		});
	</script>

	<script>
		$(document).ready(function() {
			$(".admin-menu-icon").click(function() {
				$(".navigation").toggle("none");
			});
		});
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
						$(arrP[i]).toggleClass("rotate");
					}
				}
			});
		});
	</script>
	<!-- choose image and display -->
	<script>
		var fileTag = document.getElementById("filetag"), preview = document
				.getElementById("preview");

		fileTag.addEventListener("change", function() {
			changeImage(this);
		});

		function changeImage(input) {
			var reader;

			if (input.files && input.files[0]) {
				reader = new FileReader();

				reader.onload = function(e) {
					preview.setAttribute('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}
	</script>
	<script type="text/javascript">
	$('#password').keydown(function(event) {
	    // enter has keyCode = 13, change it if you want to use another button
	    if (event.keyCode == 13) {
	      	this.form.submit();
	      	return false;
	    }
	});
	</script>

	<c:if test="${ sessionScope.login == false}">
		<script type="text/javascript">
			$("#msg-login-admin").removeClass("none");
			$("#msg-login-admin").text("User name or password is not correct!");
		</script>
	</c:if>

	<script type="text/javascript">
		function login() {
			var username = $("#username").val();
			var password = $("#password").val();
			if (username == "") {
				$("#msg-login-admin").removeClass("none");
				$("#msg-login-admin").text("User name is empty!");
			} else if (password == "") {
				$("#msg-login-admin").removeClass("none");
				$("#msg-login-admin").text("Password is empty!");
			} else {
				 $('#my_form').attr('action', '/SpringMVC/admin/login');
				 document.getElementById('my_form').submit();
			}
		}
	</script>
</body>


</html>