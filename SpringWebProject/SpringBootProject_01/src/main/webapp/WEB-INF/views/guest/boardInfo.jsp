<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

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
<title></title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<link rel="canonical"
	href="https://getbootstrap.com/docs/5.3/examples/carousel/">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../carousel/carousel.css" rel="stylesheet">
<link href="../files/style.css" rel="stylesheet">
</head>

<body>
	<%@ include file="../layout/header.jsp"%>
	<main>
	<div class="col-10 pt-3 mt-3 mx-auto">
		<h4>
			커뮤니티 - <small>정보게시판</small>
		</h4>
		<div class="row">
			<!-- 검색부분 -->
			<form method="get" action="/guest/boardInfo">
				<div class="input-group ms-auto" style="width: 300px;">
					<select name="searchField" class="form-control">
						<option value="title"
							<c:if test="${searchField == 'title'}">selected</c:if>>제목</option>
						<option value="id"
							<c:if test="${searchField == 'id'}">selected</c:if>>작성자</option>
						<option value="content"
							<c:if test="${searchField == 'content'}">selected</c:if>>내용</option>
					</select> <input class="form-control" name="searchWord" placeholder="Search"
						value="${searchWord}" aria-label="Search">
					<button class="btn btn-outline-primary" type="submit">
						<i class="bi bi-search" style='font-size: 20px'></i>
					</button>
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
					<col width="120px" />
					<col width="60px" />
					<col width="60px" />
				</colgroup>
				<thead>
					<tr style="background-color: rgb(133, 133, 133);"
						class="text-center text-white">
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>추천수</th>
						<th><i class="bi bi-pin-angle-fill" style="font-size: 20px"></i></th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${ empty list }">
							<tr>
								<td colspan="7" align="center">등록된 게시물이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list }" var="dto" varStatus="loop">
								<tr align="center">
									<td class="text-center">${dto.idx}</td>
									<td class="text-left">
									<a href="boardInfoView?idx=${dto.idx}"> ${dto.title }&nbsp; 
										<jsp:useBean id="now" class="java.util.Date" />
												<fmt:formatDate	value="${now}" pattern="yyyy-MM-dd" var="today" />
												<c:if
												test="${dto.postdate == today}">
												<span class="badge rounded-pill bg-danger">new</span>
											</c:if>
									</a>
									</td>
									<td class="text-center">${dto.id }</td>
									<td class="text-center">${dto.postdate }</td>
									<td class="text-center">${dto.viewCount }</td>
									<td class="text-center">${dto.likeCount }</td>
									<td class="text-center"><c:if
											test="${ not empty dto.ofile }">
											<i class="bi bi-pin-angle-fill" style="font-size: 20px"></i>
										</c:if></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div>
			<div class="col d-flex justify-content-end">
				<button type="button" class="btn btn-primary"
					onclick="location.href='/guest/boardInfo';">글 목록</button>&nbsp;&nbsp;

				<button type="button" class="btn btn-primary"
					onclick="location.href='/member/boardWrite';">글쓰기</button>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col">
				<!-- 페이지번호 부분 -->
				<div class="pagination justify-content-center">${pagingImg}</div>
			</div>
		</div>
	</div>
	</main>
	<%@ include file="../layout/footer.jsp"%>

</body>
</html>
