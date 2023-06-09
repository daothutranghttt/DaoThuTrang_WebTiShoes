<!DOCTYPE html>
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<title>Add Gallery :)</title>

<link rel="stylesheet"
	href="<c:url value='/assets/css/admin-product.css'/>">
<link rel="stylesheet"
	href="<c:url value='/assets/css/admin-login.css'/>">

<style>
.message input {
	width: 100px;
}

.table-add-new-product {
	margin-top: 0;
}

.id-new-product {
	margin-top: 20px;
	width: 100%;
}

.selected-add-new-product {
	height: 40px;
}

.btn-add-new-product input {
	cursor: pointer;
}

.id-new-product-size {
	margin-top: 20px;
}

.list-size-add-new-product {
	margin-bottom: 15px;
	width: 93%;
}

.btn-add-new-product {
	margin-top: 0;
	margin-left: -30px;
}

.list-size-add-new-product span {
	height: 40px;
	width: 40px;
	justify-content: unset;
	padding: 0 10px;
}

.list-size-add-new-product input {
	width: 80px;
	margin-left: 10px;
}

table.table-new-product {
	margin-top: 30px;
	width: 100%;
}

.img-display {
    max-width: 540px;
    height: 540px;
    overflow-x: hidden;
    justify-content: center;
    display: flex;
    overflow-y: scroll;
}

.selected-add-new-product {
	width: 90%;
}

input.cancel {
	width: 124px;
}
</style>

<body>
	<jsp:include page="../layouts/admin/header.jsp"></jsp:include>
	<div class="admin-body">
		<jsp:include page="../layouts/admin/nav.jsp"></jsp:include>
		<section class="admin-shoes-product">


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
						src="<c:url value="/assets/images/icons/icons8-add-64-title.png"/>"
						alt=""> <a href="">Add new gallery</a>
				</div>
			</div>

			<div class="table-add-new-product">
				<form action="/SpringMVC/admin/gallery/add/savefile" method="post"
					enctype="multipart/form-data">
					<table class="table-new-product">
						<tr>
							<td>
								<div class="id-new-product">
									<p>Product</p>
									<select class="selected-add-new-product" id="select-product"
										name="product">
										<option value="" disabled="disabled" selected>Choose
											product</option>

										<c:forEach var="liProduct" items="${ listProduct }">
											<option value="${ liProduct.id }">${ liProduct.id }
												- ${ liProduct.title }</option>
										</c:forEach>
									</select>
								</div>
							</td>
							<td rowspan="4" class="td-img-display">
								<div class="img-display">
									<div class="gallery" id="gallery"></div>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="id-new-product">
									<p>Image</p>
									<input type="file" multiple id="filetag" name="filetag">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="btn-add-new-product">
									<input type="button" value="Add" id="btn-addnewproduct"
										name="btn-addnewproduct">
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</section>
	</div>

	<div class="message msg-order message-notify none" id="gallery-add">
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
					var product = $('#select-product').find(":selected").val();
					var color = $('#select-color').find(":selected").val();
					var file = $('input[type=file]').val();
					var error = "";

					if (product == "") {
						error += "You haven't chosen a product yet!! \n";
					} else if (color == "") {
						error += "You haven't chosen a color yet!! \n";
					} else if (file == "") {
						error += "You haven't chosen a image yet!! \n";
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


	<c:if test="${ sessionScope.addgallery != null }">
		<script type="text/javascript">
			var check = "${sessionScope.addgallery}";
			if (check == "true") {
				$("#gallery-add").removeClass("none");
				$("#gallery-add .content-msg-notify").text(
						"Continue add gallery?");
				$("#gallery-add .ok-notify").click(function() {
					var xhr = new XMLHttpRequest();
					xhr.open("GET", "/SpringMVC/admin/gallery/add?continue");
					xhr.onload = function() {
						window.location.assign("/SpringMVC/admin/gallery/add");
					};
					xhr.send();
				});
				$("#gallery-add .cancel").click(function() {
					var xhr = new XMLHttpRequest();
					xhr.open("GET", "/SpringMVC/admin/gallery/add?cancel");
					xhr.onload = function() {
						window.location.assign("/SpringMVC/admin/product");
					};
					xhr.send();
				});
			}
		</script>
	</c:if>

	<script type="text/javascript">
		$(function() {
		    // Multiple images preview in browser
		    var imagesPreview = function(input, placeToInsertImagePreview) {
		        if (input.files) {
		            var filesAmount = input.files.length;
		            for (i = 0; i < filesAmount; i++) {
		                var reader = new FileReader();
		                reader.onload = function(event) {
		                    $($.parseHTML('<img>')).attr('src', event.target.result).appendTo(placeToInsertImagePreview);
		                }
		                reader.readAsDataURL(input.files[i]);
		            }
		        }
		    };
		    $('#filetag').on('change', function() {
		    	$("#gallery img").remove();
		        imagesPreview(this, 'div.gallery');
		    });
		});
	</script>

	<script type="text/javascript">
		if (window.history.replaceState) {
			window.history.replaceState(null, null, window.location.href);
		}
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
</body>
</html>