


// 채팅입력 엔터
$("#sendChat").on("keydown", function(e){
	if(e.keyCode == 13){
		chatSend();
	}
});

// 채팅입력 클릭
$("#sendBtn").on("click", function(){
	chatSend();
});

// 채팅입력 보내기
function chatSend(){
	
	var chatContent = $("#sendChat").val();
	webSocket.send("chat" + "★"+ chatContent);
	
	// 보낸 채팅 insert
	$.ajax({
		type : "post",
		url : "/erddrawing/chatInsert",
		data : {
			chatContent : chatContent,
			erdNo : erdNo,
		},
		success : function(data) {
			$('#sendChat').val("");
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
	
}

$("#button42").on("click", function(){
	// 채팅 리스트 가져오기
	$.ajax({
		type : "post",
		url : "/erddrawing/chatList",
		data : {
			erdNo : erdNo
		},
		success : function(data) {
			var chatList = data.chatList;
			var html = "";
			for(var i in chatList){
				
				
				html += `<ul>
					<li><img src="/member/memberImg?memId=`+chatList[i].memId+`"></li>
					<li>
						<div class="msg_id">`+chatList[i].memId+`</div>
						<div style="position:relative; padding:10px;">
							<div class="msg_chat">`+chatList[i].chatContent+`</div>
							<span>`+getDateFormatMS(new Date(parseInt(chatList[i].chatInDt)))+`</span>
						</div>
					</li>
				</ul>`;
	
	
			}
			$("#inputTxt").html(html);
			$(".con_inner").scrollTop($('.con_inner2').height()+300);
			
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
});
