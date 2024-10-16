<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!doctype html>
	<html lang="en" data-bs-theme="auto">
	<head>	 
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3f7f9ab0116bd62797e2fbd361dac3a9&libraries=services,clusterer,drawing"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>	    <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Hugo 0.122.0">
		<title>엘레베이터 지도</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
		<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/carousel/">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
		<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
		
			<style>
		.bd-placeholder-img {
		  font-size: 1.125rem;
		  text-anchor: middle;
		  -webkit-user-select: none;
		  -moz-user-select: none;
		  user-select: none;
		}
		
		@media (min-width: 768px) {
		  .bd-placeholder-img-lg {
		    font-size: 3.5rem;
		  }
		}
		
		.b-example-divider {
		  width: 100%;
		  height: 3rem;
		  background-color: rgba(0, 0, 0, .1);
		  border: solid rgba(0, 0, 0, .15);
		  border-width: 1px 0;
		  box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
		}
		
		.b-example-vr {
		  flex-shrink: 0;
		  width: 1.5rem;
		  height: 100vh;
		}
		
		.bi {
		  vertical-align: -.125em;
		  fill: currentColor;
		}
		
		.nav-scroller {
		  position: relative;
		  z-index: 2;
		  height: 2.75rem;
		  overflow-y: hidden;
		}
		
		.nav-scroller .nav {
		  display: flex;
		  flex-wrap: nowrap;
		  padding-bottom: 1rem;
		  margin-top: -1px;
		  overflow-x: auto;
		  text-align: center;
		  white-space: nowrap;
		  -webkit-overflow-scrolling: touch;
		}
		
		.btn-bd-primary {
		  --bd-violet-bg: #009E73;
		  --bd-violet-rgb: 112.520718, 44.062154, 249.437846;
		
		  --bs-btn-font-weight: 600;
		  --bs-btn-color: var(--bs-white);
		  --bs-btn-bg: var(--bd-violet-bg);
		  --bs-btn-border-color: var(--bd-violet-bg);
		  --bs-btn-hover-color: var(--bs-white);
		  --bs-btn-hover-bg: #6528e0;
		  --bs-btn-hover-border-color: #6528e0;
		  --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
		  --bs-btn-active-color: var(--bs-btn-hover-color);
		  --bs-btn-active-bg: #5a23c8;
		  --bs-btn-active-border-color: #5a23c8;
		
		}	 
		
		body { padding-top: 15%; } /* nav의 높이만큼 padding-top 추가 */
        
        /* 모달창 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 50%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
        .map-container {
            margin-top: 30px;
        }

        /* 헤더의 높이만큼 추가적인 상단 마진 */
        .button-container {
            margin-top: 30px; /* 헤더가 fixed-top이므로 헤더 높이만큼 마진 추가 */
            text-align: center; /* 버튼을 가운데 정렬 */
            z-index: 1;
            position: relative;
        }

        /* 지도의 크기 및 배치 */
        #map {
            width: 100%;
            height: 500px;
            z-index: 0;
        }
        </style>	 
		
		<link href="../carousel/carousel.css" rel="stylesheet">
	</head>
	
	<body>	
		<%@ include file="../layout/header.jsp"%>
	
		<main>
			<div class="button-container">
				<div class="col-12 text-center">
					 <button id="currentLocationBtn" class="btn btn-danger btn-sm" onclick="Mylocation()">현재위치</button>
					 &nbsp;&nbsp;
					 <button  class="btn btn-primary btn-sm" onclick="location.href='restMap';">화장실지도</button>
					 &nbsp;<small>(원하는 위치로 이동하여 지도를 클릭해 보세요.)</small>
				</div>
			</div>
			<div class="row">
				<div class="map-container">	
			        <div id="map" style="width:100%;height:500px;"></div>
				</div>
			</div>
			<!-- 모달창 -->
		    <div id="myModal" class="modal">
		        <div class="modal-content">
		            <span class="close">&times;</span>
		            <p id="modalContent">모달 내용</p>
		        </div>
		    </div>
		    
		   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3f7f9ab0116bd62797e2fbd361dac3a9&libraries=services,clusterer,drawing"></script>
		   <script>
				var map;
				var markers = []; // 현재 지도에 표시된 마커들을 저장할 배열
				
				function initMap() {
				    var mapContainer = document.getElementById('map'),
				        mapOption = {
				            center: new kakao.maps.LatLng(37.554674785645716, 126.9706120117342),
				            level: 2
				        };
	
				    map = new kakao.maps.Map(mapContainer, mapOption);
	
				    var mapTypeControl = new kakao.maps.MapTypeControl();
				    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	
				    var zoomControl = new kakao.maps.ZoomControl();
				    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
				    // 지도를 클릭했을 때
				    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
				        var latlng = mouseEvent.latLng;
				        map.setCenter(latlng);
	
				        var center = map.getCenter();
				        addressAdd(center.getLat(), center.getLng());
				    });
				}
				
		        function addressAdd(centerY1, centerX1) {
		            $.ajax({
		                url: "/guest/eleMap1",
		                type: "post",
		                data: {
		                    centerX: centerX1,
		                    centerY: centerY1
		                },
		                dataType: "json",
		                success: function (response) {
		                    console.log("성공");
		                    console.log(response);  // 응답 데이터를 출력합니다.
		                    removeMarkers();
		                    addMarkers(response);
		                },
		                error: function () {
		                    console.log("오류");
		                }
		            });
		        }
		        
		        function removeMarkers() {
		        	markers.forEach(marker => marker.setMap(null));
		        	markers = []; // 마커 배열 초기화
		        }
		        
	            function addMarkers(data) {
	                data.forEach(function(item) {
	                    // 마커의 컨텐츠를 정의합니다.
	                    var content = "<ul>" +
				                          "<li>지하철명 : " + item.sbwy_stn_nm + "</li>" +
				                          "<li>주소 : " + item.sgg_nm + " " + item.emd_nm + "</li>" +
				                          "<li>구분 : " + item.node_type_cd + " (0 : 일반, 1 : 지하철 출입구, 2 : 버스정류장, 3 : 지하보도 출입구)</li>" +
			                          "</ul>";
	
	                    // 마커의 위치를 정의합니다.
	                    var position = new kakao.maps.LatLng(item.y_wgs84, item.x_wgs84);
	
	                    // 마커를 생성합니다.
	                    var marker = new kakao.maps.Marker({
	                        position: position
	                    });
	
	                    // 마커를 지도에 추가합니다.
	                    marker.setMap(map);
						
	                    kakao.maps.event.addListener(marker, 'click', function() {
	                    	document.getElementById('myModal').style.display = 'block';
				            document.getElementById('modalContent').innerHTML = content;
	                    });
	                    
	                    // 마커를 배열에 추가합니다.
	                    markers.push(marker);
	                });
	            }
	            
		        // 모달창 닫기 기능
		        const modal = document.getElementById('myModal');
		        const closeBtn = document.getElementsByClassName('close')[0];
	
		        closeBtn.onclick = function() {
		            modal.style.display = 'none';
		        };
	
		        window.onclick = function(event) {
		            if (event.target === modal) {
		                modal.style.display = 'none';
		            }
		        };
			            
		        // 현재 위치로 이동하는 함수
				function Mylocation() {
				    if (navigator.geolocation) {
				        navigator.geolocation.getCurrentPosition(function(position) {
				            var lat = position.coords.latitude;
				            var lon = position.coords.longitude;
				            
				            var locPosition = new kakao.maps.LatLng(lat, lon);
				            
				            // 지도의 중심좌표를 현재 위치로 변경합니다
				            map.setCenter(locPosition);
				            
				            // 현재 위치에 마커를 추가합니다
				            var marker = new kakao.maps.Marker({
				                map: map,
				                position: locPosition
				            });
				            
				            var message = '<div style="width:150px;text-align:center;padding:6px 0;">현재위치</div>';
				            var infowindow = new kakao.maps.InfoWindow({
				                content: message
				            });
				            infowindow.open(map, marker);
				            
				        }, function(error) {
				        });
				    } else {
				        alert("현재위치를 찾을 수 없습니다.");
				    }
				}
	        
			window.onload = initMap;
		</script>
		</main>	
		<hr/> 	
	<%@ include file="../layout/footer.jsp"%>

	</body>
</html>


	

