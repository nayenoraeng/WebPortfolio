<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>	    <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Hugo 0.122.0">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
		.table {
			white-space:nowrap;
			text-align: center;
		}
		</style>	 
	  <link href="../carousel/carousel.css" rel="stylesheet">
</head>
<body>
	<%@ include file="../layout/header.jsp"%>

	<div class="col-10 pt-3 mt-3 mx-auto">
		         <h4>관리자페이지- <small>회원목록</small></h4>
		         
		         <script>
		         	function validateForm(fm){
		         		let sFieldCnt = 0;
		         		for(let i =0; i<fm.searchField.length ; i++){
		         			if(fm.searchField[i].checked==true)
		         				sFieldCnt++;
		         		}
		         		if(sFieldCnt==0){
		         			alert("한개 이상의 항목을 체크하셔야 합니다.");
		         			return false;
		         		}
		         		else if(fm.searchWord.value.trim() === ""){
		         			alert("검색창에 아이디나 이름을 입력해주세요.");
		         			return false;
		         		}
		         	}			         
		         </script>
		         <div class="list-group list-group-horizontal list-group-flush">
					  <a href="/admin/list" class="list-group-item list-group-item-action">전체회원목록 보기</a>
					  <a href="/admin/localList" class="list-group-item list-group-item-action">일반회원목록 보기</a>
					  <a href="/admin/socialList" class="list-group-item list-group-item-action">소셜회원목록 보기</a>
					  <a href="/admin/LockList" class="list-group-item list-group-item-action">계정잠금 회원</a>
					  <a href="/admin/enabledList" class="list-group-item list-group-item-action">비활성화 회원</a>
					</div>
		         <div class="row" >
		              <!-- 검색부분 -->
		             <form method="get" onsubmit="return validateForm(this);">
		             	 <div class="input-group ms-auto " style="width: 300px;">
		                     <input type='checkbox' name="searchField" value="id" class="form-check-input"/>아이디
		                     <input type='checkbox' name="searchField" value="name" class="form-check-input"/>이름
					   <input class="form-control" type="search" name="searchWord"  placeholder="Search" aria-label="Search">
			           <button class="btn btn-outline-primary" type="submit" ><i class="bi bi-search" style='font-size:20px'></i></button>
		             	</div>
		             </form>  
		         </div>
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
		                         <th>아이디</th>
		                         <th>이름</th>
		                         <th>잠금</th>
		                         <th>로그인실패횟수</th>
		                         <th>잠금시간</th>
		                         <th>가입일</th>
		                     </tr>
		                 </thead>
		                 <tbody>
		                 	<c:choose>
				                <c:when test="${ empty list3 }">
					                 <tr>
					                 	<td colspan="12" align="center">
					                 		등록된 회원이 없습니다.
					                 	</td>
					                 </tr>
				                 </c:when>
				                 <c:otherwise>
				                 	<c:forEach items="${list3 }" var="lock" varStatus="loop">
				                    	<tr align="center">
				                    		<td>
								            <c:set var="vNum3" value="${ maps.totalCount - 
								                (((maps.pageNum-1) * maps.pageSize)	+ loop.index)}" />
								            	${vNum3}
								            </td>                
				                         	<td class="text-center">${lock.id }</td>
				                         	<td class="text-center">${lock.name }</td>
				                         	<td class="text-center">${lock.isLock }</td>
				                         	<td class="text-center">${lock.failCount }</td>
				                         	<td class="text-center">${lock.lockTime }</td>
				                         	<td class="text-center"><fmt:formatDate value="${lock.regidate}" pattern="yyyy-MM-dd"/></td>
				                     	</tr>
				                 	</c:forEach>  
				                 </c:otherwise>
				             </c:choose>
		                 </tbody>
		             </table>
		          </div>
		          	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
						 <a class="nav-link" href="/admin/localList">
						  <button class="btn btn-primary me-md-2" type="button">LockList</button>
                        </a>
					</div>
					<div class="row mt-3">
		             <div class="col">
		                 <!-- 페이지번호 부분 -->
		                  <div class="pagination justify-content-center">
		                     ${ pagingImg2 }
		                  </div>
				   	</div>
		         </div>
		      </div>
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
		  
</body>
</html>