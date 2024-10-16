<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
<c:set var="hash" value="******" />

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
		
		<script type="text/javascript">
		   function movePage(page) { // 검색 데이터 보내기

		        const form = document.getElementById('searchForm');

		        const queryParams = {
		            searchField: form.searchField.value,
		            searchWord: form.searchWord.value
		        }
		        location.href = location.pathname + '?' + new URLSearchParams(queryParams).toString();
		    }
		    
		   function boardPassPop(){  //로그인 안되어 있을때
			  var answer = window.confirm("비회원은 열람이 불가능합니다. 로그인 하시겠습니까?");
    	   		if(answer==true){
    	   			window.open("../security/loginform");
    	   		return window.histroy.back();
    	   		}
		   } 
		   
		   function memberBoardPassPop(idx){  // 작성자와 아이디가 같다면 비밀번호 검색창으로 이동
			   var s_width = window.screen.width;
               var s_height = window.screen.height;            
               
               var leftVar = s_width/2 - 500/2;
               var topVar = s_height/2 - 500/2;
              
               window.open("../member/inquiryBoardPass?idx="+idx, "popup", 
                   "width=600,height=380,left="+leftVar+",top="+topVar);
		   } 
		   
		   function boardPassPop2(){ // 작성자가 아닌 다른 이용자가 글을 눌렀을때
			   alert("작성자 본인만 열람이 가능합니다.");
		   } 
		   
		</script>
		<script>
			function chatPop(){
				var s_width = window.screen.width;
				var s_height = window.screen.height;            
				
				var leftVar = s_width/2 - 500/2;
				var topVar = s_height/2 - 500/2;
				
				window.open("../member/chatPopup", "popup", 
				    "width=600,height=250,left="+leftVar+",top="+topVar);
			}
			
			function chatPoplist(){
				var s_width = window.screen.width;
				var s_height = window.screen.height;            
				
				var leftVar = s_width/2 - 500/2;
				var topVar = s_height/2 - 500/2;
				
				window.open("../admin/chatRoomList", "popup", 
				    "width=600,height=250,left="+leftVar+",top="+topVar);
			}
			
			function myBoardList() {
			    var isChecked = document.getElementById('myboardList').checked;
			    var loginID = '${Id}';  

			    localStorage.setItem('myBoardListChecked', isChecked);

			    if (isChecked) {
			        window.location.href = `/guest/inquiryBoard?searchField=id&searchWord=` + loginID;
			    } else {
			        window.location.href = '/guest/inquiryBoard';
			    }
			}

			document.addEventListener('DOMContentLoaded', (event) => {
			    var isChecked = localStorage.getItem('myBoardListChecked') === 'true';
			    document.getElementById('myboardList').checked = isChecked;
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
		
		</style>	 
		
		<style type="text/css">
		 /* link - 아직 클릭하지 않은 경우 */
		 a:link { color: black; text-decoration: none;}	
		 /* visited - 한번 클릭하거나 전에 클릭한적 있을 경우 */
		 a:visited { color: black; text-decoration: none;}	
		 /* hover - 마우스를 해당 링크에 위치했을 경우*/
		 a:hover { color: black; text-decoration: underline;}
		</style>
	  <link href="../carousel/carousel.css" rel="stylesheet">
	</head>
	
	<body>	
		<%@ include file="../layout/header.jsp"%>

		<main>
		     <div class="col-10 pt-3 mt-3 mx-auto">
		     <h3>문의게시판</h3>
		     <small>
		     	<c:if test="${ not empty searchWord }">
				    	전체&nbsp;${totalCount}건&nbsp;${ pageNum}/${totalCount}
				</c:if>
		     </small>
		     <hr>
				<div class="row">
		             <!-- 검색부분 -->
					<sec:authorize access="!isAnonymous()">
						<div class="d-flex justify-content-end">
						    <div class="form-check form-switch">
						        <input class="form-check-input" type="checkbox" id="myboardList" onchange="myBoardList()">
						        <label class="form-check-label" for="flexSwitchCheckDefault" >내글만 보기</label>
						    </div>
						</div>
					</sec:authorize>
					
					<form method="get" id="searchForm"> 
						<div class="input-group ms-auto" style="width: 300px; ">
							<c:choose>
								<c:when test="${searchField == 'content'}">
									<select name="searchField" class="form-control">
									    <option value="title">제목</option>
   									    <option value="id" >작성자</option>
									    <option value="content" selected="selected">내용</option>
									</select>
								</c:when>
								<c:when test="${searchField == 'id'}">
									<select name="searchField" class="form-control">
									    <option value="title">제목</option>
									    <option value="id" selected="selected">작성자</option>
									    <option value="content" >내용</option>
									</select>
								</c:when>
								<c:otherwise>
									<select name="searchField" class="form-control">
									    <option value="title" selected="selected">제목</option>
									    <option value="id" >작성자</option>
									    <option value="content" >내용</option>
									</select>
								</c:otherwise>
							</c:choose>
							<input class="form-control" type="search" placeholder="Search" aria-label="Search" name="searchWord" value="${searchWord }">
							<button class="btn btn-outline-primary" type="button" onclick="movePage(1);"><i class="bi bi-search" style='font-size:20px'></i></button>
						</div>
					</form>  
					
					
		         </div>
		         
		         <div class="row mt-3 mx-1 mx-auto">
		             <!-- 게시판리스트부분 -->
		             <table class="table table-bordered table-hover table-striped">
		                 <colgroup>
		                     <col width="40px" />
		                     <col width="350px" />
		                     <col width="80px" />
		                     <col width="80px" />
		                     <col width="50px" />
		                     <col width="50px" />
		                     <col width="30px" />		                    
		                 </colgroup>
		                 <thead>
		                     <tr style="background-color: rgb(133, 133, 133); " class="text-center text-white">
		                         <th>번호</th>
		                         <th>제목</th>
		                         <th>작성자</th>
		                         <th>작성일</th>
		                         <th>상태</th> 		                         
		                         <th>조회수</th>
		                         <th>첨부</th> 		                         
		                     </tr>
		                 </thead>
		                 <tbody>
		                 	<c:choose>
		                 		<c:when test="${ empty list }">  
							        <tr>
							            <td colspan="7" align="center">
							                등록된 게시물이 없습니다^^*
							            </td>
							        </tr>
							    </c:when>
			                 	<c:otherwise> 
				                    <c:forEach items="${list}" var="dto" varStatus="loop">
										<tr align="center">
											<td>${totalCount - (((pageNum-1) * pageSize) + loop.index)}</td>
						    		 		<c:choose>
										        <c:when test="${ dto.parentIdx eq 0}">
										        	<td align="left">
										        		<i class="bi bi-lock-fill"></i> 
		      												<sec:authorize access="isAnonymous()"> <!-- 로그인 안 되어 있을때 -->
		      													<a href="javascript:boardPassPop();">${dto.title}</a>
		      												</sec:authorize>
															<sec:authorize access="!isAnonymous() and  hasRole('ADMIN')"> <!-- 로그인 되어있을때 -->
																<a href="../member/inquiryBoardview?idx=${dto.idx }">${dto.title}</a>
															</sec:authorize>
															<sec:authorize access="!isAnonymous() and hasRole('USER')"> <!-- 로그인 되어있을때 -->
																<c:if test="${ dto.id == Id }">
																	<a href="../member/inquiryBoardPass?idx=${dto.idx }">${dto.title}</a>
																</c:if>
																<c:if test="${ dto.id != Id }">
					 												<a href="javascript:boardPassPop2();">${dto.title}</a>
		      													</c:if> 
															</sec:authorize>
	      												
      													<c:if test="${dto.postDate == today}"><span class="badge rounded-pill bg-danger">new</span></c:if>
      												</td>
										        </c:when>
										        <c:otherwise>
										        	<td align="left" style="color:red; font-weight:bold;">&nbsp; &nbsp; &nbsp; &nbsp; <i class="bi bi-arrow-return-right"></i>
											        	<sec:authorize access="isAnonymous()"><!--  로그인 안했을때 -->
	       													<a href="javascript:boardPassPop();"> ${dto.title}</a>
	       												</sec:authorize>
	       												<sec:authorize access="!isAnonymous() and  hasRole('ADMIN')"> <!-- 로그인하고 admin일때 -->
	       													<a href="../member/inquiryBoardview?idx=${dto.idx}"> ${dto.title}</a>
	       												</sec:authorize>
	       												<sec:authorize access="!isAnonymous() and  hasRole('USER')"> <!-- 로그인하고 이용자일때 -->
	       													<c:if test="${ dto.parentId == Id }">
	       														<a href="../member/inquiryBoardPass?idx=${dto.idx }">${dto.title}</a> <!-- 글작성자일때 -->
	       													</c:if>
	       													<c:if test="${ dto.parentId != Id }">
	       														<a href="javascript:boardPassPop2();">${dto.title}</a> <!-- 글작성자가 아닐때 -->
	       													</c:if>
	       												</sec:authorize>
       												</td>
										        </c:otherwise>
										    </c:choose>  
											<td>
												<c:choose>
							                 		<c:when test="${ dto.id == 'admin' }">  
												        관리자
												    </c:when>
								                 	<c:otherwise> 
														${dto.id.substring(0,3)}<c:out value="${hash}" />
								                 	</c:otherwise>
								                 </c:choose>
											</td>
											<td>${dto.postDate}</td>
											<td>
												<c:choose>
											        <c:when test="${dto.parentIdx eq 0 }">
											        	<c:if test="${dto.responses > 0 }">
								                    		답변 완료
								                    	</c:if>
								                    	<c:if test="${dto.responses eq 0 }">
								                    		답변 대기
								                    	</c:if>
											        </c:when>
											        <c:otherwise>
											        	
											        </c:otherwise>
											    </c:choose> 
											</td>
											<td>${dto.viewCount}</td>
											<c:choose>
										        <c:when test="${ not empty dto.ofile }">
													<td><a href="../member/inquiryBoardview?idx=${dto.idx}"><i class="bi bi-file-earmark-arrow-down"></i></a></td>
										        </c:when>
										        <c:otherwise>
										        	<td></td>
										        </c:otherwise>
										    </c:choose>											        									
										<tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
		                 </tbody>
		             </table>
		         </div>
		   		<div>
	               <div class="col d-flex justify-content-end">
	               	   <button type="button" class="btn btn-outline-primary mx-1" onclick="location.href='../guest/inquiryBoard';">리스트보기</button>
	                   <button type="button" class="btn btn-primary" onclick="location.href='../member/inquiryBoardWriteForm';">글쓰기</button>
	               </div>
	           </div>
		   
				<!-- 페이징 부분 -->
		         <div class="row mt-3">
		             <div class="col">
		                  <div class="pagination justify-content-center">
		                       ${ pagingImg }
		                  </div>
				   	</div>
		          </div> <!-- 페이징 끝  -->
		      </div>
		</main>	 
		<%@ include file="../layout/footer.jsp"%>

		</body>
	</html>
