<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!doctype html>
<html lang="en" data-bs-theme="auto">
<head>
<script src="../assets/js/color-modes.js"></script>
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
<title>Carousel Template · Bootstrap v5.3</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<link rel="canonical"
	href="https://getbootstrap.com/docs/5.3/examples/carousel/">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../files/style.css" rel="stylesheet">
<link href="../carousel/carousel.css" rel="stylesheet">
<script>
	function validateForm(form) {
		if (form.id.value == "") {
			alert("id를 입력하세요.");
			form.id.focus();
			return false;
		}
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
	<%@ include file="../layout/header.jsp"%>

	<div class="row">
		<div class="col-10 pt-3 mt-3 mx-auto">
			<h4>
			커뮤니티 - <small>정보게시판</small>
			</h4>
			<form enctype="multipart/form-data" action="write" method="post"
				onsubmit="return validateForm(this)">
				<table class="table table-bordered">
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th class="text-center" style="vertical-align: middle;">제목</th>
							<td><input type="text" name="title" class="form-control" />
							</td>
						</tr>
						<tr>
							<th class="text-center" style="vertical-align: middle;">내용</th>
							<td><textarea rows="9" name="content" class="form-control"></textarea>
							</td>
						</tr>
						<tr>
							<th class="text-center" style="vertical-align: middle;">첨부파일</th>
							<td><input type="file" name="file" class="form-control" />
							</td>
						</tr>
					</tbody>
				</table>

				<div class="row">
					<div class="col text-right mb-4 d-flex justify-content-end">
						<button type="button" class="btn btn-outline-primary mx-1"
							onclick="location.href='/guest/boardInfo';">리스트보기</button>
						<button type="submit" class="btn btn-outline-primary mx-1">작성하기</button>
						<button type="reset" class="btn btn-outline-primary mx-1">Reset</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>
