<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
	<!doctype html>
	<html lang="en" data-bs-theme="auto">
	  <head><script src="../assets/js/color-modes.js"></script>

	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="description" content="">
	    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
	    <meta name="generator" content="Hugo 0.122.0">
	    <title>스마일로드</title>
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
		  
		  .input-form {
		        max-width: 680px;
		        margin-top: 80px;
		        padding: 32px;
		        background: #fff;
		        -webkit-border-radius: 10px;
		        -moz-border-radius: 10px;
		        border-radius: 10px;
		        -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		        -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		        box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
		      }
	    </style>	   
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	    <script type="text/javascript">
	    $(document).ready(function() {
            $('#mypageBtn').on('click', function (event) {
                var name = $("#name").val();
                var phoneNum = $("#phoneNum").val();
                var email = $("#email").val();
                var postcode = $("#postcode").val();
                var address = $("#address").val();
                var address = $("#detailaddress").val();
                

                // 기본 HTML5 유효성 검사
                if (!name) {
                    alert("성명을 입력해주세요.");
                    event.preventDefault(); // 폼 제출 방지
                    return false;
                }

                if (!phoneNum) {
                    alert("휴대전화 번호를 입력해주세요.");
                    event.preventDefault(); // 폼 제출 방지
                    return false;
                }

                if (!email) {
                    alert("이메일을 입력해주세요.");
                    event.preventDefault(); // 폼 제출 방지
                    return false;
                }

                // 이메일 유효성 검사 (정규식 예시)
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert("유효한 이메일 주소를 입력해주세요.");
                    event.preventDefault(); // 폼 제출 방지
                    return false;
                }

                if (!postcode) {
                    alert("우편번호를 입력해주세요.");
                    event.preventDefault(); // 폼 제출 방지
                    return false;
                }

                if (!address) {
                    alert("주소를 입력해주세요.");
                    event.preventDefault(); // 폼 제출 방지
                    return false;
                }

                // 수정 전 확인 대화 상자
                var isConfirmed = confirm("정말로 정보를 수정하시겠습니까?");
                if (!isConfirmed) {
                    event.preventDefault(); // 확인하지 않으면 폼 제출 방지
                    return false;
                }
            });
            
            $(document).ready(function() {
	            $('#name').on('input', function() {
	                var name = $(this).val();  // 수정: 'name' 변수로 변경
	                var regname = /^[a-zA-Z가-힣]*$/;
	                if (!regname.test(name)) {
	                    $('#name-feedback').text('이름은 한글 혹은 영어만 입력 가능합니다.').css('color', 'red');
	                    $('#name').focus();
	                } else {
	                    $('#name-feedback').text('');
	                }
	            });
		    });
            
            $('#phoneNum').on('input', function() {
                var input = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 추출
                var formatted = '';

                if (input.length > 7) {
                    formatted = input.replace(/^(\d{3})(\d{4})(\d{4})$/, '$1-$2-$3');
                } else if (input.length > 3) {
                    formatted = input.replace(/^(\d{3})(\d{0,4})$/, '$1-$2');
                } else {
                    formatted = input;
                }

                $(this).val(formatted);

                // 유효성 검사
                var reg_mobile = /^01[0-9]{1}-[0-9]{4}-[0-9]{4}$/;
                if (!reg_mobile.test(formatted)) {
                    $('#phoneNum-feedback').text('휴대폰번호가 잘못된 형식입니다.').css('color', 'red');
                } else {
                    $('#phoneNum-feedback').text('');
                }
            });
            
            $('#email').on('input', function() {
                var email = $(this).val();
                var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$/;
                if (emailRegex.test(email)) {
                    $('#email-feedback').text('사용가능한 이메일입니다.').css('color', 'green');
                } else {
                    $('#email-feedback').text('이메일 형식이 맞는지 확인해주세요').css('color', 'red');
                }
            });
        });
	    
	    </script>
	    
	    <!-- Custom styles for this template -->
	    <link href="../carousel/carousel.css" rel="stylesheet">
	  </head>
	  <body>
		<header>
			<nav class="navbar navbar-expand-md fixed-top" style="background-color: #7FA1C3;">
			  <div class="container-fluid">
			    <a class="navbar-brand" href="main">Carousel</a>
			    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
			      <span class="navbar-toggler-icon"></span>
			    </button>
			   <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
			      <ul class="navbar-nav me-auto mb-2 mb-md-0">
			      <li class="nav-item">
			        <a class="nav-link" aria-current="page" href="/">home</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="#">공지사항</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="#">지도</a>
			      </li>
			      <li class="nav-item dropdown">
			         <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">커뮤니티</a>
			          <ul class="dropdown-menu">
			            <li><a class="dropdown-item" href="#">정보 게시판</a></li>
			            <li><a class="dropdown-item" href="#">인기 게시판</a></li>
			         	</ul>
			         </li>
			      <li class="nav-item dropdown">
			         <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">문의사항</a>
			        <ul class="dropdown-menu">
			          <li><a class="dropdown-item" href="#">자주 물어보는 질문</a></li>
			          <li><a class="dropdown-item" href="#">1대1문의</a></li>
			        </ul>
			      </li>
			   </ul>
				  	<sec:authorize access="isAnonymous()">
				             <ul class="navbar-nav">
				                 <li class="nav-item">
				                     <a class="nav-link" href="/security/loginform">
				                         <button type="button" class="btn btn-outline-light">
				                             <i class='bi bi-box-arrow-in-right'></i> 로그인
				                         </button>
				                     </a>
				                 </li>
				                 <li class="nav-item">
				                     <a class="nav-link" href="/guest/joinform">
				                         <button type="button" class="btn btn-outline-light">
				                             <i class='bi bi-person-plus-fill'></i> 회원가입
				                         </button></a>
				                 </li>
				             </ul>
				</sec:authorize>
				             <!-- 로그인된 상태 -->
				<sec:authorize access="isAuthenticated()">    
				    <ul class="navbar-nav">
				        <li class="nav-item">
				            <a class="nav-link" href="/logout">
				                <button type="button" class="btn btn-outline-light">
				                    <i class="bi bi-box-arrow-right"></i> 로그아웃
				                </button>
				            </a>
				        </li>
				       <li class="nav-item">
				            <a class="nav-link" href="/member/myPageView">
				                <button type="button" class="btn btn-outline-light">
				                    <i class="bi bi-person-lines-fill"></i> 마이페이지
				                </button>
				            </a>
				        </li>
				    </ul>
           </sec:authorize>
			    </div>
			  </div>
			</nav>
		</header>
	
		<main>
			<div class="input-form-backgroud row">
			      <div class="input-form col-md-12 mx-auto">
			        <h4 class="mb-3">수정 페이지</h4>
			        <form class="validation-form" action="/member/myPageUpdate" method="post" novalidate>
			        					
						<div class="mb-3">
						  <label for="id">성명</label>
						  <input type="text" class="form-control border" id="name" name="name" value="${dto.name}" style="box-shadow: none;"> 
						  <span id="name-feedback"></span>
						</div>	
						<div class="mb-3">
						  <label for="id">휴대전화</label>
						  <input type="text" class="form-control border" id="phoneNum" name="phoneNum" value="${dto.phoneNum}" style="box-shadow: none;" > 
						 <span id="phoneNum-feedback"></span>
						</div>	
			          	
			          	<div class="mb-3">
						  <label for="eamil">이메일</label>
						  <input type="text" class="form-control" id="email" name="email" placeholder="영문과 숫자로 작성해주세요" value="${dto.email}">
						  <span id="email-feedback"></span>
						  <div class="invalid-feedback">
						    이메일을 입력해주세요.
						  </div>
						</div>

			            <div class="mb-3">
				            <label for="address">주소</label>
				            <button type="button" class="btn btn-primary btn-sm my-1" style="float:right" onclick="sample6_execDaumPostcode()" value="주소 찾기">
				            	주소 찾기</button>
				            <input type="text" class="form-control" id="postcode" name="postcode" value="${dto.postcode }" placeholder="우편번호" required>
				            <span id="postcode-feedback"></span>
				            <div class="invalid-feedback">
				              우편번호를 입력해주세요.
				            </div>
				            <br/>
				            <input type="text" class="form-control" id="address" name="address" value="${dto.address}" placeholder="주소" required>
				            <div class="invalid-feedback">
				              주소를 입력해주세요.
				            </div>
				            <br/>
			          	</div>
			          	<div class="mb-3">
			          		<input type="hidden" class="form-control" id="sample6_extraAddress" placeholder="상세주소를 입력해주세요.">
				            <label for="address2">상세주소</label>
				            <input type="text" class="form-control" id="detailaddress" name="detailaddress" value="${dto.detailaddress}" placeholder="상세주소를 입력해주세요.">
				            <br/>
				        </div>
			          <button class="btn btn-outline-primary" id="mypageBtn" name="mypageBtn" type="submit">변경</button>
			          <div class="text-end">
			          <button class="btn btn-outline-warning" onclick="location.href='/member/myPageView'" type="button">돌아가기</button>
			          </div>
			        </form>
			      </div>
			    </div>
		 
		   <hr class="featurette-divider">  
	
		  <!-- FOOTER -->
		  	<footer>
				<div class="p-4 text-white text-center"
					style="background-color: #7FA1C3;">
					<div class="row">
						<div class="col-2 ps-4">
							<h3>
								<strong><img alt="logo" src="../images/logo.png"></strong>
							</h3>
						</div>
						<div class="col">
							<p class="copy text-center">
								더조은아카데미일산 &nbsp;&nbsp; 경기도 고양시 일산구 중앙로 1275번길 38-10 201호(장항동
								우림로데오스위트) &nbsp;&nbsp;<br /> 학생 : 김건, 김나현, 나예림, 장다빈 사업자등록번호 :
								584-85-00825 &nbsp;&nbsp; TEL : 031.902.1777 &nbsp;&nbsp; FAX :
								031.906.8777 <br>
							</p>
						</div>
					</div>
				</div>
			</footer>
		</main>
	
		<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
		<!-- 카카오 주소 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	
	<script>
            function sample6_execDaumPostcode() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
        
                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var addr = ''; // 주소 변수
                        var extraAddr = ''; // 참고항목 변수
        
                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }
        
                        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                        if(data.userSelectedType === 'R'){
                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                extraAddr += data.bname;
                            }
                            // 건물명이 있고, 공동주택일 경우 추가한다.
                            if(data.buildingName !== '' && data.apartment === 'Y'){
                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if(extraAddr !== ''){
                                extraAddr = ' (' + extraAddr + ')';
                            }
                            // 조합된 참고항목을 해당 필드에 넣는다.
                            document.getElementById("sample6_extraAddress").value = extraAddr;
                        
                        } else {
                            document.getElementById("sample6_extraAddress").value = '';
                        }
        
                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.getElementById('postcode').value = data.zonecode;
                        document.getElementById("address").value = addr;
                        // 커서를 상세주소 필드로 이동한다.
                        document.getElementById("detailaddress").focus();
                    }
                }).open();
            }
        </script>
        <!-- 카카오 주소 api 끝 -->
	 </body>
	</html>