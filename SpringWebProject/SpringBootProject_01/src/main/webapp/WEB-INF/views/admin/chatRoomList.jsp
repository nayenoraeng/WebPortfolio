<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="jakarta.tags.core" %>   
<html>
	<head>
	<title>채팅 상담 리스트</title>
	
		<link href="/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	    
	    <script type="text/javascript">
		    function openChatRoom(url) {
	            window.open(url, 'chatWindow', 'width=500,height=520,scrollbars=yes,resizable=yes');
	            return false; 
	        }
	    </script>
	    
		<style type="text/css">
		 /* link - 아직 클릭하지 않은 경우 */
		 a:link { color: black; text-decoration: none;}	
		 /* visited - 한번 클릭하거나 전에 클릭한적 있을 경우 */
		 a:visited { color: black; text-decoration: none;}	
		 /* hover - 마우스를 해당 링크에 위치했을 경우*/
		 a:hover { color: blue; text-decoration: underline;}
		</style>
	
	</head>

	<body> 
	    <div class="container">
	        <h2>Chat Room List</h2>
		        <ol class="list-group list-group-numbered">
		            <c:if test="${not empty chatRooms}">
		                <c:forEach var="chatRoomId" items="${chatRooms}">
		                    <li class="list-group-item">
		                        <a href="/member/chatRoom?chatRoomId=${chatRoomId}" onclick="return openChatRoom(this.href);">${chatRoomId}</a>
		                    </li>
		                </c:forEach>
		            </c:if>
		            <c:if test="${empty chatRooms}">
		                <li class="list-group-item">채팅방 리스트가 존재하지 않습니다.</li>
		            </c:if>
		        </ol>
	    </div>
	</body>	

 
 