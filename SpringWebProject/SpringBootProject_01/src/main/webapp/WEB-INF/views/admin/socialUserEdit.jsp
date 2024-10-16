<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!doctype html>
	<html lang="en" data-bs-theme="auto">
	  <head><script src="../assets/js/color-modes.js"></script>

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
		  
		  .input-form {
		        max-width: 680px;
		        margin-top: 80px;
		        padding: 32px;
		        background: #fff;
		        -webkit-border-radius: 10px;
		        -moz-border-radius: 10px;
		        border-radius: 10px;
		        -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		        -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		        box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
		      }
	    </style>	   
	    
	    <script type="text/javascript">
		    var fnAlert = function() {
		        location.href="page";
		        alert('수정이 완료 되었습니다.');
		    }
	    </script>
	    
	    <!-- Custom styles for this template -->
	    <link href="../carousel/carousel.css" rel="stylesheet">
	  </head>
	  <body>
		<%@ include file="../layout/header.jsp"%>

		<main>
			<div class="input-form-backgroud row">
			      <div class="input-form col-md-12 mx-auto">
			        <h4 class="mb-3">회원정보 수정 페이지</h4>
			       <table class="table">
					    <tr>
					        <th>소셜유형</th>
					        <td>
					            <c:choose>
					                <c:when test="${dto.provider != null}">
					                    ${dto.provider}
					                </c:when>
					                <c:otherwise>
					                    정보 없음
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
					    <tr>
					        <th>아이디</th>
					        <td>
					            <c:choose>
					                <c:when test="${dto.providerId != null}">
					                    ${dto.providerId}
					                </c:when>
					                <c:otherwise>
					                    정보 없음
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
					    <tr>
					        <th>이름</th>
					        <td>
					            <c:choose>
					                <c:when test="${dto.name != null}">
					                    ${dto.name}
					                </c:when>
					                <c:otherwise>
					                    정보 없음
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
					    <tr>
					        <th>핸드폰번호</th>
					        <td>
					            <c:choose>
					                <c:when test="${dto.phoneNum != null}">
					                    ${dto.phoneNum}
					                </c:when>
					                <c:otherwise>
					                    정보 없음
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
					    <tr>
					        <th>이메일</th>
					        <td>
					            <c:choose>
					                <c:when test="${dto.email != null}">
					                    ${dto.email}
					                </c:when>
					                <c:otherwise>
					                    정보 없음
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
					    <tr>
					        <th>우편번호</th>
					        <td>
					            <c:choose>
					                <c:when test="${dto.postcode != null}">
					                    ${dto.postcode}
					                </c:when>
					                <c:otherwise>
					                    정보 없음
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
					    <tr>
					        <th>주소</th>
					        <td>
					            <c:choose>
					                <c:when test="${dto.address != null}">
					                    ${dto.address}
					                </c:when>
					                <c:otherwise>
					                    정보 없음
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
					    <tr>
					        <th>상세주소</th>
					        <td>
					            <c:choose>
					                <c:when test="${dto.detailaddress != null}">
					                    ${dto.detailaddress}
					                </c:when>
					                <c:otherwise>
					                    정보 없음
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
					    <tr>
					        <th>가입일</th>
					        <td>
					            <c:choose>
					                <c:when test="${dto.regidate != null}">
					                    <fmt:formatDate value="${dto.regidate}" pattern="yyyy-MM-dd"/>
					                </c:when>
					                <c:otherwise>
					                    정보 없음
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
					    <tr>
					        <th>권한</th>
					        <td>
					            <c:choose>
					                <c:when test="${dto.authority != null}">
					                    ${dto.authority}
					                </c:when>
					                <c:otherwise>
					                    정보 없음
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
					    <tr>
					        <th>잠금계정</th>
					        <td>
					            <c:choose>
					                <c:when test="${dto.isLock == 1}">
					                    NO
					                </c:when>
					                <c:otherwise>
					                     LOCK
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
					    <tr>
					        <th>휴면계정</th>
					        <td>
					        	 <c:choose>
					                <c:when test="${dto.enabled == 1}">
					                   활성화
					                </c:when>
					                <c:otherwise>
					                    휴면계정
					                </c:otherwise>
					            </c:choose>
					        </td>
					    </tr>
			       </table>
			       <script type="text/javascript">
			       function confirmChanges(form, type) {
			           // 값을 저장하기 위한 변수
			           const previousValue = form.querySelector('select[name="' + type + '"]').dataset.previousValue;
			           const currentValue = form.querySelector('select[name="' + type + '"]').value;
			           
			           // 값이 변경되었는지 확인
			           if (previousValue !== currentValue) {
			               return confirm('변경사항이 있습니다. 계속하시겠습니까?');
			           } else {
			               alert('변경사항이 없습니다.');
			               return false; // 변경사항이 없으면 폼 제출을 막습니다.
			           }
			       }

			       // 폼 제출 전에 변경사항 확인을 위한 함수
			       function handleSubmit(event, type) {
			           event.preventDefault(); // 폼 제출 기본 동작을 막습니다.
			           if (confirmChanges(event.target, type)) {
			               // 사용자 확인 후 폼 제출
			               event.target.submit();
			               alert('수정이 완료되었습니다.');
			           }
			       }  
			       </script>
			       
				<div>
					<div class="d-inline-flex">
						<div class="justify-content-center">
						<form action="/admin/updateAuth" method="POST" onsubmit="handleSubmit(event, 'authority');" class="form-control" style="border: none; box-shadow: none;">
						    <input type="hidden" name="id" value="${dto.providerId}" />
						    <select name="authority"  data-previous-value="${dto.authority}">
						        <option value="ROLE_USER" ${dto.authority == 'ROLE_USER' ? 'selected' : ''}>회원</option>
						        <option value="ROLE_ADMIN" ${dto.authority == 'ROLE_ADMIN' ? 'selected' : ''}>관리자</option>
						    </select>
						    <button class="btn btn-outline-primary" type="submit">변경</button>
						</form>
						</div>
						<div class="justify-content-center">
						<form action="/admin/updateEnabled" method="POST" onsubmit="handleSubmit(event, 'enabled');" class="form-control" style="border: none; box-shadow: none;">
						    <input type="hidden" name="id" value="${dto.providerId}" />
						    <select name="enabled"  data-previous-value="${dto.enabled}">
						        <option value="1" ${dto.enabled == '1' ? 'selected' : ''}>활성화</option>
						        <option value="0" ${dto.enabled == '0' ? 'selected' : ''}>비활성화</option>
						    </select>
						    <button class="btn btn-outline-primary"  type="submit">변경</button>
						</form>
						</div>
						<div class="justify-content-center">
						<form action="/admin/updateLock" method="POST" onsubmit="handleSubmit(event, 'isLock');" class="form-control" style="border: none; box-shadow: none;">
						    <input type="hidden" name="id" value="${dto.id}" />
						    <select name="isLock"  data-previous-value="${dto.isLock}">
						        <option value="1" ${dto.isLock == '1' ? 'selected' : ''}>잠금해제</option>
						        <option value="0" ${dto.isLock == '0' ? 'selected' : ''}>잠금설정</option>
						    </select>
						    <button class="btn btn-outline-primary"  type="submit">변경</button>
						</form>
						</div>
					</div>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end">
						 <a class="nav-link" href="/admin/socialList">
						  <button class="btn btn-primary me-md-2" type="button">목록보기</button>
                        </a>
					</div>
				</div>		   
		   </div>
	    </div>
		 
		   <hr class="featurette-divider">  
	
		  <!-- FOOTER -->
		  <<footer>
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
		</main>
	
		<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


	 </body>
	</html>
