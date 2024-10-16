<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
    <meta name="generator" content="Hugo 0.122.0">
    <title>문의 게시판</title>
    <link rel="canonical" href="https://getbootstrap.kr/docs/5.3/examples/modals/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
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
        --bd-violet-bg: #712cf9;
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
      
       main { padding-top: 100px; padding-bottom: 100px; }

    </style>
	</head>
		<body>	
		<%@ include file="../layout/header.jsp"%>
		<main>
			<div class="modal modal-sheet position-static d-block p-4 py-md-10" tabindex="-1" role="dialog" id="modalSignin">
			  <div class="modal-dialog p-10" role="document">
			    <div class="modal-content rounded-4 shadow">
			      <div class="modal-header p-5 pb-4 border-bottom-0">
			        <h6 class="fw-bold mb-0 fs-2">비밀번호를 입력해주세요.</h6>
			        <!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick=" self.close();"></button> -->
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="location.href='../guest/inquiryBoard';"></button>
			      </div>
			      <div class="modal-body p-5 pt-0">
			        <form>
			        	<input type="hidden" value="${idx }"  name="idx"/>
			          <div class="form-floating mb-3">
			            <input type="password" class="form-control rounded-3" placeholder="Password" id="Password1"/>
			            <label for="floatingPassword">Password</label>
			          </div>
			          	<button class="w-100 mb-2 btn btn-lg rounded-3 btn-primary" type="button" onclick="getValueInText();" id="passbutton">확 인</button>
			       </form>
			      </div>
			    </div>
			  </div>
			</div>
		</main>
	<%@ include file="../layout/footer.jsp"%>
	
    </body>
    
    <script type="text/javascript">
   		 /* function getValueInText(){
   			let inputData = document.getElementById("Password1").value;
   			if(inputData == ${dto.boardPass}){
   				location.href='inquiryBoardview?idx=${dto.idx}';
   			}
   			else{
   				alert('비밀번호가 틀렸습니다.');
   			}
   		} 
   		
	   	 document.getElementById("Password1").addEventListener("keypress", function(event) {
	         // 모든 브라우저에서 엔터키를 감지하도록 수정
	         if (event.key === "Enter" || event.keyCode === 13 || event.which === 13) {
	             event.preventDefault(); // 기본 엔터키 동작 방지
	             getValueInText(); // 입력 값 체크 함수 호출
	         }
	     });

       document.getElementById("passbutton").addEventListener("click", getValueInText);

       function getValueInText(){
           let inputData = document.getElementById("Password1").value;
           if(inputData === `${dto.boardPass}`){
               location.href = `inquiryBoardview?idx=${dto.idx}`;
           } else {
               alert('비밀번호가 틀렸습니다.');
           }
       } */
       
      
 
    	function getValueInText() {
    	    let inputData = document.getElementById("Password1").value;
    	    if (inputData === `${dto.boardPass}`) {
    	        location.href = `inquiryBoardview?idx=${dto.idx}`;
    	    } else {
    	        alert('비밀번호가 틀렸습니다.');
    	    }
    	}
    </script>
    
</html>
