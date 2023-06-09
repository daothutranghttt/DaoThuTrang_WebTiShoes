<!DOCTYPE html>
<%@page import="org.springframework.web.servlet.ModelAndView"%>
<html lang="en">
<meta charset="UTF-8">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>Nice to meet you :)?</title>
<link rel="stylesheet" href="<c:url value='/assets/css/admin.css'/>">
<link rel="stylesheet"
	href="<c:url value='/assets/css/dashboard-shipper2.css'/>">
<link rel="stylesheet"
	href="<c:url value='/assets/css/admin-login.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/css/chart2.css'/>">
<style>
* {
	font-family: "Poppins", sans-serif;
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

.green {
	color: green !important;
}

select option:hover {
	background-color: #666;
}

selecet#sl-month option:hover {
	box-shadow: 0 0 10px 100px #1882A8 inset;
}

.wrapoer-row {
	width: 100%;
	background: white;
	border-radius: 7px;
	padding: 25px;
}

.text {
	display: grid;
	width: 58%;
	height: 100%;
}

.text-title img {
	width: 30px;
}

.text-title {
	display: flex;
	align-items: center;
}

.text-title div {
	height: 100%;
	display: flex;
	align-items: center;
}

.wrapoer-row {
	width: 100%;
	background: white;
	border-radius: 7px;
	padding: 25px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.text-btn button {
	cursor: pointer;
	height: 36px;
	width: 137px;
	border-radius: 4px;
	border: 0;
	background: #0086ff;
	color: white;
	font-size: 16px;
	padding: 0 10px;
}

.icon-revenue, .icon-customer, .dashboard-col-icon, .icon-order {
	background-image: linear-gradient(195deg, rgba(66, 66, 74, 0.6),
		rgba(25, 25, 25, 0.6)) !important;
}

p#profile-report-title {
	width: 180px;
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
		<section>

			<div class="section-dashboard">
				<div class="dashboard-table">
					<div class="db-row1">
						<div class="wrapoer-row">
							<div class="text">
								<div class="text-title">
									<p>Congratulations ${ user.fullname }!</p>
									<div>
										<img alt=""
											src="<c:url value='/assets/images/icons/icons8-smiling-face-with-heart-eyes-96.png'/>">
									</div>
								</div>
								<div class="text-content">
									<p>You have accomplished 70% of your goal today. Check your
										new badge in your profile.</p>
								</div>
								<div class="text-btn">
									<button>View Orders</button>
								</div>
							</div>
							<div class="img">
								<img alt=""
									src="<c:url value='/assets/images/icons/icons8-confetti-100.png'/>">
							</div>
						</div>
					</div>
					<div class="db-row2">
						<div class="dashboard-col">
							<div class="dashboard-row-1">
								<div class="dashboard-row-top">
									<div class="dashboard-col-icon icon-revenue">
										<div class="wrapper-icon">
											<img
												src="<c:url value="/assets/images/icons/icons8-sales-performance-100.png"/>"
												alt="images-order">
										</div>
									</div>
									<div class="dashboard-col-text">
										<div class="dashboard-row-parameter">
											<p>
												$
												<fmt:formatNumber type="number" maxFractionDigits="2"
													value="${ revenueofday }" />
											</p>
										</div>
									</div>
								</div>
								<div class="dashboard-row-title">
									<p>Today's Revenue</p>
								</div>
							</div>
							<hr class="shadow-hr">
							<div class="dashboard-row-2">
								<div class="compare">
									<p>
										<c:if test="${ percentrevenue >= 0}">
											<span class="green">+${ percentrevenue }%</span> than yesterday
										</c:if>
										<c:if test="${ percentrevenue < 0}">
											<span class="red">${ percentrevenue }%</span> than yesterday
										</c:if>
									</p>
								</div>
							</div>
						</div>
						<div class="dashboard-col">
							<div class="dashboard-row-1">
								<div class="dashboard-row-top">
									<div class="dashboard-col-icon icon-order">
										<div class="wrapper-icon-order">
											<img
												src="<c:url value="/assets/images/icons/icons8-purchase-order-100.png"/>"
												alt="images-order">
										</div>
									</div>
									<div class="dashboard-col-text">
										<div class="dashboard-row-parameter">
											<p>+${ orderofday }</p>
										</div>
									</div>
								</div>
								<div class="dashboard-row-title">
									<p>Today's Order</p>
								</div>
							</div>
							<hr class="shadow-hr">
							<div class="dashboard-row-2">
								<div class="compare">
									<p>
										<c:if test="${ percentorder >= 0}">
											<span class="green">+${ percentorder }%</span> than yesterday
										</c:if>
										<c:if test="${ percentorder < 0}">
											<span class="red">${ percentorder }%</span> than yesterday
										</c:if>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="infor-table">
					<div class="table-row">
						<div class="table-col col2">
							<div class="table-chart">
								<div class="chart-title">Total Revenue</div>
								<div class="chart-row color-green" id="chart-revenue">
									<div class="chart">
										<canvas id="chart-line" class="chart-canvas" height="170"></canvas>
									</div>
								</div>
							</div>
							<div class="growth">
								<select id="sl-month">
									<option value="1">Jan</option>
									<option value="2">Feb</option>
								</select>
								<div class="growth-chart">
									<div class="example">
										<div class="example-figure">
											<div class="progress progress-2"></div>
										</div>
									</div>
								</div>
								<div class="bottom-growth">
									<div class="revenue-month">
										<div class="growth-revenue this-month">
											<img
												src="<c:url value="/assets/images/icons/icons8-revenue-68.png"/>"
												alt="images-order">
										</div>
										<div class="growth-chart-content">
											<h4>Currently</h4>
											<p id="revenue-price">$32.5k</p>
										</div>
									</div>
									<div class="revenue-month">
										<div class="growth-revenue not-this-month">
											<img
												src="<c:url value="/assets/images/icons/icons8-revenue-68.png"/>"
												alt="images-order">
										</div>
										<div class="growth-chart-content">
											<h4>Jan</h4>
											<p id="revenue-price">$32.5k</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="parameter-revenue">
							<div class="db-row">
								<!-- USER -->
								<div class="dashboard-col">
									<div class="dashboard-row-1">
										<div class="dashboard-row-top">
											<div class="dashboard-col-icon icon-customer">
												<div class="wrapper-icon">
													<img
														src="<c:url value="/assets/images/icons/icons8-customer-64-db.png"/>"
														alt="images-order">
												</div>
											</div>
											<div class="dashboard-col-text">
												<div class="dashboard-row-parameter">
													<p>+${ userofday }</p>
												</div>
											</div>
										</div>
										<div class="dashboard-row-title">
											<p>New Customer</p>
										</div>
									</div>
									<hr class="shadow-hr">
									<div class="dashboard-row-2">
										<div class="compare">
											<p>
												<c:if test="${ percentuser >= 0}">
													<span class="green">+${ percentuser }%</span> than yesterday
												</c:if>
												<c:if test="${ percentuser < 0}">
													<span class="red">${ percentuser }%</span> than yesterday
												</c:if>
											</p>
										</div>
									</div>
								</div>
								<div class="dashboard-col">
									<div class="dashboard-row-1">
										<div class="dashboard-row-top">
											<div class="dashboard-col-icon">
												<div class="wrapper-icon">
													<img
														src="<c:url value="/assets/images/icons/icons8-sales-performance-100.png"/>"
														alt="images-order">
												</div>
											</div>
											<div class="dashboard-col-text">
												<div class="dashboard-row-parameter">
													<p>$${ revenueofmonth }</p>
												</div>
											</div>
										</div>
										<div class="dashboard-row-title">
											<p>Month's Revenue</p>
										</div>
									</div>
									<hr class="shadow-hr">
									<div class="dashboard-row-2">
										<div class="compare">
											<p>
												<c:if test="${ percentrevenuemonth >= 0 }">
													<span class="green">+${ percentrevenuemonth }%</span> than last month
												</c:if>
												<c:if test="${ percentrevenuemonth < 0 }">
													<span class="red">${ percentrevenuemonth }%</span> than last month
												</c:if>
											</p>
										</div>
									</div>
								</div>
							</div>
							<div class="profile-report">
								<div class="profile-report-left">
									<p id="profile-report-title">Weekly Statistics</p>
									<p id="profile-report-name">REVENUE</p>
									<p id="percent-revenue">
										<img
											src="<c:url value="/assets/images/icons/icons8-arrow-upper-right-24.png"/>"
											alt="up">68%
									</p>
									<p id="total-revenue">$84,602.5</p>
								</div>
								<div class="profile-report-right">
									<div class="profile-report-chart">
										<div class="chart" id="chart-revenue-my">
											<canvas id="myChart-revenue" height="170"></canvas>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<jsp:include page="../layouts/shipper/s-footer.jsp"></jsp:include>
			</div>
		</section>
	</div>

	<div class="message msg-order none">
		<h2>Message</h2>
		<p class="content-msg"></p>
		<div class="btn-ok-cancel">
			<input class="cancel" type="button" value="Cancel"> <input
				class="ok hover-btn" type="button" value="OK">
		</div>
	</div>

	<div class="msg-done importantNone">Done!</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="<c:url value="assets/js/chartjs.min.js"/>"></script>

	<script type="text/javascript">
		$(".admin-qrcode-icon").click(function() {
			window.location.href = "/SpringMVC/shipper/confirm-delivery";
		});
	</script>
	<script> // chart statistics by category
		var yValues = [ 3371, 2757, 1503, 873, 359, 172 ];
		new Chart("myChart", {
			type : "doughnut",
			data : {
				labels: [
					    'Clothing',
					    'Shoes',
					    'Handbags',
					    'Jewelry',
					    'Accessories',
					    'Gifts',
					  ],
				datasets : [ {
					backgroundColor: [
				          'rgba(255, 26, 104, 0.2)',
				          'rgba(255, 206, 86, 0.2)',
				          'rgba(153, 102, 255, 0.2)',
				          'rgba(75, 192, 192, 0.2)',
				          'rgba(255, 159, 64, 0.2)',
				          'rgba(54, 162, 235, 0.2)',
				        ],
				    borderColor: [
				    	  'rgba(255, 26, 104, 1)',
				          'rgba(255, 206, 86, 1)',
				          'rgba(153, 102, 255, 1)',
				          'rgba(75, 192, 192, 1)',
				          'rgba(255, 159, 64, 1)',
				          'rgba(54, 162, 235, 1)',
				        ],
				    hoverBackgroundColor: [
				    	  'rgba(255, 26, 104, 0.9)',
				          'rgba(255, 206, 86, 0.9)',
				          'rgba(153, 102, 255, 0.9)',
				          'rgba(75, 192, 192, 0.9)',
				          'rgba(255, 159, 64, 0.9)',
				          'rgba(54, 162, 235, 0.9)',
				        ],
				    hoverOffset: 4,
					data : yValues
				} ]
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				plugins : {
					legend : {
						display : false,
					},
					tooltip : {
						callbacks : {
							afterFooter: function(chart) {
								var v = chart[0].parsed;
								var n = chart[0].dataset.data.length;
								const arr = chart[0].dataset.data;
								var total=0;
								for (let i=0; i < n; i++) {
									total += arr[i];
								}
								var t = parseFloat(Math.round(v/total*100*10)/10);
								$("#hoverval").text(t+"%");
							}
						}
					}
				},
			}
		});
	</script>

	<script> // chart revenue -> month
		var ctx2 = document.getElementById("chart-line").getContext("2d");
		new Chart(ctx2, {
			type : "bar",
			data : {
				labels : ${ listmonthname },
				datasets : [ {
					label : "Revenues",
					tension : 0,
					borderWidth : 5,
					pointRadius : 5,
					pointBackgroundColor : "#555",
					pointBorderColor : "#666",
					borderColor : "white",
					borderColor : "white",
					hoverBorderColor : "white",
					backgroundColor : "#666",
					fill : true,
					data : ${ listrevenueofmonth },
					maxBarThickness : 50

				} ],
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				plugins : {
					legend : {
						display : false,
					}
				},
				interaction : {
					intersect : false,
					mode : 'index',
				},
				scales : {
					y : {
						grid : {
							drawBorder : false,
							display : true,
							drawOnChartArea : true,
							drawTicks : false,
							color : 'lightgray'
							
						},
						ticks : {
							display : true,
							color : '#555',
							padding : 10,
							font : {
								size : 14,
								weight : 300,
								family : "Roboto",
								style : 'normal',
								lineHeight : 2
							},
						}
					},
					x : {
						grid : {
							drawBorder : false,
							display : true,
							drawOnChartArea : true,
							drawTicks : false,
						},
						ticks : {
							display : true,
							color : '#555',
							padding : 10,
							font : {
								size : 14,
								weight : 300,
								family : "Roboto",
								style : 'normal',
								lineHeight : 2
							},
						}
					},
				},
			},
		});
	</script>

	<script> // 
		var ctx3 = document.getElementById("chart-line-tasks").getContext("2d");
		new Chart(ctx3, {
			type : "line",
			data : {
				labels : [ "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct",
						"Nov", "Dec" ],
				datasets : [ {
					label : "Viewer",
					tension : 0,
					borderWidth : 0,
					pointRadius : 5,
					pointBackgroundColor : "rgba(255, 255, 255, .8)",
					pointBorderColor : "transparent",
					borderColor : "rgba(255, 255, 255, .8)",
					borderWidth : 4,
					backgroundColor : "transparent",
					fill : true,
					data : [ 50, 40, 300, 220, 500, 250, 400, 230, 500 ],
					maxBarThickness : 6
				} ],
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				plugins : {
					legend : {
						display : false,
					}
				},
				interaction : {
					intersect : false,
					mode : 'index',
				},
				scales : {
					y : {
						grid : {
							drawBorder : false,
							display : true,
							drawOnChartArea : true,
							drawTicks : false,
							borderDash : [ 5, 5 ],
							color : 'rgba(255, 255, 255, .2)'
						},
						ticks : {
							display : true,
							padding : 10,
							color : '#f8f9fa',
							font : {
								size : 14,
								weight : 300,
								family : "Roboto",
								style : 'normal',
								lineHeight : 2
							},
						}
					},
					x : {
						grid : {
							drawBorder : false,
							display : false,
							drawOnChartArea : false,
							drawTicks : false,
							borderDash : [ 5, 5 ]
						},
						ticks : {
							display : true,
							color : '#f8f9fa',
							padding : 10,
							font : {
								size : 14,
								weight : 300,
								family : "Roboto",
								style : 'normal',
								lineHeight : 2
							},
						}
					},
				},
			},
		});
	</script>

	<script> //daily order
		var ctx_re = document.getElementById("myChart-revenue").getContext('2d');
		var myChart_re = new Chart(ctx_re, {
			type : "line",
			data : {
				labels : [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
				datasets : [ {
					label : "Order",
					tension : 0,
					borderWidth : 0,
					pointRadius : 5,
					pointBackgroundColor : "#666",
					pointBorderColor : "#f9e1ee",
					borderColor : "#666",
					borderWidth : 4,
					backgroundColor : "transparent",
					fill : true,
					data : [ 50, 40, 300, 220, 500, 250, 400 ],
					maxBarThickness : 6
				} ],
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				plugins : {
					legend : {
						display : false,
					}
				},
				interaction : {
					intersect : false,
					mode : 'index',
				},
				scales : {
					y : {
						grid : {
							drawBorder : false,
							display : false,
							drawOnChartArea : false,
							drawTicks : false,
							borderDash : [ 5, 5 ]
						},
						ticks : {
							display : false,
						}
					},
					x : {
						grid : {
							drawBorder : false,
							display : false,
							drawOnChartArea : false,
							drawTicks : false,
							borderDash : [ 5, 5 ]
						},
						ticks : {
							display : false,
						}
					},
				},
			},
		});
	</script>

	<script src="<c:url value="/assets/js/circle-progress.js"/>"></script>

	<script>
		var ts = 60;
		var options = [
			{ max: 100, value: ts, textFormat: 'percent' },
		];
		options.forEach(function (opts, i) {
			var exampleEl = document.querySelector('.example:nth-child(' + (i + 1) + ')');
			new CircleProgress(exampleEl.querySelector('.progress'), opts);
			var optsStr = '{\n';
			for (var name in opts) {
				var value = opts[name];
				if (typeof value === 'string') {
					value = '\'' + value + '\'';
				}
				optsStr += '\t' + name + ': ' + value + ',\n';
			}
			optsStr += '}';
		});
	</script>

</body>

</html>


<!-- 	// push value into data in chart bars
		const pushvalue = document.getElementById("pushvalue");
		const push = document.getElementById("push");

		push.addEventListener('click', pushValueCharts);
		function pushValueCharts() {
			console.log(myChartBars.data.datasets[0].data);
			myChartBars.data.datasets[0].data.push(pushvalue.value);
			myChartBars.update();
		}
 -->