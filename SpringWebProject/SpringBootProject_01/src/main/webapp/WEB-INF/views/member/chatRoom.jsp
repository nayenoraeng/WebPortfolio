<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="jakarta.tags.core" %>   
<html>
<head>
<title>채팅 상담</title>
	
	<link href="/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <style>
		#chatArea{
			width: 100%; height: 400px; border: 1px solid black; margin-bottom: 10px;
			overflow:scroll; padding:10px; border-radius: 10px; overflow-x:hidden; background-color: #EEEEEE;
		}
		.message-container {
            display: flex;
            align-items: center;
            gap: 10px; /* 입력 필드와 버튼 사이 간격 */
        }
        #messageArea{margin: 5px;}
        
        body{margin: 10px;}
	
		 .scroll::-webkit-scrollbar {
		    width: 15px;
		  }
		  .scroll::-webkit-scrollbar-thumb {
		    background-color: rgba(0, 0, 0, 0.7);
		    border-radius: 10px;
		  }
		  .scroll::-webkit-scrollbar-track {
		    background-color: rgba(0, 0, 0, 0.3);
		    border-radius: 10px;
		  }
		  
		.myMsg{text-align:right;}
		.yourMsg{text-align:left;}
		.Msg{background-color:#B4E380; border-radius: 10px; margin: 2px; padding: 5px;}
		.sendMsg{background-color:#FFFBE6; border-radius: 10px; margin: 2px; padding: 5px;}
	  	.myId{text-align:right; margin: 4px;}
		.yourId{text-align:left; margin: 4px;}
		
		.form-group {
            display: flex;
            align-items: center;
        }
        .form-group input[type="text"] {
            flex: 1;
            margin-right: 10px; /* Adjust this value as needed */
        }
	</style>
    <script type="module">
    import { initializeApp } from 'https://www.gstatic.com/firebasejs/10.12.4/firebase-app.js'
    import { getDatabase, ref, onValue, set, child, push, onChildAdded, query, limitToLast } 
    	from 'https://www.gstatic.com/firebasejs/10.12.4/firebase-database.js'

    // Firebase 초기화
	const firebaseConfig = {
		apiKey: "AIzaSyAA0_ChiYuJUtGaP9JfrAeQwENWLtLNj7s",
   		authDomain: "springbootstudy-30b2d.firebaseapp.com",
    	databaseURL: "https://springbootstudy-30b2d-default-rtdb.asia-southeast1.firebasedatabase.app",
    	projectId: "springbootstudy-30b2d",
    	storageBucket: "springbootstudy-30b2d.appspot.com",
    	messagingSenderId: "67232356174",
    	appId: "1:67232356174:web:53ed52be77263cca5c701f"
	};

    const app = initializeApp(firebaseConfig);
	var db = getDatabase(app);

	// Connect function 수정
	function connect() {
   		const chatRoomId = document.getElementById("chatRoomId").value; // 서버에서 전달된 chatRoomId 사용
    	const dbRef = ref(db, 'messages/chatRooms/' + chatRoomId);

    	// 새로운 데이터 추가 시 실시간으로 화면에 표시
    	onChildAdded(dbRef, (data) => {
        	var name = data.val().sender;
			var msg = data.val().message;
			console.log(name);
			console.log(msg);
        	appendMessage(name, msg);
    	});
	}
   
	function appendMessage(name,msg) {
		const Id = document.getElementById("Id").value;

		if (name == Id) {
        	$('#chatMessageArea').append("<div class='myId'> " + name + "</div>" +
                                     "<div class='myMsg'><span class='Msg'>" + msg + "</span></div>");
   		 } else {
        	$('#chatMessageArea').append("<div class='yourId'> " + name + "</div>" +
                                     "<div class='yourMsg'><span class='sendMsg'>" + msg + "</span></div>");
    	}
    	
    	const chatAreaHeight = $('#chatArea').height();
    	const maxScroll = $('#chatMessageArea').height() - chatAreaHeight;
    	$('#chatArea').scrollTop(maxScroll);
	}

	$(document).ready(function() {
        connect();
   	});
    </script>
	 
	</head>
	
	<body> 
	    <div class="container">
	        <div class="d-flex justify-content-between align-items-center mb-3">
		        <h2>1 대 1 문의 채팅</h2>
		        <button onclick="deleteChatRoom('${chatRoomId}')" class="btn btn-outline-danger">채팅 종료</button>
		    </div>
	    	<div id="chatArea">
	    		<div id="chatMessageArea">
	    		</div>
	    	</div>
	        
	        <div class="form-group d-flex align-items-center">
	            <input type="text" id="messageInput" class="form-control" placeholder="메세지를 입력해주세요." style="width: 350px;"/>
	            <input type="hidden" id="chatRoomId" value="${chatRoomId}" /> 
	            <input type="hidden" id="Id" value="${Id}" />
		        <button onclick="sendMessage()" class="btn btn-primary ml-2">Send</button>
	        </div>
	    </div>
	    
		<script>
			// enter키 누르면 메세지 전송 되도록
			document.getElementById('messageInput').addEventListener('keydown', function(event) {
		        if (event.key === 'Enter') {
		            sendMessage();
		        }
		    });
		
		    function sendMessage() {
		        var messageInput = document.getElementById("messageInput");
		        var message = messageInput.value.trim();
		        var chatRoomId = document.getElementById("chatRoomId").value;
		        var chatMessageArea = document.getElementById('chatMessageArea');
		        var senderId = document.getElementById("Id").value;
		        var nowtimestamp = Date.now();
		        
		        if (message === "") {
		            alert("입력된 메세지가 없습니다!");
		            return;
		        }
		        
		        var chatMessage = {
		            sender: senderId,
		            message: message,
		            timestamp: nowtimestamp,
		            chatRoomId: chatRoomId
		        };
		        
		        fetch('/member/chatRoom/send', {
		            method: 'POST',
		            headers: {
		                'Content-Type': 'application/json'
		            },
		            body: JSON.stringify(chatMessage)
		        })
		        .then(response => response.json()) // 서버에서 반환한 JSON 데이터를 처리
		        .then(newMessage => {
		        	messageInput.value = "";
		        	chatMessageArea.scrollTop = chatMessageArea.scrollHeight;
		        })
		        .catch((error) => {
		            console.error('메세지 전송 실패:', error);
		        });
		    }
		    
		    
		    function deleteChatRoom(chatRoomId) {
		    	let chatClose = confirm("채팅방을 나가겠습니까? 채팅방 종료시 대화내용이 삭제됩니다.");
		    	
		    	if(chatClose){
			        fetch(`../member/chatRoom/deleteChatRoom?chatRoomId=`+ chatRoomId, {
			            method: 'DELETE'
			        })
			        .then(response => response.text())
			        .then(message => {
			            var ret = window.open("about:blank", "_self");
			            ret.close();
			        })
			        .catch(error => console.error('채팅방 삭제 중 오류 발생:', error));
		    	}
		    }
		    
	    </script>
	</body>	
</html>
 
 