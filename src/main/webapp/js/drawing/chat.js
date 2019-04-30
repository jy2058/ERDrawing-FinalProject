
$("#sendBtn").on("click", function(){
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

		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
});

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
				html += chatList[i].memId + ' : ' + chatList[i].chatContent + '<br>';
				html += getDateFormatMS(new Date(parseInt(chatList[i].chatInDt)));
			}
			$("#inputTxt").html(html)
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
});
