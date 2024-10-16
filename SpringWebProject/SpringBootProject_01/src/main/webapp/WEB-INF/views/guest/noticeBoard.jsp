<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!doctype html>
	<html lang="en" data-bs-theme="auto">
	<head>	 
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>	    <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Hugo 0.122.0">
		<title>공지사항 게시판</title>
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
		</style>	 
	  <link href="../carousel/carousel.css" rel="stylesheet">
	</head>
	
	<body>	
	<%@ include file="../layout/header.jsp"%>
		<main>
			<div class="col-10 pt-3 mt-3 mx-auto">
		         <nav class="navbar">
				  <div class="container-fluid">
				    <h4><strong>공지사항 게시판</strong></h4>
				    <form method="get" class="d-flex">
				    <c:choose>
				     <c:when test="${param.searchField == 'content'}">
				      <select name="searchField" required class="form-control" dir="rtl">
                         <option value="title">제목</option>
                         <option value="content">내용</option>
                         <option value="idx">글번호</option>
	                  </select>
	                 </c:when>
				     <c:when test="${param.searchField == 'idx'}">
				      <select name="searchField" required class="form-control" dir="rtl">
                         <option value="title">제목</option>
                         <option value="content">내용</option>
                         <option value="idx">글번호</option>
	                  </select>
	                 </c:when>
	                 <c:otherwise>
                 	  <select name="searchField" required class="form-control" dir="rtl">
                         <option value="title">제목</option>
                         <option value="content">내용</option>
                         <option value="idx">글번호</option>
	                  </select>
	                 </c:otherwise>
	                </c:choose>
				      <input class="form-control" type="text" name="searchWord" placeholder="Search" aria-label="Search" value="${searchWord}" >
		              <button class="btn btn-outline-primary" type="submit"><i class="bi bi-search" style='font-size:20px'></i></button>
				    </form>
				  </div>
				</nav>
		         
		         <div class="row mt-3 mx-1 mx-auto">
		             <!-- 게시판리스트부분 -->
		             <table class="table table-bordered table-hover table-striped">
		                 <colgroup>
		                     <col width="60px" />
		                     <col width="*" />
		                     <col width="120px" />
		                     <col width="120px" />
		                     <col width="80px" />
		                     <col width="60px" />
		                 </colgroup>
		                 	<thead>
			                     <tr style="background-color: rgb(133, 133, 133); " class="text-center text-white">
			                         <th>번호</th>
			                         <th>제목</th>
			                         <th>작성자</th>
			                         <th>작성일</th>
			                         <th>조회수</th>
			                         <th>추천</th>
			                     </tr>
			                 </thead>
			                 <tbody>
			                 <c:choose>
			                 	<c:when test="${ empty list }">
			                 		<tr>
			                 			<td colspan="6" align="center">
			                 				등록된 게시물이 없습니다.
			                 			</td>
			                 		</tr>
			                 	</c:when>
			                 	<c:otherwise>
								 <c:forEach items="${list}" var="dto"  varStatus="loop">
			                     	<tr>
			                     		<td align="center">${totalCount - (((pageNum-1) * pageSize) + loop.index)}</td>
			                     		<td>
			                     			<a href="noticeView?idx=${dto.idx}">${dto.title}</a>&nbsp;
											<jsp:useBean id="now" class="java.util.Date" />
											<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />				                     			
			                     			<c:if test="${dto.postdate == today}"><span class="badge rounded-pill text-bg-danger">New</span></c:if>
			                     			<c:if test="${ not empty dto.ofile }"><i class="bi bi-paperclip"></i></c:if>
			                     		</td>
			                     		<td align="center">${dto.id}</td>
			                     		<td align="center">${dto.postdate}</td>
			                     		<td align="center">${dto.viewCount}</td>
			                     		<td align="center">${dto.likeCount}</td>
			                     	</tr>
			                     </c:forEach>
			                     </c:otherwise>
			                 </c:choose>
			                 </tbody>
		             </table>
		         </div>
		         
		   		 <!-- 게스트 일 때 -->
                 <sec:authorize access="isAnonymous()">
                	 <div>
		               <div class="col d-flex justify-content-end">
		                   <button type="button" class="btn btn-primary" onclick="location.href='noticeBoard';">리스트보기</button>&nbsp;&nbsp;
		               </div>
			         </div>
                 </sec:authorize>
                 <!-- 로그인 멤버 -->
                 <sec:authorize access="hasRole('USER')">    
	             	<div>
		               <div class="col d-flex justify-content-end">
		                   <button type="button" class="btn btn-primary" onclick="location.href='noticeBoard';">리스트보기</button>&nbsp;&nbsp;
		               </div>
			         </div>
	             </sec:authorize>
	             <!-- 로그인 관리자 -->
	             <sec:authorize access="hasRole('ADMIN')">
	             	<div>
	             		<div class="col d-flex justify-content-end">
		                   <button type="button" class="btn btn-primary" onclick="location.href='noticeBoard';">리스트보기</button>&nbsp;&nbsp;
		                   <button type="button" class="btn btn-primary" onclick="location.href='../admin/noticeWriteForm';">공지사항 등록</button>
	               		</div>
	             	</div>
	             </sec:authorize>
	             
	             <div class="row mt-3">
		             <div class="col">
		                 <!-- 페이지번호 부분 -->
						 <div class="pagination justify-content-center">
		                     ${pagingImg}
		                 </div>
		             </div>
		         </div>
		     </div>
		</main>	 	
		<hr/> 	
	<%@ include file="../layout/footer.jsp"%>

	</body>
</html>
	

