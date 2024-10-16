<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!doctype html>
	<html lang="en" data-bs-theme="auto">
	<head>	 
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Hugo 0.122.0">
		<title>공지사항 게시판</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
		
		<style>
	        .content-edit {
	            display: none;
	            width: 100%; /* 너비를 조절합니다. 필요에 따라 조정하세요. */
			    height: 50px; /* 높이를 조절합니다. 필요에 따라 조정하세요. */
			    resize: vertical; /* 사용자가 세로 방향으로 크기를 조절할 수 있도록 합니다. */
	        }
	        .btn-edit, .btn-save {
	            margin-right: 5px;
	        }
	        .table-header {
            text-align: center;
            font-weight: bold;
        	}
	    </style>
		 
	  <link href="../carousel/carousel.css" rel="stylesheet">
	</head>
	
	<body>	
	<%@ include file="../layout/header.jsp"%>
	<main>
	     <div class="col-10 pt-3 mt-3 mx-auto">
		     <h4><strong>&nbsp;&nbsp;공지사항 게시판</strong> - <small>내용보기</small></h4>
		         
			  <div class="row mt-3 mx-1 mx-auto">
		         <form enctype="multipart/form-data" action="write" method="post" name="writeFrm">
	                <table class="table table-bordered">
		                <colgroup>
		                    <col width="20%"/>
		                    <col width="30%"/>
							<col width="20%"/>
							<col width="*"/>
		                </colgroup>
		                <tbody>
		                	<tr>
		                        <th class="text-center" style="vertical-align:middle;">제목</th>
		                        <td>${dto.title}</td>
		                        <th class="text-center" style="vertical-align:middle;">글번호</th>
		                        <td align="center">${dto.idx}</td>
		                    </tr>
		                	<tr>
		                        <th class="text-center" style="vertical-align:middle;">작성자</th>
		                        <td align="center">${dto.id}</td>
		                        <th class="text-center" style="vertical-align:middle;">작성일</th>
		                        <td align="center">${dto.postdate}</td>
		                    </tr>
		                    <tr>
		                    	<th class="text-center" style="vertical-align:middle;">조회수</th>
		                    	<td align="center">${dto.viewCount}</td>
		                    	<th class="text-center" style="vertical-align:middle;">추천</th>
		                    	<td align="center">${dto.likeCount}</td>
		                    </tr>
		                    <tr style="height: 300px">
		                        <th class="text-center" style="vertical-align:middle;">내용</th>
		                        <td colspan="3">
		                        	<c:if test="${ not empty dto.ofile and isImage eq true }">
		                        		<br/>
		                        		<img src="/static/files/${dto.sfile}" style="max-width: 100%;" />
		                        		<br/>
		                        	</c:if>
		                        	${dto.content}
		                        </td>
		                    </tr>
		                    <tr>
		                        <th class="text-center" style="vertical-align:middle;">첨부파일</th>
		                        <td colspan="3">
		                            <c:if test="${ not empty dto.ofile }">
		                            	${dto.ofile}
		                            </c:if>
		                        </td>
		                    </tr>
		                </tbody>
	                </table>
	                
	                <!-- 게스트 일 때 -->
	                <sec:authorize access="isAnonymous()">
	                	<div class="row">
		                    <div class="col text-right mb-4 d-flex justify-content-end">
		                        <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='noticeBoard';">리스트보기</button>
		                        <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='../guest/noticeLike?idx=${dto.idx}';">추천</button>
		                    </div>
	                	</div>
	                </sec:authorize>
	                <!-- 로그인 멤버 -->
                 	<sec:authorize access="hasRole('USER')">
                 		<div class="row">
		                    <div class="col text-right mb-4 d-flex justify-content-end">
		                        <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='noticeBoard';">리스트보기</button>
		                        <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='../guest/noticeLike?idx=${dto.idx}';">추천</button>
		                    </div>
	                	</div>
                 	</sec:authorize>
                 	<!-- 로그인 관리자 -->
	             	<sec:authorize access="hasRole('ADMIN')">
	             		<div class="row">
		                    <div class="col text-right mb-4 d-flex justify-content-end">
		                        <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='noticeBoard';">리스트보기</button>
		                        <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='../guest/noticeLike?idx=${dto.idx}';">추천</button>
		                        <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='../admin/noticeEditorForm?idx=${dto.idx}';">수정하기</button>
	                        	<button type="button" class="btn btn-outline-primary mx-1" onclick="deletePost(${dto.idx});">글삭제</button>
		                    </div>
	                	</div>
	             	</sec:authorize>
	             </form>
		   	  </div>      
		  </div>
		  
		  <!-- 댓글 부분 -->
		  <div><h4><strong>&nbsp;댓글달기</strong></h4></div>
		  <div class="card">
            <form action="../member/noticeComment" name="commentFrm">
            <input type="hidden" value="${dto.idx}"  name="idx">
              <div class="card-body d-flex">
                  <textarea id="reply-content" class="form-control me-2" rows="1" name="content1"></textarea>
                  <button type="submit" id="btn-reply-save" class="btn btn-primary" >등록</button>
              </div>
            </form>
          </div>
                
        <table class="table caption-top">
        <colgroup>
            <col width="60px">
            <col width="200px">
            <col width="80px">
            <col width="100px">
        </colgroup>
          <thead>
            <tr>
              <td colspan="4" class="table-header">댓글</td>
            </tr>
            <tr>
              <td align="center" class="table-header">아이디</td>
              <td align="center" class="table-header">내용</td>
              <td align="center" class="table-header">작성일</td>
              <td align="center" class="table-header">비고</td>
            </tr>
          </thead>
          <tbody>
          	<c:choose>
          		<c:when test="${ empty list }">
          			<tr>
          				<td colspan="4" align="center">
          					등록된 댓글이 없습니다.
          				</td>
          			</tr>
          		</c:when>
          		<c:otherwise>
          			<c:forEach items="${list}" var="dto" varStatus="loop">
          				<tr>
          					<td align="center">${dto.id}</td>
          					<td align="center">
          						<span class="content-text">${dto.content}</span>
                            	<textarea class="content-edit">${dto.content}</textarea>
          					</td>
          					<td align="center">${dto.postdate}</td>
          					<td align="center">
          						<button type="button" id="editButton" onclick="comentEdit(this, '${dto.coidx}', '${dto.id}');" aria-label="Edit" class="btn btn-primary">수정</button>
				              	<button type="button" onclick="deleteCommentPost(${dto.coidx}, '${dto.id}');"  class="btn btn-primary">삭제</button>
							</td>
				        </tr>
          			</c:forEach>
          		</c:otherwise>
          	</c:choose>
          </tbody>
        </table>
        
        <script>
        	//로그인 되어 있는 아이디 들고 옴 
		    var currentUserId = '${loginId}';
		    
		    //게시글 삭제
			function deletePost(idx)
			{
			    var confirmed = confirm("게시글을 삭제하겠습니까?"); 
			    if (confirmed) 
			    {
			        var form = document.writeFrm;      
			        form.method = "post";  
					form.action = "../admin/noticeDelete?idx="+idx; 
			        form.submit();  
			    }
			}	
	    	
			//댓글삭제
			function deleteCommentPost(coidx, id)
			{
				if(currentUserId === id)
				{
					var del = confirm("댓글을 삭제하겠습니까?");
					if(del)
			    	window.location.href = "../member/noticeCommentDelete?coidx=" + coidx; 
		    	}
		    	else
		    	{
		    		alert("작성자만 삭제 가능합니다.");
		    	}
			}
			
			//댓글수정
			function comentEdit(button, coidx, id) 
			{
		        const row = button.closest('tr');
		        const contentText = row.querySelector('.content-text');
		        const contentEdit = row.querySelector('.content-edit');

		        if(currentUserId === id)
				{
					var del = confirm("수정하시겠습니까?");
					if(del){
						if (button.textContent === '수정') {
				            contentText.style.display = 'none';
				            contentEdit.style.display = 'block';
				            button.textContent = '수정 완료';
				            button.onclick = () => editorComplete(button, coidx, contentEdit.value);
				        } else {
				            contentText.style.display = 'block';
				            contentEdit.style.display = 'none';
				            button.textContent = '수정';
				            button.onclick = () => comentEdit(button, coidx);

				            const updatedContent = contentEdit.value;
				            editorComplete(button, coidx, updatedContent);
				        }
					}
		    	}
		    	else
		    	{
		    		alert("작성자만 수정 가능합니다.");
		    	}
		         
		    }
			
			//댓글수정완료서버보내기
		    function editorComplete(button, coidx, updatedContent) {
		        $.ajax({
		            type: "POST",
		            url: "/guest/noticeCommentEditor",
		            data:{
		            	coidx : coidx,
		                content : updatedContent
		            },
		            success: function(response) {
		                alert("댓글 수정이 완료되었습니다.");
		                window.location.reload();
		            },
		            error: function(error) {
		                alert("다시 시도하세요.");
		            }
		        });
		    }
		</script>
	</main>	 
	<%@ include file="../layout/footer.jsp"%>

  </body>
</html>


