<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="../layout/header.jsp"%>
<!DOCTYPE html>
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
	<link href="../files/style.css" rel="stylesheet">
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
	  </head>
	  <body>
		<main>
			<div class="input-form-background row">
				  <div class="input-form col-md-12 mx-auto">
				    <h4 class="mb-3">비밀번호 변경 페이지</h4>
				    <form class="validation-form" action="/member/changePassword" method="POST" id="pwUpdateForm" name="pwUpdateForm">
				        <div class="mb-3">
                     <input type="hidden" name="id" value="${id}">
	                </div>
	                <div class="mb-3">
	                    <label for="currentPassword">현재 비밀번호</label>
	                    <input type="password" class="form-control border" id="currentPassword" name="currentPassword" oninput="validateInput(this)" style="box-shadow: none;" required>
	                </div>
	                <div class="mb-3">
	                    <label for="newPassword">새 비밀번호</label>
	                    <input type="password" class="form-control border" id="newPassword" name="newPassword" oninput="validateInput(this)" style="box-shadow: none;" required>
	                	<div id="pass-feedback"></div>
	                </div>
	                <div class="mb-3">
	                    <label for="confirmPassword">새 비밀번호 확인</label>
	                    <input type="password" class="form-control" id="confirmPassword" oninput="validateInput(this)" name="confirmPassword" required>
	                </div>
	                <div class="text-end">
	            		<label for="show" class="pw_show"><input type="checkbox" id="show"> 비밀번호 표시</label>
	        		</div>
	        		<div>
	        			<button class="btn btn-outline-primary" id="pwChange" name="pwChange" type="submit">변경</button>
			        </div>
	        		<div class="text-end">	        		
	                <button class="btn btn-outline-warning" onclick="location.href='/member/myPageView'" type="button">돌아가기</button>
	                </div>
				    <c:if test="${not empty error}">
				        <p style="color: red;">${error}</p>
				    </c:if>
				    </form>
				  </div>
				</div>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
				<script>
				$(document).ready(function() {
		            $('#newPassword').on('input', function () {
		                var pass = $("#newPassword").val();
		                var reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/
		                if (!reg.test(pass)) {
		                    $('#pass-feedback').text('비밀번호를 영문, 숫자, 특수문자를 조합하여 8~15자리 사이로 입력해주세요.').css('color', 'red');
		                } else {
		                    $('#pass-feedback').text('사용 가능한 비밀번호입니다.').css('color', 'green');
		                }
		            });
		            
		            $('#pwChange').on('click', function (event) {
		                var currentPassword = $("#currentPassword").val();
		                var newPassword = $("#newPassword").val();
		                var confirmPassword = $("#confirmPassword").val();

		                if (currentPassword === "") {
		                    alert("현재 비밀번호를 입력해주세요.");
		                    event.preventDefault(); // 폼 제출 방지
		                    return false;
		                }

		                if (newPassword === "") {
		                    alert("새 비밀번호를 입력해주세요.");
		                    event.preventDefault(); // 폼 제출 방지
		                    return false;
		                }

		                if (confirmPassword === "") {
		                    alert("새 비밀번호 확인을 입력해주세요.");
		                    event.preventDefault(); // 폼 제출 방지
		                    return false;
		                }

		                if (newPassword !== confirmPassword) {
		                    alert("새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.");
		                    event.preventDefault(); // 폼 제출 방지
		                    return false;
		                }

		                // 확인 대화 상자 표시
		                var isConfirmed = confirm("정말로 비밀번호를 변경하시겠습니까?");
		                if (!isConfirmed) {
		                    event.preventDefault(); // 확인하지 않으면 폼 제출 방지
		                    return false;
		                }
		            });
		            
		            $(function(){
			        	const pwInput1 = $("#currentPassword");
			        	const pwInput2 = $("#newPassword");
			        	const pwInput3 = $("#confirmPassword");
			            $('.pw_show input[type="checkbox"]').on('change', function() {
			                if (this.checked) {
			                    pwInput1.prop("type", "text");
			                    pwInput2.prop("type", "text");
			                    pwInput3.prop("type", "text");
			                } else {
			                    pwInput1.prop("type", "password");
			                    pwInput2.prop("type", "password");
			                    pwInput3.prop("type", "password");
			                }
			            });
			        });
		        });
				
				function validateInput(input) {
			    	  input.value = input.value.replace(/\s/g, ''); // 공백 제거
			    	}
				
				</script>
				
		 
		   <hr class="featurette-divider">  
	
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
	 </body>
	</html>