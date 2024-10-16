<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="../layout/header.jsp"%>
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
	   	<link href="../carousel/carousel.css" rel="stylesheet">
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
			<div class="input-form-backgroud row">
			      <div class="input-form col-md-12 mx-auto">
			        <h4 class="mb-3">마이 페이지</h4>
			        <form class="validation-form" novalidate method="post" action="/member/memberDelete">
			        
						<div class="mb-3">
						  <label for="id">성명</label>
						  <input type="text" class="form-control border" name="name" value="${dto.name}" readonly> 
						</div>
					
						<div class="mb-3">
						  <label for="id">아이디</label>
						  <input type="text" class="form-control border" name="id" value="${dto.id}" style="box-shadow: none;" readonly> 
						</div>
						
						<div class="mb-3">
						  <label for="id">휴대전화</label>
						  <input type="text" class="form-control border" name="phoneNum" value="${dto.phoneNum}" style="box-shadow: none;" readonly> 
					   </div>					
		
					  	<div class="mb-3">
						  <label for="id">이메일</label>
						  <input type="text" class="form-control border" name="email" value="${dto.email}" style="box-shadow: none;" readonly> 
						</div>	  
		
			           <div class="mb-3">
						  <label for="id">우편번호</label>
						  <input type="text" class="form-control border" name="postcode" value="${dto.postcode}" style="box-shadow: none;" readonly> 
						</div>	
						
			           <div class="mb-3">
						  <label for="id">주소</label>
						  <input type="text" class="form-control border" name="address" value="${dto.address}" style="box-shadow: none;" readonly> 
						</div>				  
			           <div class="mb-3">
						  <label for="id">상세주소</label>
						  <input type="text" class="form-control border" name="detailaddress" value="${dto.detailaddress}" style="box-shadow: none;" readonly> 
						</div>				  
	
			          <hr class="mb-4">		          
			          <div class="mb-3 text-end">	  
			            <c:if test="${isNormalUser}">
						  <button class="btn btn-outline-warning btn float-right" onclick="location.href='/member/pwUpdateView'" type="button">비밀번호 변경</button>
					  </c:if>
			          </div>
			          <button class="btn btn-outline-primary" onclick="location.href='/member/myPageEdit'" type="button">수정 하기</button>
			          <button class="btn btn-outline-danger" type="submit" onclick="confirmDeletion()">회원 탈퇴</button>
			        </form>
			      </div>
			    </div>
			    <script>
				    function confirmDeletion() {
				        if (confirm("정말 회원 탈퇴를 하시겠습니까?")) {
				            // 사용자 확인 후 폼 제출
				            document.querySelector('form').submit();
				        }
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
	
	<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
	</body>
	</html>
