<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!doctype html>
	<html lang="en" data-bs-theme="auto">
	  <head><script src="../assets/js/color-modes.js"></script>

		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="description" content="">
	    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
	    <meta name="generator" content="Hugo 0.122.0">
	    <title>Carousel Template · Bootstrap v5.3</title>
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
	    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/carousel/">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
		<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="../files/style.css" rel="stylesheet">
	    <link href="../carousel/carousel.css" rel="stylesheet">
		<script>
		function validateForm(form) {
			if (form.title.value == "") {
				alert("제목을 입력하세요.");
				form.title.focus();
				return false;
			}
			if (form.content.value == "") {
				alert("내용을 입력하세요.");
				form.content.focus();
				return false;
			}
		}
		</script>
	  </head>
	  <body>
	  <%@ include file="../layout/header.jsp" %>
			<div class="row">			
				<div class="col-2 ps-3">			
				   <div style="height: 100px; line-height: 100px; text-align: center; 
					color:white; background-color:#03346E; font-size: 1.5em; border-radius:10px; margin: 25px 0 10px 0;">
	              	카테고리
	         		</div>
	         		
	         		<div class="nav flex-column nav-pills dropdown dropend" style="background-color: #7FA1C3; border-radius:10px;" id="v-pills-tab"   
	         		role="tablist" aria-orientation="vertical">
		             	<a class="nav-link" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab"
		                 aria-controls="v-pills-home" aria-selected="true">home</a>		 
		                                   
		             	<a class="nav-link" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab"
		                 aria-controls="v-pills-home" aria-selected="true">공지사항</a>
		                 
		            	 <a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab"
		                 aria-controls="v-pills-profile" aria-selected="false">지도</a>
		                 
		             	<a class="nav-link dropdown-toggle " data-bs-toggle="dropdown" id="v-pills-messages-tab" data-toggle="pill" 
		             	href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">커뮤니티</a>
		                <div class="dropdown-menu">
		                     <a class="dropdown-item" href="#">정보 게시판 </a>
		                     <a class="dropdown-item" href="#">인기 게시판</a>
		                </div>
		                 
		             	<a class="nav-link dropdown-toggle " data-bs-toggle="dropdown" id="v-pills-messages-tab" data-toggle="pill" 
		             	href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">문의사항</a>
		                <div class="dropdown-menu">
							<a class="dropdown-item" href="#">자주 물어보는 질문</a>
							<a class="dropdown-item" href="#">1대1문의</a>
						</div>
	     			</div>
				</div>
		       
			<div class="col-10 pt-3 mt-3">
				<h4>
				커뮤니티 - <small>정보게시판</small>
				</h4>
	            <form enctype="multipart/form-data" action="/member/edit" method="post" onsubmit="return validateForm(this)">
	            <input type="hidden" name="idx" value="${dto.idx}" />
	            <input type="hidden" name="existingOfile" value="${existingOfile}" />
	            <input type="hidden" name="existingSfile" value="${existingSfile}" />	            
	                <table class="table table-bordered">
	                <colgroup>
	                    <col width="20%"/>
	                    <col width="*"/>
	                </colgroup>
	                <tbody>
	                <tr>
	                    <th class="text-center" 
	                        style="vertical-align:middle;">번호</th>
	                	    <td>
	            	            ${dto.idx }
	   		                </td>
	                    </tr>
	                    <tr>
	                        <th class="text-center" 
	                            style="vertical-align:middle;">작성자</th>
	                        <td>
	                            <input type="text" name="id" class="form-control" 
	                                style="width:100px;" value="${dto.id}" readonly/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="text-center" 
	                            style="vertical-align:middle;">제목</th>
	                        <td>
	                            <input type="text" name="title" class="form-control" value="${dto.title}" />
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="text-center" 
	                            style="vertical-align:middle;">내용</th>
	                        <td>
	                            <textarea rows="5" name="content" class="form-control">${dto.content}</textarea>
	                        </td>
	                    </tr>
	                    <tr>
						    <th class="text-center" style="vertical-align:middle;">첨부 파일</th>
						    <td>
						        <c:if test="${not empty dto.ofile}">
						            <p>현재 파일: ${dto.ofile}</p>
						            <input type="hidden" name="existingOfile" value="${dto.ofile}" />
						            <input type="hidden" name="existingSfile" value="${dto.sfile}" />
						        </c:if>
						        <input type="file" name="file" class="form-control" />
						        <small>새 파일을 선택하지 않으면 기존 파일이 유지됩니다.</small>
						    </td>
						</tr>
	                </tbody>
	                </table>
	                
	                <div class="row">
	                    <div class="col text-right mb-4 d-flex justify-content-end">
	                        <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='boardInfo';">리스트보기</button>
	                        <button type="submit" class="btn btn-outline-primary mx-1" onclick>수정하기</button>
	                        <button type="reset" class="btn btn-outline-primary mx-1">Reset</button>
	                    </div>
                	</div>
	            </form>
	        </div>
		</div>
			   
		<%@ include file="../layout/footer.jsp" %>
	</body>
</html>
