<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!doctype html>
<html lang="en" data-bs-theme="auto">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.122.0">
<title>스마일로드</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<link rel="canonical"
	href="https://getbootstrap.com/docs/5.3/examples/carousel/">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../carousel/carousel.css" rel="stylesheet">
<link href="../files/style.css" rel="stylesheet">
</head>

<body>
	<%@ include file="../layout/header.jsp"%>
	<main>
		<div class="container marketing">


			<hr class="featurette-divider">

			<div class="row featurette">
				<div class="col-md-7">
					<h2 class="featurette-heading fw-normal lh-1">
						스마일로드에 오신 것을<br /> <span class="text-body-secondary">환영합니다!</span>
					</h2>
					<br />
					<p class="lead">
						스마일로드는 교통약자분들을 위해 설계된 특별한 지도 서비스입니다. <br />
						<br /> 저희의 목표는 여러분이 언제 어디서나 편리하고 안전하게 이동할 수 있도록 돕는 것입니다. 화장실과
						엘리베이터 정보를 한눈에 확인하고, 더욱 유쾌하고 편안한 생활을 즐기세요. 우리의 지도는 다양한 시설 정보를 직관적으로
						제공하여, 불편함 없이 이동할 수 있도록 지원합니다. 스마일로드와 함께라면, 길을 걷는 매 순간이 행복하고 여유롭게
						변할 것입니다.<br />
						<br /> 편안한 길을 스마일로드와 함께 떠나보세요!
					</p>
				</div>
				<div class="col-md-5">
					<img src="../images/homeinfo2.jpeg"
						class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
						alt="Description of Image" width="500" height="600">
				</div>
			</div>

			<hr class="featurette-divider">

			<div class="row featurette">
				<div class="col-md-7 order-md-2">
					<h2 class="featurette-heading fw-normal lh-1">
						스마일로드는<br /> <span class="text-body-secondary">언제나</span>
					</h2>
					<br />
					<p class="lead">
						모든 사용자가 이동 중에도 평등하고 편리한 환경을 누릴 수 있도록 하는 것을 목표로 삼고 있습니다.<br /> 이동의
						자유와 편안함을 위한 끊임없는 노력, 그것이 스마일로드의 사명입니다.<br />
						<br /> 모두가 편안하게 웃으며 이동할 그 날까지 항상 노력하겠습니다
					</p>
				</div>
				<div class="col-md-5">
					<img src="../images/homeinfo1.jpeg"
						class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
						alt="Description of Image" width="500" height="600">
				</div>
			</div>

			<hr class="featurette-divider">

			<div class="row featurette">
				<div class="col-md-7">
					<h2 class="featurette-heading fw-normal lh-1">
						스마일로드<br /> <span class="text-body-secondary">찾아오시는 길</span>
					</h2>
					<br />
					<p class="lead">
						경기도 고양시 일산구 중앙로 1275번길 38-10 201호(장항동 우림로데오스위트) &nbsp;&nbsp;<br />
						<br /> 이메일주소<br /> smaileroad@test.com<br />
						<br /> 전화번호<br /> TEL : 031.902.1777 &nbsp;&nbsp; FAX :
						031.906.8777 <br>
						<br /> 스마일로드에 대한 문의나 지원이 필요하시면 언제든지 [이메일 주소] 또는 [전화번호]로 연락 주세요. <br />
						저희 고객 지원팀이 신속하게 도와드리겠습니다.<br />
					</p>
				</div>
				<div class="col-md-5">
					<div id="map" class="map-container" style="width: 500px; height: 600px;">
						<script type="text/javascript"
							src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5494458a10ba93010be318723f4042f8"></script>
						<script>
							var container = document.getElementById('map');
							var options = {
								center : new kakao.maps.LatLng(37.659591,
										126.770949),
								level : 3
							};

							var map = new kakao.maps.Map(container, options);

							var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
							mapOption = {
								center : new kakao.maps.LatLng(37.659591,
										126.770949), // 지도의 중심좌표
								level : 3
							// 지도의 확대 레벨
							};

							var map = new kakao.maps.Map(mapContainer,
									mapOption); // 지도를 생성합니다

							// 마커가 표시될 위치입니다 
							var markerPosition = new kakao.maps.LatLng(
									37.659591, 126.770949);

							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
								position : markerPosition
							});

							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);

							// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
							// marker.setMap(null);
						</script>
					</div>
				</div>
			</div>


			<hr class="featurette-divider">

			<!-- /END THE FEATURETTES -->

		</div>
		<!-- /.container -->


		<!-- START THE FEATURETTES -->

		<hr class="featurette-divider">
	<%@ include file="../layout/footer.jsp"%>
	</main>
	<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
