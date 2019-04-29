var chatWebSocket;

$(document).ready(function(){
	connectChatWS();
});

function connectChatWS(){
	var chatWS = new WebSocket("ws://localhost/chatEcho?erdNo="+erdNo);
	console.log("chatWS: " + chatWS);
	chatWebSocket = chatWS;
	
	chatWS.onopen = function(){
		console.log("채팅 웹소켓 오픈");
		
		chatWS.onmessage = function(event){
			var msg = event.data.split("★");
			console.log("msg : " + msg);
			var senderId = msg[0];
			var content = msg[1];
			var sendErdNo = msg[2];
			if(erdNo == sendErdNo){
				$("#inputTxt").append(senderId + " : " + content + "<br>");
			}
			
		}
		
		chatWS.onclose = function(event){console.log("채팅 웹소켓 종료");}
	}
	chatWS.onerror = function(err){console.log("채팅 웹소켓 에러", err);}
}

$("#sendBtn").on("click", function(){
	var sendChat = $("#sendChat").val();
	chatWebSocket.send(sendChat + "★" + erdNo);
});
