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
		
		<script type="text/javascript">
	    function validateForm(form) {  // 필수 항목 입력 확인
	        if (form.id.value == "") {
	            alert("작성자를 입력하세요.");
	            form.id.focus();
	            return false;
	        }
	        if (form.boardPass.value == "") {
	            alert("비밀번호를 입력하세요.");
	            form.boardPass.focus();
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
	    
	    
	    function passChangebtn() {
	        let isPassChange = confirm("비밀번호를 변경하시겠습니까?");
	        
	        if (isPassChange) {
	            let btn = document.getElementById('passbtn'); // 버튼 요소를 가져옵니다.
	            let boardPassbox = document.getElementById('boardPassbox'); // 비밀번호 입력 박스 요소를 가져옵니다.

	            // 비밀번호 입력 박스를 활성화합니다.
	            boardPassbox.disabled = false;

	            // 버튼의 값을 '변경 완료'로 설정합니다.
	            btn.value = '변경 완료';

	            // 버튼을 클릭했을 때 passChange 함수를 호출하도록 설정합니다.
	            btn.onclick = passChange;
	        }
	    }

	    function passChange() {
	        let btn = document.getElementById('passbtn');
	        let boardPassbox = document.getElementById('boardPassbox');
	        let boardIdx = "${dto.idx}";
	        
	        // 비밀번호 값을 가져옵니다.
	        let newPassword = boardPassbox.value;

	        // 비밀번호가 입력되지 않은 경우 경고를 표시하고 함수를 종료합니다.
	        if (!newPassword) {
	            alert("비밀번호를 입력하세요.");
	            return;
	        }
	        if(newPassword == "${dto.boardPass }"){
	        	alert("이전 비밀번호와 동일합니다.");
	            return;
	        }

	        // 서버로 비밀번호 변경 요청을 보냅니다.
	        $.ajax({
	            type: "POST",
	            url: "../member/changeBoardPass",
	            data: {
	            	idx: boardIdx,
	                boardPass: newPassword // 비밀번호 값을 서버로 전송합니다.
	            },
	            success: function(response) {
	                alert("변경이 완료되었습니다.");
	    	        // 비밀번호 입력 박스와 버튼을 비활성화
	    	        btn.disabled = true;
	    	        btn.value = "변경";
	    	        boardPassbox.disabled = true;
	            },
	            error: function(error) {
	                alert("비밀번호 변경에 실패했습니다. 다시 시도하세요.");
	            }
	        });
	    }
		</script> 
	  <link href="../carousel/carousel.css" rel="stylesheet">
	</head>
	
	<body>	
		<%@ include file="../layout/header.jsp"%>
	
		<main>
		     <div class="col-10 pt-3 mt-3 mx-auto">
		     <h3>문의 게시판 - <small>수정하기</small></h3>
		     <hr>
			<div class="row mt-3 mx-1 mx-auto">
			    <form enctype="multipart/form-data" action="inquiryBoardEditor?idx=${dto.idx}" method="post" onsubmit="return validateForm(this);">
	                <table class="table table-bordered">
	                <colgroup>
	                    <col width="20%"/>
	                    <col width="*"/>
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th class="text-center" 
	                            style="vertical-align:middle;">작성자</th>
	                        <td>
	                            <input type="text" class="form-control" 
	                                style="width:100px;" name="id" value="${dto.id }" disabled/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="text-center" 
	                            style="vertical-align:middle;">비밀번호</th>
	                        <td>
	                        	<input type="password" class="form-control" style="width:200px; display: inline-block;" name="boardPass"  id="boardPassbox" value="${dto.boardPass }" disabled/>
    							<input type="button" id="passbtn" class="btn btn-outline-dark" style="display: inline-block; margin-left: 10px;" onclick="passChangebtn()" value="변경"></input>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="text-center" 
	                            style="vertical-align:middle;">제목</th>
	                        <td>
	                            <input type="text" class="form-control" name="title" value="${dto.title }" />
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="text-center" 
	                            style="vertical-align:middle;">내용</th>
	                        <td>
	                            <textarea rows="9" class="form-control" name="content">${dto.content }</textarea>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="text-center" 
	                            style="vertical-align:middle;">첨부파일</th>
	                        <td>
	                            <c:if test="${not empty dto.ofile}">
						            <p>현재 파일: ${dto.ofile}</p>
						            <input type="hidden" name="existingOfile" value="${dto.ofile}" />
						            <input type="hidden" name="existingSfile" value="${dto.sfile}" />
						        </c:if>
						        <input type="file" name="ofile" class="form-control" />
						        <small>새 파일을 선택하지 않으면 기존 파일이 유지됩니다.</small>
	                        </td>
	                    </tr>
	                </tbody>
	                </table>
	                <input type="hidden" class="form-control" name="isAnnouncement" value="Y" />                	                
	                <div class="row"> <!--버튼 부분-->
	                    <div class="col text-right mb-4 d-flex justify-content-end">
		                   <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='../guest/inquiryBoard';">리스트보기</button>
	                        <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='inquiryBoardDelete?idx=${dto.idx}';">삭제하기</button>
	                        <button type="submit" class="btn btn-outline-primary mx-1">수정완료</button>
	                        <button type="reset" class="btn btn-outline-primary mx-1">Reset</button>
	                    </div>
	                </div>
	            </form>
		   	</div>      

		  </div>
		</main>	 
		<%@ include file="../layout/footer.jsp"%>

		</body>
	</html>
