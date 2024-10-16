<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
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
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	      
	    .pw_show {display: flex;align-items: center; margin-top: 10px; font-size: 12px;}
		.pw_show input[type="checkbox"] {display: flex;align-items: center;margin-right: 5px;font-size: 12px; }
	      
	    </style>
			    
	    <!-- Custom styles for this template -->
	    <link href="../carousel/carousel.css" rel="stylesheet">
	    <link href="../carousel/sign-in.css" rel="stylesheet">
	  </head>
	<body>
		<main class="form-signin w-100 m-auto">
		<form method="post" name="find-id-form" id="find-id-form">
	    <a href="/"><img class="mx-auto d-block mb-4" src="../images/smailelogo.jpeg" width="72" height="57"></a>
	    <h1 class="h3 mb-3 fw-normal text-center">비밀번호 찾기</h1>
	    <div class="form-floating mb-3">
		    <input type="text" name="id" class="form-control" id="id" placeholder="아이디를 입력하세요" 
		    oninput="validateInput(this)" required >
		    <label for="floatingInput">아이디</label>
			<div class="invalid-feedback">
				아이디를 입력해주세요.
			</div>      
	    </div>
	    <div class="form-floating mb-3">
		    <input type="email" name="email" class="form-control" id="email" placeholder="email을 입력하세요" 
		     oninput="validateInput(this)" required >
		    <label for="floatingInput">이메일</label>
		    <span id="emailCheckMessage" class="error"></span>
			<div class="invalid-feedback">
				이메일을 입력해주세요.
			</div>     
	    </div>
	    
	    <div class="d-grid gap-2 d-md-flex justify-content-md-end mb-3">
	    	<button type="button" id="send-code-button" class="btn btn-primary btn-sm">인증번호 발송</button>
	    </div>
	    
	    <div class="form-floating mb-3" id="verifyCodeSection" style="display: none;">
	        <input type="text" id="verificationCode" class="form-control" placeholder="인증번호" 
	        oninput="validateInput(this)" required>
	        <label for="verificationCode">인증번호</label>
		  <div class="invalid-feedback">
				인증번호를 입력해주세요.
			</div> 
		</div>
		
		<div class="form-floating mb-3" id="newPasswordSection" style="display: none;">
	        <input type="password" id="newPassword" class="form-control" placeholder="새 비밀번호" 
	               oninput="validateInput(this)" required>
	        <label for="newPassword">새 비밀번호</label>
	        <div class="invalid-feedback">
	            새 비밀번호를 입력해주세요.
	        </div>
	        <div>
	            <label for="show" class="pw_show"><input type="checkbox" id="show"> 비밀번호 표시</label>
	        </div>
	        <div id="verificationMessage" class="text-danger" style="display:none;"></div>
	    </div>
		
		
        <div id="verifyCodeSection1" class="text-end mb-3" style="display: none;">
           <button type="button" name="verify-temporary-password-button" 
            		 id="verify-temporary-password-button" class="btn btn-primary btn-sm">인증번호 확인 및 비밀번호 변경</button>
        </div>

	   <div class="row">
            <div class="col-6 mb-2">
                <button class="btn text-white w-100" style="background-color: #009E73;" id="findPw" type="button" 
                        onclick="location.href='/security/findId'">아이디 찾기</button>
            </div>
            <div class="col-6 mb-2">
                <button class="btn text-white w-100" style="background-color: #009E73;" id="login" 
                        onclick="location.href='/security/loginform'" type="button">로그인</button>
            </div>
        </div>
	  </form>
	  
	  <script type="text/javascript">
	 	function validateInput(input) {
    	  input.value = input.value.replace(/\s/g, ''); // 공백 제거
    	}
	 	
	 	$(document).ready(function() {
	 	    // 인증번호 발송 버튼 클릭 이벤트
	 	    $('#send-code-button').on('click', function() {
	 	        // 입력값 검증
	 	        if ($("#id").val() === "") {
	 	            alert('아이디를 입력해주세요.');
	 	            $("#id").focus();
	 	            return false;
	 	        }
	 	        if ($("#email").val() === "") {
	 	            alert('이메일을 입력해주세요.');
	 	            $("#email").focus();
	 	            return false;
	 	        }

	 	        let id = $('#id').val();
	 	        let email = $('#email').val();

	 	        $.ajax({
	 	            url: '/security/sendverificationcode',
	 	            type: 'POST',
	 	            contentType: 'application/json',
	 	            data: JSON.stringify({ id: id, email: email }),
	 	            success: function(response) {
	 	                if (response.success) {
	 	                    // 인증번호 입력 필드 및 버튼 표시
			 	            $('#verifyCodeSection').slideDown();
		                    $('#verifyCodeSection1').slideDown();
		                    $('#newPasswordSection').slideDown();
	 	                    alert(response.message);
	 	                } else {
	 	                    $('#emailCheckMessage').text(response.message).show();
	 	                }
	 	            },
	 	            error: function() {
	 	                alert('인증번호 발송에 실패했습니다. 다시 시도해주세요.');
	 	            }
	 	        });
	 	    });
	 	});


	 	$(document).ready(function() {
	 	    // 인증번호 확인 및 비밀번호 변경 버튼 클릭 이벤트
	 	    $('#verify-temporary-password-button').on('click', function() {
	 	        // 입력값 검증
	 	        if ($("#id").val() === "") {
	 	            alert('아이디를 입력해주세요.');
	 	            $("#id").focus();
	 	            return false;
	 	        }
	 	        if ($("#email").val() === "") {
	 	            alert('이메일을 입력해주세요.');
	 	            $("#email").focus();
	 	            return false;
	 	        }
	 	        if ($("#verificationCode").val() === "") {
	 	            alert('인증번호를 입력해주세요.');
	 	            $("#verificationCode").focus();
	 	            return false;
	 	        }
	 	        if ($("#newPassword").val() === "") {
	 	            alert('새 비밀번호를 입력해주세요.');
	 	            $("#newPassword").focus();
	 	            return false;
	 	        }

	 	        const id = $('#id').val();
	 	        const email = $('#email').val();
	 	        const verificationCode = $('#verificationCode').val();
	 	        const newPassword = $('#newPassword').val();

	 	        $.ajax({
	 	            url: '/security/verifypass',
	 	            type: 'POST',
	 	            contentType: 'application/json',
	 	            data: JSON.stringify({
	 	                id: id,
	 	                email: email,
	 	                verificationCode: verificationCode,
	 	                newPassword: newPassword
	 	            }),
	 	            success: function(response) {
	 	                if (response.success) {
	 	                    alert(response.message);
	 	                    window.location.href = "/security/loginform"; // 비밀번호 변경 후 로그인 페이지로 이동
	 	                } else {
	 	                    $('#verificationMessage').text(response.message).show();
	 	                }
	 	            },
	 	            error: function() {
	 	                alert('비밀번호 변경에 실패했습니다. 다시 시도해주세요.');
	 	            }
	 	        });
	 	    });
	 	    
	 	   $(function(){
	        	const pwInput = $("#newPassword");
	            $('.pw_show input[type="checkbox"]').on('change', function() {
	                if (this.checked) {
	                    pwInput.prop("type", "text");
	                } else {
	                    pwInput.prop("type", "password");
	                }
	            });
	        });
	 	});
	        
	        
	    
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
								스마일로드 &nbsp;&nbsp;<br />
								학생 : 김건, 김나현,<br/>
								 나예림, 장다빈  <br>
							</p>
						</div>
					</div>
				</div>
			</footer>
	</main>
	
	<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>