<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
<head>
<script src="/docs/5.3/assets/js/color-modes.js"></script>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
<meta name="generator" content="Hugo 0.122.0">
<title>채팅 상담</title>
<link rel="canonical"
	href="https://getbootstrap.kr/docs/5.3/examples/modals/">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
<link href="/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../carousel/carousel.css" rel="stylesheet">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<script>
	    function chatWinOpen() {
	    	var chatRoomId = "${Id}chatRoom";
	        var s_width = window.screen.width;
	        var s_height = window.screen.height;

	        var newWidth = 500;  // 새 창 너비
	        var newHeight = 500; // 새 창 높이

	        var leftVar = s_width / 2 - newWidth / 2;
	        var topVar = s_height / 2 - newHeight / 2;

	        // 새 창 열기
	        var newWindow = window.open("../member/chatRoom?chatRoomId="+ chatRoomId, "newPopup", 
	            "width=" + newWidth + ",height=" + newHeight + ",left=" + leftVar + ",top=" + topVar);

	        if (newWindow) {
	            window.opener = null;
	            window.close();
	        } else {
	            alert("팝업이 차단되었습니다. 팝업 차단 설정을 해제하세요.");
	        }
	    }
	</script>
    <style>
    
    body {
            margin: 0;
            padding: 0;
            overflow: hidden; /* 화면의 공백을 제거 */
        }
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

      .bd-mode-toggle {
        z-index: 1500;
      }

      .bd-mode-toggle .dropdown-menu .active .bi {
        display: block !important;
      }
    </style>

<link href="modals.css" rel="stylesheet">
</head>
<body>
	<div
		class="modal modal-sheet position-static d-block bg-body-secondary p-4 py-md-5"
		tabindex="-1" role="dialog" id="modalChoice">
		<div class="modal-dialog" role="document">
			<div class="modal-content rounded-3 shadow">
				<div class="modal-body p-4 text-center">
					<h5 class="mb-0">채팅 상담을 시작하시겠습니까?</h5>
					<p class="mb-0">채팅 상담시 상담사와 연결됩니다.</p>
				</div>
				<div class="modal-footer flex-nowrap p-0">
					<!-- <button type="button" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 py-3 m-0 rounded-0 border-end"
		        	onclick="chatWinOpen();" id="enterBtn"> -->
					<button type="button" onclick="chatWinOpen()"
						class="btn btn-lg btn-link fs-6 text-decoration-none col-6 py-3 m-0 rounded-0 border-end"
						id="enterBtn">
						<strong>네, 채팅 상담을 시작합니다.</strong>
					</button>
					<button type="button"
						class="btn btn-lg btn-link fs-6 text-decoration-none col-6 py-3 m-0 rounded-0"
						data-bs-dismiss="modal" onClick='window.close();'>아니요.
						다음에 할게요.</button>
				</div>
			</div>
		</div>
	</div>
	<script src="/docs/5.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>
