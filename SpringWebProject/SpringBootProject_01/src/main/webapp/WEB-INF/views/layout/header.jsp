<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<!DOCTYPE html>
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

<script>
	function chatPopup(){
		var s_width = window.screen.width;
		var s_height = window.screen.height;            
		
		var leftVar = s_width/2 - 500/2;
		var topVar = s_height/2 - 500/2;
		
		window.open("../member/chatPopup", "popup", 
			"width=600,height=250,left="+leftVar+",top="+topVar);
	}
	
	function chatPoplist(){
		var s_width = window.screen.width;
		var s_height = window.screen.height;            
		
		var leftVar = s_width/2 - 500/2;
		var topVar = s_height/2 - 500/2;
		
		window.open("../admin/chatRoomList", "popup", 
			"width=600,height=250,left="+leftVar+",top="+topVar);
	}
</script>
</head>
<body>
	<header>
		<svg xmlns="http://www.w3.org/2000/svg" class="d-none">
		  <symbol id="chat" viewBox="0 0 16 16">
		    <path
				d="M11.176 14.429c-2.665 0-4.826-1.8-4.826-4.018 0-2.22 2.159-4.02 4.824-4.02S16 8.191 16 10.411c0 1.21-.65 2.301-1.666 3.036a.32.32 0 0 0-.12.366l.218.81a.6.6 0 0 1 .029.117.166.166 0 0 1-.162.162.2.2 0 0 1-.092-.03l-1.057-.61a.5.5 0 0 0-.256-.074.5.5 0 0 0-.142.021 5.7 5.7 0 0 1-1.576.22M9.064 9.542a.647.647 0 1 0 .557-1 .645.645 0 0 0-.646.647.6.6 0 0 0 .09.353Zm3.232.001a.646.646 0 1 0 .546-1 .645.645 0 0 0-.644.644.63.63 0 0 0 .098.356" />
		    <path
				d="M0 6.826c0 1.455.781 2.765 2.001 3.656a.385.385 0 0 1 .143.439l-.161.6-.1.373a.5.5 0 0 0-.032.14.19.19 0 0 0 .193.193q.06 0 .111-.029l1.268-.733a.6.6 0 0 1 .308-.088q.088 0 .171.025a6.8 6.8 0 0 0 1.625.26 4.5 4.5 0 0 1-.177-1.251c0-2.936 2.785-5.02 5.824-5.02l.15.002C10.587 3.429 8.392 2 5.796 2 2.596 2 0 4.16 0 6.826m4.632-1.555a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0m3.875 0a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0" />
		  </symbol>
		</svg>

		<div class="position-fixed bottom-0 end-0 mb-3 me-3 bd-mode-toggle">
			<sec:authorize access="!isAnonymous() and  hasRole('ADMIN')">
				<button	class="btn btn-bd-primary py-2 d-flex align-items-center mb-2"
					id="bd-theme" type="button" aria-expanded="false"
					data-bs-toggle="button" aria-label="채팅리스트" onclick="chatPoplist();">
					채팅리스트
					<svg class="bi my-1  theme-icon-active" width="1em" height="1em">
						<use href="#chat"></use></svg>
					<span class="visually-hidden" id="bd-theme-text">Toggle
						theme</span>
				</button>
			</sec:authorize>
			<button class="btn btn-bd-primary py-2 d-flex align-items-center"
				id="bd-theme" type="button" aria-expanded="false"
				data-bs-toggle="button" aria-label="채팅상담" onclick="chatPopup();">
				채팅상담
				<svg class="bi my-1 theme-icon-active" width="1em" height="1em">
					<use href="#chat"></use></svg>
				<span class="visually-hidden" id="bd-theme-text">Toggle theme</span>
			</button>
		</div>

		<nav class="navbar navbar-expand-md fixed-top"
			style="background-color: #7FA1C3;">
			<div class="container-fluid">
				<a class="navbar-brand" href="/"><img alt="logo" src="../images/logo.png"></a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
					aria-controls="navbarCollapse" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse justify-content-between"
					id="navbarCollapse">
					<ul class="navbar-nav me-auto mb-2 mb-md-0">
						<li class="nav-item"><a class="nav-link" aria-current="page"
							href="/guest/homeInfo">홈페이지소개</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/guest/noticeBoard">공지사항</a></li>
						<li class="nav-item"><a class="nav-link" href="/guest/restMap">지도</a></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">커뮤니티</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="/guest/boardInfo">정보
										게시판</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">문의사항</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="../guest/inquiryBoard">문의게시판</a></li>
							</ul></li>
					</ul>

					<sec:authorize access="isAnonymous()">
						<ul class="navbar-nav">
							<li class="nav-item"><a class="nav-link"
								href="/security/loginform">
									<button type="button" class="btn btn-outline-light">
										<i class='bi bi-box-arrow-in-right'></i> 로그인
									</button>
							</a></li>
							<li class="nav-item"><a class="nav-link"
								href="/guest/joinform">
									<button type="button" class="btn btn-outline-light">
										<i class='bi bi-person-plus-fill'></i> 회원가입
									</button>
							</a></li>
						</ul>
					</sec:authorize>
					<!-- 로그인된 상태 -->
					<sec:authorize access="hasRole('USER')">
						<ul class="navbar-nav">
							<li class="nav-item"><a class="nav-link" href="/logout">
									<button type="button" class="btn btn-outline-light">
										<i class="bi bi-box-arrow-right"></i> 로그아웃
									</button>
							</a></li>
							<li class="nav-item"><a class="nav-link"
								href="/member/myPageView">
									<button type="button" class="btn btn-outline-light">
										<i class="bi bi-person-lines-fill"></i> 마이페이지
									</button>
							</a></li>
						</ul>
					</sec:authorize>

					<sec:authorize access="hasRole('ADMIN')">
						<ul class="navbar-nav">
							<li class="nav-item"><a class="nav-link" href="/logout">
									<button type="button" class="btn btn-outline-light">
										<i class="bi bi-box-arrow-right"></i> 로그아웃
									</button>
							</a></li>
							<li class="nav-item"><a class="nav-link"
								href="/admin/list">
									<button type="button" class="btn btn-outline-light">
										<i class="bi bi-person-lines-fill"></i> 회원관리페이지
									</button>
							</a></li>
						</ul>
					</sec:authorize>
				</div>
			</div>
		</nav>
	</header>
</body>
</html>