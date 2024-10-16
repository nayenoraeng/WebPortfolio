<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!doctype html>
<html lang="en" data-bs-theme="auto">
<head>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.122.0">
<title>Smile Road - 모두가 웃을 수 있는 길잡이</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<link rel="canonical"
	href="https://getbootstrap.com/docs/5.3/examples/carousel/">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../files/style.css" rel="stylesheet">
<link href="../carousel/carousel.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</head>

<body>
	<%@ include file="../layout/header.jsp"%>

	<div class="row">
		<div class="col-10 pt-3 mt-3 mx-auto">
			<h4>
			커뮤니티 - <small>정보게시판</small>
			</h4>
			<form enctype="multipart/form-data" method="post" action="write"
				name="writeFrm">
				<table class="table table-bordered">
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th class="text-center" style="vertical-align: middle;">번호</th>
							<td>${dto.idx}</td>
						</tr>
						<tr>
							<th class="text-center" style="vertical-align: middle;">작성자</th>
							<td>${dto.id }</td>
						</tr>
						<tr>
							<th class="text-center" style="vertical-align: middle;">제목</th>
							<td>${dto.title }</td>
						</tr>
						<tr>
							<th class="text-center" style="vertical-align: middle;">내용</th>
							<td><c:if
									test="${ not empty dto.ofile and isImage eq true }">
									<br>
									<img src="/static/files/${dto.sfile }" style="max-width: 100%;" />
									<br />
								</c:if> ${dto.content }</td>
						</tr>
						<tr>
							<th class="text-center" style="vertical-align: middle;">첨부파일</th>
							<td><c:if test="${ not empty dto.ofile }">
		            				${ dto.ofile }
		            			</c:if></td>
						</tr>


					</tbody>
				</table>

				<div class="row">
					<div class="col text-right mb-4 d-flex justify-content-end">
						<button type="button" class="btn btn-outline-primary mx-1"
							onclick="location.href='boardInfo';">리스트보기</button>
						<sec:authorize access="isAuthenticated()">
							<button type="button" class="btn btn-outline-primary mx-1"
								onclick="location.href='/member/like?idx=${dto.idx}';">좋아요</button>
						</sec:authorize>
						<c:if test="${loggedInUserId eq dto.id}">
							<button type="button" class="btn btn-outline-primary mx-1"
								onclick="location.href='/member/boardEditor?idx=${dto.idx}';">수정하기</button>
							<button type="button" class="btn btn-outline-danger mx-1"
								onclick="deletePost(${dto.idx});">삭제하기</button>
						</c:if>
					</div>
				</div>
			</form>
			
			<div id="commentList" class="card">
				<div class="card-header">댓글리스트</div>
					<div class="textarea-container">
						<form action="/member/writeComment?idx=${dto.idx}" method="post" onsubmit="return validateForm(this)">
							<textarea class="form-control mt-3" id="commentText" name="commentText" rows="3" placeholder="댓글을 입력하세요"></textarea>
							<button class="btn btn-outline-primary mx-1" type="submit">댓글쓰기</button>
						</form>
					</div>
				<c:if test="${not empty comments}">
					<p>&nbsp;&nbsp; 댓글 갯수: ${comments.size()} 개</p>
					<ul id="reply-box" class="list-group">
						<c:forEach var="cDto" items="${comments}">
							<c:choose>
								<c:when test="${cDto.deleted eq '1' }">
									<li>삭제된 댓글입니다.</li>
								</c:when>
								<c:otherwise>
									<li id="reply-${cDto.cidx}" class="list-group-item">
										<div id="commentText-${cDto.cidx}" name="commentText">${cDto.commentText}</div>
										<div>
											작성자: <strong>${cDto.writer}</strong>
										</div>
										<div>작성일: ${cDto.regidate}</div>
										<div id="editForm-${cDto.cidx}" style="display: none;">
											<textarea id="editCommentText-${cDto.cidx}"
												name="commentText" class="form-control">${cDto.commentText}</textarea>
											<button type="button" class="btn btn-primary mt-2"
												onclick="submitEdit('${cDto.cidx}', '${cDto.refGroup}')">수정완료</button>
											<button type="button" class="btn btn-secondary mt-2"
												onclick="cancelEdit('${cDto.cidx}')">취소</button>
										</div>
										<div class="d-flex">
											<c:if test="${loggedInUserId eq cDto.writer}">
												<button type="button" class="btn btn-outline-warning mx-1"
													onclick="showEditForm('${cDto.cidx}')">수정하기</button>
												<button type="button" class="btn btn-outline-danger mx-1"
													onclick="location.href='/member/deleteComment?cidx=${cDto.cidx}&refGroup=${cDto.refGroup}';">삭제하기</button>
											</c:if>
										</div>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</ul>
				</c:if>
				<c:if test="${empty comments}">
					<p>&nbsp;&nbsp;댓글이 없습니다.</p>
				</c:if>
			</div>
		</div>
	</div>
	<%@ include file="../layout/footer.jsp"%>
	
	<script>
		function validateForm(form) {
			var comment = document.getElementById("commentText").value.trim();
			if (comment == "") {
				alert("댓글 내용을 입력하세요.");
				document.getElementById("commentText").focus();
				return false;
			} else {
				return true;
			}
		}
		
		function deletePost(idx) {
		    var confirmed = confirm("정말로 게시글을 삭제하겠습니까?"); 
		    if (confirmed) 
		    {
		        var form = document.writeFrm;      
		        form.method = "post";  
		        form.action = '../member/delete?idx=' + idx; 
		        form.submit();  
		    }
		}
		
	    function showEditForm(cIdx) {
	        document.getElementById('commentText-' + cIdx).style.display = 'none';
	        document.getElementById('editForm-' + cIdx).style.display = 'block';
	    }
	
	    function cancelEdit(cIdx) {
	        document.getElementById('editForm-' + cIdx).style.display = 'none';
	        document.getElementById('commentText-' + cIdx).style.display = 'block';
	    }
	
	    function submitEdit(cIdx, refGroup) {
	        var commentText = document.getElementById('editCommentText-' + cIdx).value;

	        // AJAX 요청으로 서버에 데이터 전송
	        fetch('/member/editComment', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded'
	            },
	            body: new URLSearchParams({
	                'cidx': cIdx,
	                'refGroup': refGroup,
	                'commentText': commentText
	            })
	        })
	        .then(response => response.text())
	        .then(data => {
	            console.log('Success:', data);
	            location.reload(); // 수정 후 페이지 새로고침
	        })
	        .catch((error) => {
	            console.error('Error:', error);
	        });
	    }
	    
	</script>
</body>
</html>
