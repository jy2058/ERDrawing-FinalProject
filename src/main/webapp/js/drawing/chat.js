var chatWebSocket;

$(document).ready(function(){
	connectChatWS();
});

function connectChatWS(){
	var chatWS = new WebSocket("ws://localhost/erdEcho?erdNo="+erdNo);
	chatWebSocket = chatWS;
	
	chatWS.onopen = function(){
		console.log("채팅 웹소켓 오픈");
		
		chatWS.onmessage = function(event){
			var msg = event.data;
			console.log("msg : " + msg);
		}
		
		chatWS.onclose = function(event){console.log("채팅 웹소켓 종료");}
		chatWS.onerror = function(err){console.log("채팅 웹소켓 에러", err);}
	}
}

$("#sendBtn").on("click", function(){
	chatWebSocket.send("메시지!");
});
