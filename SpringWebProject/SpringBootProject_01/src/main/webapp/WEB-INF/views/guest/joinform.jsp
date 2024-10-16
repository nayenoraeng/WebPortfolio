<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="../layout/header.jsp"%>   
	<!doctype html>
	<html lang="en" data-bs-theme="auto">
	  <head><script src="../assets/js/color-modes.js"></script>

	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="description" content="">
	    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
	    <meta name="generator" content="Hugo 0.122.0">
	    <title>스마일로드 : 회원가입</title>
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
	    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/carousel/">
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
		<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	    <script>
	   		function validateInput(input) {
	    	  input.value = input.value.replace(/\s/g, ''); // 공백 제거
	    	}
	    
		    $(document).ready(function(){
				// 취소
// 				$(".cencle").on("click", function(){
// 					location.href = "/";
// 				})
				
				//공백란 검사
				$("#submit").on("click", function(){
					if($("#id").val()==""){
						$('#id-feedback').text('아이디를 입력해주세요.').css('color', 'red');
						$("#id").focus();
						return false;
					}
					if($("#pass").val()==""){
						$('#pass-feedback').text('비밀번호를 입력해주세요.').css('color', 'red');
						$("#pass").focus();
						return false;
					}
					if($("#passcheck").val()==""){
						$('#passcheck-feedback').text('비밀번호확인을 입력해주세요.').css('color', 'red');
						$("#passcheck").focus();
						return false;
					}
					
					if($("#pass").val() != $("#passcheck").val()){
						$('#passcheck-feedback').text('비밀번호를 동일하게 입력해주세요.').css('color', 'red');
						$("#passcheck").focus();
						return false;
					}
					
					if($("#name").val()==""){
						$('#name-feedback').text('이름을 입력해주세요.').css('color', 'red');
						$("#name").focus();
						return false;
					}
					if($("#phoneNum").val()==""){
						$('#phoneNum-feedback').text('핸드폰번호를 입력해주세요.').css('color', 'red');
						$("#phoneNum").focus();
						return false;
					}
					if($("#email").val()==""){
						$('#email-feedback').text('이메일을 입력해주세요.').css('color', 'red');
						$("#email").focus();
						return false;
					}
					if($("#postcode").val()==""){
						$('#postcode-feedback').text('우편번호를 입력해주세요.').css('color', 'red');
						$("#postcode").focus();
						return false;
					}
					if($("#address").val()==""){
						$('#address-feedback').text('주소를 입력해주세요.').css('color', 'red');
						$("#address").focus();
						return false;
					}
					if($("#detailaddress").val()==""){
						$('#detailaddress-feedback').text('상세주소를 입력해주세요.').css('color', 'red');
						$("#detailaddress").focus();
						return false;
					}
					if($("#duplidcheck").val()==""){
						$('#id-feedback').text('아이디 중복검사를 해주세요').css('color', 'red');
						$("#id").focus();
						return false;
					}
					if(!$('input:checkbox[id="agree"]').is(":checked")){
						$('#agree-feedback').text('개인정보수집 동의에 체크 해주세요').css('color', 'red');
						return false;
					}
				});
			})	
	    
			
	   		 //아이디 중복검사
	        $(document).ready(function() {
	        	var isIdAvailable = false;
	            $('#duplidcheck').on('click', function() {
	                var id = $('#id').val();
	                if (id.length >= 3) { // 최소 3자 이상일 때만 검사
	                    $.ajax({
	                        url: '/guest/idCheck',
	                        type: 'POST',
	                        data: { id: id },
	                        success: function(response) {
	                            if (!response) {
	                                $('#id-feedback').text('중복된 아이디를 사용할 수 없습니다.').css('color', 'red');
	                                isIdAvailable = false;
	                            } else {
	                                $('#id-feedback').text('아이디 중복 확인 완료하였습니다.').css('color', 'green');
	                                isIdAvailable = true;
	                            }
	                        },
	                        error: function(xhr, status, error) {
	                            console.error('Error checking id:', error);
	                        }
	                    });
	                } else {
	                    $('#id-feedback').text('');
	                }
	            });
	            
	            $('#joinFrm').on('submit', function(event) {
	                var id = $('#id').val();
	                if (!isIdAvailable) {
	                    event.preventDefault(); // 폼 제출 막기
	                    alert('아이디 중복 확인을 해주세요.');
	                }
	            });
	            
	        });
	    	
	    	//비밀번호 확인창과 비교
	    	 $(document).ready(function() {
		            $('#passcheck').on('input', function (){
			    	    if($('#pass').val() == $('#passcheck').val()){
			    	        $('#passcheck-feedback').text('');
			    	    }else{
			    	        $('#passcheck-feedback').text('비밀번호가 일치하지 않습니다').css('color', 'red')
			    	        $("#passcheck").focus();
			    	    }
		            });
		        });
	    	

		    //비밀번호 조건 검사
		    $(document).ready(function() {
		            $('#pass').on('input', function (){
		            	var pass = $("#pass").val();
		            	var reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		            	var blank = /[\s]/g;
		            	if(!reg.test(pass)){
		            		 $('#pass-feedback').text('비밀번호를 영문,숫자,특수문자를 조합하여 8~15자리 사이로 입력해주세요.').css('color', 'red');
		            		 $('#pass').focus();
		            		 return false;
		            	} else if( blank.test(pass) == true){
		            		$('#pass-feedback').text('공백이 입력되었습니다.').css('color', 'red');
		            	}else {
		            		$('#pass-feedback').text('사용가능한 비밀번호입니다.').css('color', 'green');
		            	}

		            });
		            
		            $(function(){
			        	const pwInput = $("#pass");
			            $('.pw_show input[type="checkbox"]').on('change', function() {
			                if (this.checked) {
			                    pwInput.prop("type", "text");
			                } else {
			                    pwInput.prop("type", "password");
			                }
			            });
			        });
		        });
		    
		    //아이디 조건 검사
		    $(document).ready(function() {
	            $('#id').on('input', function (){
	            	var id = $("#id").val();
	            	var reg =/^[a-zA-Z]{5,15}$|^[a-zA-Z0-9]{5,15}$/;
	            	if(!reg.test(id)){
	            		 $('#id-feedback').text('아이디를 영문 또는 숫자와 조합하여 5~15자리 사이로 입력해주세요.').css('color', 'red');
	            		 $('#id').focus();
	            		 return false;
	            	}  	else {
	            		$('#id-feedback').text('');
	            	}

	            });
	        });
		    
		    $(document).ready(function() {
	            $('#name').on('input', function() {
	                var name = $(this).val();  // 수정: 'name' 변수로 변경
	                var regname = /^[a-zA-Z가-힣]*$/;
	                if (!regname.test(name)) {
	                    $('#name-feedback').text('이름은 한글 혹은 영어만 입력 가능합니다.').css('color', 'red');
	                    $('#name').focus();
	                } else {
	                    $('#name-feedback').text('');
	                }
	            });
		    });
		    
		    //휴대폰유효성 검사 및 자동하이픈 주
		    $(document).ready(function() {
	            $('#phoneNum').on('input', function() {
	                var input = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 추출
	                var formatted = '';

	                if (input.length > 7) {
	                    formatted = input.replace(/^(\d{3})(\d{4})(\d{4})$/, '$1-$2-$3');
	                } else if (input.length > 3) {
	                    formatted = input.replace(/^(\d{3})(\d{0,4})$/, '$1-$2');
	                } else {
	                    formatted = input;
	                }

	                $(this).val(formatted);

	                // 유효성 검사
	                var reg_mobile = /^01[0-9]{1}-[0-9]{4}-[0-9]{4}$/;
	                if (!reg_mobile.test(formatted)) {
	                    $('#phoneNum-feedback').text('휴대폰번호가 잘못된 형식입니다.').css('color', 'red');
	                } else {
	                    $('#phoneNum-feedback').text('');
	                }
	            });
	        });

		    $(document).ready(function() {
	            $('#email').on('input', function() {
	                var email = $(this).val();
	                var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$/;
	                if (emailRegex.test(email)) {
	                    $('#email-feedback').text('사용가능한 이메일입니다.').css('color', 'green');
	                } else {
	                    $('#email-feedback').text('이메일 형식이 맞는지 확인해주세요').css('color', 'red');
	                }
	            });
	        });
		    
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
		  
		  .modal {
			    display: none;
			    position: fixed;
			    z-index: 1;
			    left: 0;
			    top: 0;
			    width: 100%;
			    height: 100%;
			    overflow: auto;
			    background-color: rgb(0,0,0);
			    background-color: rgba(0,0,0,0.4);
			}
			
			.modal-content {
			    background-color: #fefefe;
			    margin: 15% auto;
			    padding: 20px;
			    border: 1px solid #888;
			    width: 80%;
			}
			
			.close {
			    color: #aaa;
			    float: right;
			    font-size: 28px;
			    font-weight: bold;
			}
			
			.close:hover,
			.close:focus {
			    color: black;
			    text-decoration: none;
			    cursor: pointer;
			}
	    </style>

	    
	    <!-- Custom styles for this template -->
	    <link href="../carousel/carousel.css" rel="stylesheet">
	  </head>
	  <body>	   
	    <header>
			
		</header>
		
			<main>
			<div class="input-form-backgroud row">
				<div class="input-form col-md-12 mx-auto">
			        <h4 class="mb-3">회원가입</h4>
			        <form class="validation-form" action="join" method="post" id="joinFrm">
					<div class="mb-3">
						<label for="id">아이디</label>
						<button type="button" class="btn btn-primary btn-sm my-1" style="float:right" id="duplidcheck" value="중복확인">
				            	아이디확인</button>
						<input type="text" class="form-control" id="id" name="id" oninput="validateInput(this)"
						placeholder="영문과 숫자로 작성해주세요" required>
						<span id="id-feedback"></span>
						<div class="invalid-feedback">
						  아이디을 입력해주세요.
						</div>
					</div>
						
					<div class="row">
						 <div class="col-md-6 mb-3">
						    <label for="pwd">비밀번호</label>
						    <input type="password" class="form-control" id="pass" name="pass" oninput="validateInput(this)"
						    placeholder="영문, 숫자, 특수기호를 모두사용해주세요" value="" required>
						    <span id="pass-feedback"></span>
						    <div class="invalid-feedback">
						      비밀번호를 입력해주세요
						    </div>
						 </div>
						 <div class="col-md-6 mb-3">
						    <label for="pwdcheck">비밀번호확인</label>
						    <input type="password" class="form-control" id="passcheck" name="passcheck" oninput="validateInput(this)"
						    placeholder="비밀번호를 한번 더 입력해주세요" value="" required>
							<span id="passcheck-feedback"></span>
							<div class="invalid-feedback">
						      비밀번호 확인을 해주세요.
							</div>
						</div>
						<div class="text-end">
	            		<label for="show" class="pw_show"><input type="checkbox" id="show"> 비밀번호 표시</label>
	        			</div>
					</div>
					
					<div class="mb-3">
						<label for="name">이름</label>
						<input type="text" class="form-control" id="name" name="name" oninput="validateInput(this)"
						placeholder="이름을 작성해주세요" required>
						<span id="name-feedback"></span>
						<div class="invalid-feedback">
						  이름을 입력해주세요.
						</div>
					</div>					
					
					<div class="mb-3">
					  <label for="phoneNumber">휴대전화</label>
					  <input type="text" class="form-control" id="phoneNum" name="phoneNum" maxlength='13' oninput="validateInput(this)"
					  placeholder="010-0000-0000" required>
					  <span id="phoneNum-feedback"></span>
					  <div class="invalid-feedback">
					   휴대전화번호를 입력해주세요
					  </div>
					</div>
			          
					 <div class="row">
					 	<div class="mb-3">
					 		<label for="email">이메일</label>
					 		<input type="email" class="form-control" id="email" name="email" oninput="validateInput(this)"
					 		placeholder="you@example.com" value="" required>
					 		<span id="email-feedback"></span>
					 		<div class="invalid-feedback">
					 		 이메일을 입력해주세요.
					 		</div>
					 	</div>
					</div>	  
						
						<div class="mb-3">
				            <label for="address">주소</label>
				            <button type="button" class="btn btn-primary btn-sm my-1" style="float:right" onclick="sample6_execDaumPostcode()" value="주소 찾기">
				            	주소 찾기</button>
				            <input type="text" class="form-control" id="postcode" name="postcode" placeholder="우편번호" required>
				            <span id="postcode-feedback"></span>
				            <div class="invalid-feedback">
				              우편번호를 입력해주세요.
				            </div>
				            <br/>
				            <input type="text" class="form-control" id="address" name="address" placeholder="서울특별시 강남구" required>
				            <span id="address-feedback"></span>
				            <div class="invalid-feedback">
				              주소를 입력해주세요.
				            </div>
			          	</div>
	
			          	<div class="mb-3">
				            <label for="address2">상세주소<span class="text-muted"></span></label>
				            <input type="hidden" class="form-control" id="sample6_extraAddress" placeholder="상세주소를 입력해주세요.">
				            <br/>
				            <input type="text" class="form-control" id="detailaddress" name="detailaddress" placeholder="상세주소를 입력해주세요.">
							<span id="detailaddress-feedback"></span>
							<div class="invalid-feedback">
				              상세주소를 입력해주세요.
				            </div>		          	
			          	</div>						
		
					      <hr class="mb-4">
					      <div class="custom-control custom-checkbox">
					        <input type="checkbox" class="custom-control-input" id="agree" name="agree"required>
					        <label class="custom-control-label" for="agree">개인정보 수집 및 이용에 동의합니다.</label>
					        <button  class="btn btn-primary" type="button" id="privacy-detail-btn">자세히</button><br>
					        <span id="agree-feedback"></span>
					      </div>
					      <!-- 개인정보 동의 내용 모달 -->
						    <div id="privacy-modal" class="modal">
						        <div class="modal-content">
						            <span class="close">&times;</span>
						            <h2>개인정보 수집 및 이용 동의</h2>
						            <p>
						                홈페이지 회원제 운영을 위하여 아래와 같이개인정보를 수집, 이용 및 제공하고자 합니다.<br/>
						                내용을 자세히 읽으신 후 동의 여부를 결정하여 주십시오.<br/><br/>
						                
						                1. 개인 정보의 수집항목 및 수집방법<br/>
						                수집하는 개인정보의 항목<br/>
						                항목 : 이름, 집주소, e-mail, 핸드폰번호<br/>
						                수집목적: 홈페이지 서비스이용 및 회원 관리 <br/>
						                보유기관: 회원탈퇴시 까지(2년 주기 재동의 진행)<br/><br/>
						                
						                컴퓨터에 의해 자동으로 수집되는 정보<br/>
						                홈페이지를 이용할 경우 다음의 정보는 로그인 기록을 통하여 자동적으로 수집, 저장됩니다.<br/>
						                접속 로그, 쿠키, 접속 IP 정보, 가입 경로<br/><br/>
						                
						                2. 개인정보 제3자 제공내역 <br/>
						                개인정보를 제3자에게 제공하지 않습니다. 단, 다음에 해당하는 경우에는 예외로 제공할 수 있습니다.<br/>
						                [관련근거: 개인정보보호법 제18조 제2항]<br/>
						                1) 정보주체로부터 별도의 동의를 받은 경우<br/>
						                2) 다른 법률에 특별환 규정이 있는 경우<br/>
						                3) 정보주체 또는 그 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우 <br/>
						                명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우<br/>
						                4) 통계작성 및 학술연구 등의 목적을 위하여 필요한 경우로서 특정 개인을 알아볼 수 없는 형태로 개인정보를 제공하는 경우<br/>
						                5) 개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공하지 아니하면 법률에서 정하는 소관없무를 수행할 수 없는 경우<br/>
						                보호위원회의 심의, 의결을 거친 경우 <br/>
						                6) 조약, 그밖의 국제협정의 이행을 위하여 외국정부 또는 국제기구에 제공하기 위하여 필요한 경우 <br/>
						                7) 범죄의 수사와 공소의 제기 및 유지를 위하여 필요한 경우<br/>
						                8) 법원의 재판업무 수행을 위하여 필요한 경우 <br/>
						                9) 형 및 감호, 보호처분의 집행을 위하여 필요한 경우<br/>
						                <br/>
						                정보주체는 개인 정보 수집 이용 동의를 거부할 수 있습니다.<br/><br/>
						                그러나 동의 거부시 홈페이지에 가입이 되지 않으며, 홈페이지에서 회원에게 제공하는 서비스를 이용할 수 없습니다.<br/>
						            </p>
						        </div>
						    </div>
					      <div class="mb-4">
					      <button id="submit"class="btn btn-outline-primary" type="submit" value="가입하기" >가입 완료</button>
					      </div>
				 </form>
			 </div>
			</div>		 
		   <hr class="featurette-divider">  
		   <script>
		   document.addEventListener('DOMContentLoaded', (event) => {
			    var modal = document.getElementById("privacy-modal");
			    var btn = document.getElementById("privacy-detail-btn");
			    var span = document.getElementsByClassName("close")[0];

			    btn.onclick = function() {
			        modal.style.display = "block";
			    }

			    span.onclick = function() {
			        modal.style.display = "none";
			    }

			    window.onclick = function(event) {
			        if (event.target == modal) {
			            modal.style.display = "none";
			        }
			    }
			});
		  
		   </script>
		   	
		  <!-- FOOTER -->
		  	<footer>
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
	<!-- 카카오 주소 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	
	<script>
            function sample6_execDaumPostcode() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
        
                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var addr = ''; // 주소 변수
                        var extraAddr = ''; // 참고항목 변수
        
                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }
        
                        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                        if(data.userSelectedType === 'R'){
                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                extraAddr += data.bname;
                            }
                            // 건물명이 있고, 공동주택일 경우 추가한다.
                            if(data.buildingName !== '' && data.apartment === 'Y'){
                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if(extraAddr !== ''){
                                extraAddr = ' (' + extraAddr + ')';
                            }
                            // 조합된 참고항목을 해당 필드에 넣는다.
                            document.getElementById("sample6_extraAddress").value = extraAddr;
                        
                        } else {
                            document.getElementById("sample6_extraAddress").value = '';
                        }
        
                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.getElementById('postcode').value = data.zonecode;
                        document.getElementById("address").value = addr;
                        // 커서를 상세주소 필드로 이동한다.
                        document.getElementById("detailaddress").focus();
                    }
                }).open();
            }
        </script>
        <!-- 카카오 주소 api 끝 -->

	   </body>
	</html>
