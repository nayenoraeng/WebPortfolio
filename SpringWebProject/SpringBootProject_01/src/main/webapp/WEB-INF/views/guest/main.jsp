<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="../layout/header.jsp"%>
	<!doctype html>
	<html lang="en" data-bs-theme="auto">
	  <head>
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="description" content="">
	    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
	    <meta name="generator" content="Hugo 0.122.0">
	    <title>스마일 로드</title>
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
	    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/carousel/">
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
		<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
		<style>@import url('https://fonts.googleapis.com/css2?family=SUSE:wght@100..800&display=swap');</style>
		<style>@import url('https://fonts.googleapis.com/css2?family=New+Amsterdam&family=SUSE:wght@100..800&display=swap');</style>
		<style>@import url('https://fonts.googleapis.com/css2?family=New+Amsterdam&family=Noto+Sans+KR:wght@100..900&family=SUSE:wght@100..800&display=swap');</style>
		
	    <style>
	     .suse {
		  font-family: "SUSE", sans-serif;
		  font-optical-sizing: auto;
		  font-weight: <weight>;
		  font-style: normal;
		}
		.new-amsterdam-regular {
		  font-family: "New Amsterdam", sans-serif;
		  font-weight: 400;
		  font-style: normal;
		}
		.noto-sans-kr {
		  font-family: "Noto Sans KR", sans-serif;
		  font-optical-sizing: auto;
		  font-weight: 900;
		  font-style: normal;
		}
      	.bd-placeholder-img {
	        font-size: 1.125rem;
	        text-anchor: middle;
	        -webkit-user-select: none;
	        -moz-user-select: none;
	        user-select: none;
	      }
	      
	      h1 {
	      color: black;
		  font-size: 100px;
			}
		  p{
	      color: black;
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

	    
	    <!-- Custom styles for this template -->
	    <link href="../carousel/carousel.css" rel="stylesheet">
	  </head>
	  <body>

	<main>
	  <div id="myCarousel" class="carousel slide mb-6" data-bs-ride="carousel">
	    <div class="carousel-indicators">
	      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
	      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
	      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
	    </div>
	    
	    <div class="carousel-inner">
	      <div class="carousel-item active">
     		<svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="var(--bs-light-border-subtle)"/></svg>
	        <div class="container">
	          <div class="carousel-caption text-start">
	            <h1 class="new-amsterdam-regular">Smile Road</h1>
	            <p>더 나은 길을 만들어가는 여정에 여러분의 참여를 환영합니다. 우리의 목표는 단순한 이동의 편리함을 넘어,<br/> 모두가 존중받고 배려받는 사회를 이루는 것입니다.</p>
	          </div>
	        </div>
	      </div>
	      
	      <div class="carousel-item">
	        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="var(--bs-warning-border-subtle)"/></svg>
	        <div class="container">
	          <div class="carousel-caption">
	            <h1 class="noto-sans-kr">Smile Road</h1>
	            <p>교통 약자들이 겪는 문제들을 개선하고, 모두가 행복한 미소를 지을 수 있는 세상을 위해 <br/><strong> 스마일 로드</strong>는 항상 앞장서겠습니다.</p>
	          </div>
	        </div>
	      </div>
	      <div class="carousel-item">
	        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="var(--bs-success-border-subtle)"/></svg>
	        <div class="container">
	          <div class="carousel-caption text-end">
	            <h1 class="suse">Smile Road</h1>
	            <p>스마일 로드는 장애인, 고령자, 임산부, 영유아를 동반한 사람, 어린이 등 <strong>교통약자</strong>의 <br/>이동권이 보장되는 사회를 만들기 위해 노력합니다.</p>
	          </div>
	        </div>
	      </div>
	    </div>
	    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
	      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	      <span class="visually-hidden">Previous</span>
	    </button>
	    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
	      <span class="carousel-control-next-icon" aria-hidden="true"></span>
	      <span class="visually-hidden">Next</span>
	    </button>
	  </div>

	  <div class="container marketing">
		<div class="row">
	      <div class="col-lg-4">
	      	<img src="../static/restlogo.jpg" alt="화장실찾기 이미지" class="bd-placeholder-img rounded-circle" width="180" height="180">
	        <!-- <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="var(--bs-secondary-color)"/></svg> -->
	        <h2 class="fw-normal">화장실찾기</h2>
	        <p>현재 위치를 기반으로 주변에 교통약자들이 이용할 수 있는 화장실을 위치를 찾아드립니다.</p>
	        <p><a class="btn" href="guest/restMap" style="background-color: #B4B4B8; color: white;">View details &raquo;</a></p>
	      </div><!-- /.col-lg-4 -->
	      <div class="col-lg-4">
			<img src="../static/elvlogo.jpg" alt="엘레베이터찾기 이미지" class="bd-placeholder-img rounded-circle" width="180" height="180">	        
			<h2 class="fw-normal">승강기찾기</h2>
	        <p>현재 위치를 기반으로 주변 지하철역의 엘리베이터 위치를 찾아드립니다.</p>
	        <p><a class="btn" href="guest/eleMap" style="background-color: #B4B4B8; color: white;">View details &raquo;</a></p>
	      </div><!-- /.col-lg-4 -->
	      <div class="col-lg-4">
			<img src="../static/inforlogo.jpg" alt="엘레베이터찾기 이미지" class="bd-placeholder-img rounded-circle" width="180" height="180">
	        <h2 class="fw-normal">커뮤니티</h2>
	        <p>교통 약자들이 일상 생활에서 필요한 교통 정보와 편의시설에 대한 정보를 공유하는 게시판으로 이동합니다.</p>
      	    <p><a class="btn" href="guest/boardInfo" style="background-color: #B4B4B8; color: white;">View details &raquo;</a></p>
	        <!-- <p><a class="btn btn-outline-secondary" href="guest/boardInfo">View details &raquo;</a></p> -->
	      </div><!-- /.col-lg-4 -->
	    </div><!-- /.row -->
	    </div>


	    <!-- START THE FEATURETTES -->

	   <hr class="featurette-divider">
	<%@ include file="../layout/footer.jsp"%>

	 </main>
	<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>
