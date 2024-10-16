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

	    </style>

	    <link href="../carousel/carousel.css" rel="stylesheet">
	    <link href="../carousel/sign-in.css" rel="stylesheet">
	  </head>
	  <body>



	<main class="form-signin w-100 m-auto">
	<script type="text/javascript">
	 $(document).ready(function(){
			$("#submit").on("click", function(){
				
				if($("#id").val()==""){
					$('#id-feedback').text('아이디를 입력해주세요.').css('color', 'red');
					$("#id").focus();
					return false;
				}
				if($("#pass").val()==""){
					$('#pass-feedback').text('비밀번호를 입력해주세요.').css('color', 'red');
					$("#pass").focus();
					return false;
				}
				
			});
		})
		
		function validateInput(input) {
	    	  input.value = input.value.replace(/\s/g, ''); // 공백 제거
	    	}
	 
	 $(function(){
     	const pwInput = $("#pass");
         $('.pw_show input[type="checkbox"]').on('change', function() {
             if (this.checked) {
                 pwInput.prop("type", "text");
             } else {
                 pwInput.prop("type", "password");
             }
         });
     });
	</script>

	  <form action="/security/login" method="post" name="loginform" id="loginform">
	    <a href="/"><img class="mx-auto d-block mb-4" src="../images/smailelogo.jpeg" width="72" height="57"></a>
	    <h1 class="h3 mb-3 fw-normal text-center">로그인</h1>
	    <div class="form-floating">
	      <input type="text" name="id" class="form-control" id="id" placeholder="id를 입력하세요" required  oninput="validateInput(this)"  >
	      <label for="floatingInput">Id</label>
	      <span id="id-feedback"></span>
	    </div>
	    <div class="form-floating">
	      <input type="password" name="pass" class="form-control" id="pass" placeholder="Password" required oninput="validateInput(this)">
	      <label for="floatingPassword">Password</label>
	      <span id="pass-feedback"></span>
	    </div>
	     <div class="text-end">
		  <label for="show" class="pw_show"><input type="checkbox" id="show">비밀번호 표시</label>
		  </div>
		<span>
		    <c:if test="${error}">
		        <p id="valid" class="alert alert-danger">${exception}</p>
		    </c:if>
		</span>
		<div>
		<a style="text-decoration: none; color: black;" href="/security/findId">아이디찾기</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a style="text-decoration: none; color: black;" href="/security/findPwd">비밀번호찾기</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a style="text-decoration: none; color: black;" href="/guest/joinform">회원가입</a>
		</div>	

	    <button class="btn text-white w-100 my-2" style="background-color: #7FA1C3;" id="submit" type="submit">로그인</button>
	    <button class="btn btn-outline-danger w-100 my-1" type="submit" onclick="location.href='/oauth2/authorization/google'">구글로그인</button>
		<button class="btn text-white w-100 my-1" style="background-color: #03C75A;" type="submit" onclick="location.href='/oauth2/authorization/naver'">네이버로그인</button>
		<button class="btn w-100 my-1" type="submit" style="background-color: #FEE500;" onclick="location.href='/oauth2/authorization/kakao'">카카오톡로그인</button>
		<button class="btn text-white w-100 my-1" type="submit" style="background-color: #1877F2;" onclick="location.href='/oauth2/authorization/facebook'">페이스북로그인</button>
	  </form>
	  
	  <div class="duplicate-login-alert">
		  <c:if test="${sessionScope.DUPLICATE_LOGIN eq 'true'}">
		        <script> 
		            alert("다른 기기에서 로그인되어 현재 로그인이 종료되었습니다."); 
		        </script>
		        <c:remove var="DUPLICATE_LOGIN"/>
		    </c:if>
		</div>

	    <!-- START THE FEATURETTES -->

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
	<script>
		// '#_=_'은  보안 세션 악용을 보호하기 위해 Facebook(META)에 의해 추가되었다.
		// Facebook에 따르면 이를 처리하는 것은 개발자의 책임이다.
		console.log("aaa" + window.location.hash);
		if (window.location.hash == '#_=_'){
			console.log("bbb");
			
			history.replaceState
				? history.replaceState(null, null, window.location.href.split('#')[0])
				: window.location.hash = '';
		}
	</script>

	    </body>
	</html>
