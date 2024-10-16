<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!doctype html>
	<html lang="en" data-bs-theme="auto">
	<head>	 
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>	    <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Hugo 0.122.0">
		<title>문의 게시판</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
		<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/carousel/">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
		<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
		

		<script>
		function deletePost(idx){
		    var confirmed = confirm("정말로 삭제하겠습니까?"); 
		    if (confirmed) {
		        var form = document.writeFrm;      
		        form.method = "GET";  
		        form.action = "inquiryBoardDelete";
		        form.submit();  
		    }
		}
		</script>	
	
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
		     <h3>문의게시판</h3> 
		     <hr>
		     	<form name="writeFrm">
		     		<input type="hidden" name="idx" value="${dto.idx }" /> 
		     	</form>
		         
			<div class="row mt-3 mx-1 mx-auto">
		         <form>
		            <table class="table table-bordered">
		            <colgroup>
		                <col width="20%"/>
		                <col width="30%"/>
		                <col width="20%"/>
		                <col width="*"/>
		            </colgroup>
		            <tbody>
		            	 <tr>
		                    <th class="text-center" 
		                        style="vertical-align:middle;">제목</th>
		                    <td colspan="3">
		                        ${dto.title}
		                    </td>
		                </tr>
		                <tr>
		                    <th class="text-center" 
		                        style="vertical-align:middle;">작성자</th>
		                    <td>
		                        ${dto.id}
		                    </td>
		                    <th class="text-center" 
		                        style="vertical-align:middle;">작성일</th>
		                    <td>
		                        ${dto.postDate}
		                    </td>
		                </tr>
		                <tr>
		                    <th class="text-center" 
		                        style="vertical-align:middle;">조회수</th>
		                    <td>
		                        ${dto.viewCount}
		                    </td>
		                    <th class="text-center" 
		                        style="vertical-align:middle;">답변 </th>
		                    <td>
		                    	<c:if test="${dto.responses > 0 }">
		                    		답변 완료
		                    	</c:if>
		                    	<c:if test="${dto.responses eq 0 }">
		                    		답변 대기
		                    	</c:if>
		                    </td>
		                </tr>
		                <tr style="height: 300px">
		                    <th class="text-center" 
		                        style="vertical-align:middle;">내용</th>
		                    <td colspan="3">
		                        ${dto.content} 
		                        <c:if test="${ not empty dto.ofile and isImage eq true }">
		                        	<img src="/static/files/${ dto.sfile }" style="max-width:100%;"/><br>
		                        </c:if>
		                    </td>
		                </tr>
		                <tr>
		                    <th class="text-center" 
		                        style="vertical-align:middle;">첨부파일</th>
		                    <td colspan="3">
		                    	<c:if test="${ not empty dto.ofile }">
		            				${ dto.ofile }
						            <%-- <a href="../mvcboard/download.do?ofile=${ dto.ofile }&sfile=${ dto.sfile }&idx=${ dto.idx }"> --%>
						            <%-- <a href="../views/download.do?ofile=${ dto.ofile }&sfile=${ dto.sfile }&idx=${ dto.idx }">
						                [다운로드] --%>
						        </c:if>
		                    </td>
		                </tr>
		            </tbody>
		            </table>
		            
		            <div class="row">
		            	<div class="col d-flex justify-content-start">
		            		<%-- <button type="button" id="likeButton" class="btn btn-outline-danger" onclick="location.href='inquiryBoardlikeCount?idx=${dto.idx}';"><i class="bi bi-heart-fill"></i> 좋아요</button>
		            		<button type="button" id="likeButton" class="btn btn-outline-danger" onclick=check()><i class="bi bi-heart-fill"></i> 좋아요</button> --%>
		            	</div>
		                <div class="col d-flex justify-content-end">
		                   <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='../guest/inquiryBoard';">리스트보기</button>
		                   <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='inquiryBoardEditorForm?idx=${dto.idx}';">수정하기</button>
		                   <sec:authorize access="hasRole('ADMIN')">
		                   		<button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='../admin/inquiryBoardReplyWriteForm?idx=${dto.idx}';">답변하기</button>
		                   </sec:authorize>
		                  <%--  <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='inquiryBoardDelete?idx=${dto.idx}';">삭제하기</button> --%>
		                   <button type="button" class="btn btn-outline-primary mx-1" onclick="deletePost(${dto.idx});">삭제하기</button>
		                </div>
		            </div>
           		 </form> 
		   	   </div>
		   	</div>
		</main>	 
	<%@ include file="../layout/footer.jsp"%>
			
		</body>
	</html>
	
	
