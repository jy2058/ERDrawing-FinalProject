//웹소캣 테스트
var jsonz;
var ws = new WebSocket("ws://localhost:8080/erdEcho");
ws.onopen = function(){
	console.log('Info: connection opened.');

	ws.onmessage = function (event){
//		var msg = JSON.parse(event.data);
		var msg = event.data.split("★");
		
//		console.log("cmd:",msg.cmd,"editor:",msg.editor,"content:",msg.content);
		//console.log("cmd:",msg[0],"editor:",msg[1],"content:",msg[2]);
		
		switch(msg[0]){
			case 'domain':
				console.log(msg[2]);
				jsonLoad(msg[2]);
			break;
		}
		
	}
		
	ws.onclose = function(event){console.log('Info: connection closed.');}
	ws.onerror = function(err){console.log('Error:', err);}

}


function webSend(cmd, erdData){
	//evt.preventDefault();
	if(ws.readyState !== 1 )
		return;
	ws.send(cmd+"★"+erdData);
}


function jsonSave(){
	json = stage.toJSON();
    json = json +'@@' + numId;
    return json;
}


function jsonLoad(loadData){
	var arr_json=loadData.split('@@');
    stage2 = Konva.Node.create(arr_json[0], 'tmp_canvas');
    numId =   arr_json[1];

     layer.children.destroy();
     stage2.children.each(function(item1,i){
         
           while(item1.children.length > 0){   
             item1.children[0].moveTo(stage.children[i]);
             console.log("객체 추가");
           }
         
     });
     
     layer.draw();
     mini_layer.draw();
     
     
     entity.off('dblclick');
     //entity.on('dblclick', textClick);
    
     entity.off('mouseup');
     entity.off('mousedown');
    
     stage.off('click');
     stage.on('click', stageClick);

    //yhs================================
     // 엔티티를 클릭했을 경우(mouseup) 엔티티와 관계된 관계선들을 보여준다. 
     
   
      
    
    
    //yhs===========================================
    
    
    //dragEvent1
     stage.off('.dragSetup');
     stage.on('dragmove.dragSetup', function dragEvent1(evt){
         
         allNode = evt.target;
         
             if(allNode.hasName('entity')){
             console.log("entity : "+allNode.x());
             var mini_entity = mini_stage.find('#'+(evt.target.id()+10000)+'');
             
             mini_entity.x(evt.target.x()*0.048);
             mini_entity.y(evt.target.y()*0.048);
             mini_layer.draw();
             }
     }); // move end
     

}



//도메인 초기화 - ShinYS
var tmp_search_text = "";
fn_init_search(tmp_search_text);

//도메인 검색 <클릭 이벤트> - ShinYS
$('.btn_search').on('click', function(){
	var tmp_search_text = $('.box_search').val();
	fn_init_search(tmp_search_text);
});

//도메인 검색 <엔터 입력 이벤트> - ShinYS
$('.box_search').on('keydown', function(e){
	if(e.keyCode == 13){
		var tmp_search_text = $('.box_search').val();
		fn_init_search(tmp_search_text);
	}
});

//도메인 초기화 & 검색 함수 - ShinYS
function fn_init_search(tmp_search_text){
	$.ajax({
		type : "get",
		url : "/erddrawing/domainSearch",
		data : {
			domainNm : tmp_search_text,
			erdNo : erdNo
		},
		success : function(data) {

			var tmp_inner="";
			if(data.domainVoList != null){
				$.each(data.domainVoList, function(){
					
					var domainDefaultValue = (this.domainDefaultValue === null) ? '' : this.domainDefaultValue;
					var domainDataType = (this.domainDataType === null) ? '' : this.domainDataType;
					tmp_inner += `
						<tr class="domainTr" data-domainno="`+this.domainNo+`">
						    <td><input class="domainNm input_box" type="text" value="`+this.domainNm+`"/></td>
						    <td><input class="domainDataType input_box" type="text" value="`+domainDataType+`"/></td>
						    <td><input class="domainDefaultValue input_box" type="text" value="`+ domainDefaultValue +`"/></td>
						    <td class="btn_d_update"><div class="btn_inner"><i class="fas fa-sync-alt"></i></div></td>
						    <td class="btn_d_delete"><i class="fas fa-trash"></i></td>
						</tr>`;
				});
			}
			$('.under_list_box tbody').html("");
			$('.under_list_box tbody').append(tmp_inner);
			
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
	
	
	$('.under_list_box').off('click', '.btn_d_delete');
	$('.under_list_box').on('click', '.btn_d_delete', fn_domainRemove);
	
	$('.under_list_box').off('click', '.btn_d_update');
	$('.under_list_box').on('click', '.btn_d_update', function(evt){
		fn_domainUpdate(evt);
		webSend('domain',jsonSave());
	});
	
	
}




//도메인 row추가 - ShinYS
$('.btn_domain').on('click', function(){
	
	var tmp_inner = `
	<tr class="domainTr" data-domainno="0">
	    <td><input class="domainNm input_box" type="text"/></td>
	    <td><input class="domainDataType input_box" type="text"/></td>
	    <td><input class="domainDefaultValue input_box" type="text"/></td>
	    <td class="btn_d_update"><div class="btn_inner"><i class="fas fa-sync-alt"></i></div></td>
	    <td class="btn_d_delete"><i class="fas fa-trash"></i></td>
	</tr>`;
	
	$('.under_list_box tbody').append(tmp_inner);
	
	$('.under_list_box').off('click', '.btn_d_delete');
	$('.under_list_box').on('click', '.btn_d_delete', fn_domainRemove);
	
	$('.under_list_box').off('click', '.btn_d_update');
	$('.under_list_box').on('click', '.btn_d_update', function(evt){
		fn_domainUpdate(evt);
		webSend('domain',jsonSave());
	});

	
	$('.under_list_box tbody tr').last().find('.domainNm').focus();
	
});


//도메인 row삭제 - ShinYS
function fn_domainRemove(){
	var domainTr = $(this).closest('.domainTr');
	var domainNo = domainTr.data('domainno');
	
	if(domainTr.find('.domainNm').val() != "" || domainTr.data('domainno') != 0){
		if (confirm("정말 삭제하시겠습니까??") == false){
			return;
		}
	}
	
	if(domainTr.data('domainno') != 0){
		
		$.ajax({
			type : "get",
			url : "/erddrawing/domainDelete",
			data : {
				domainNo : domainNo
			},
			success : function(data) {
				
			},
			error : function(xhr, status, error) {
				console.log(error);
			}
		});
	}

	domainTr.remove();
}


//도메인 업데이트(추가,수정) - ShinYS
function fn_domainUpdate(evt){
	var target = evt.target;
	var domainTr = $(target).closest('.domainTr');
	var domainNo = domainTr.data('domainno');
	var domainNm = domainTr.find('.domainNm').val();
	var domainDataType = domainTr.find('.domainDataType').val();
	var domainDefaultValue = domainTr.find('.domainDefaultValue').val();
	
	if(domainNm === ""){
		alert('도메인 이름을 작성하시고 업데이트를 진행해주세요.');
		domainTr.find('.domainNm').focus();
		return;
	}
	
	var angle = 0;
	var btn_rotate = setInterval(function(){
	      angle+=10;
	      domainTr.find('.btn_d_update .btn_inner').css('-webkit-transform','rotate('+angle+'deg)');
	},40);
	
	$.ajax({
		type : "get",
		url : "/erddrawing/domainUpdate",
		data : {
			erdNo : erdNo,
			domainNo : domainNo,
			domainNm : domainNm,
			domainDataType : domainDataType,
			domainDefaultValue : domainDefaultValue
		},
		success : function(data) {
			domainTr.data('domainno',data.domainVo.domainNo);

			setTimeout(() => {
				clearInterval(btn_rotate);
				domainTr.find('.btn_d_update .btn_inner').css('-webkit-transform','rotate(0deg)');
				domainTr.find('.btn_d_update .btn_inner').html('<i class="fas fa-check-circle" style="color:#00ff08"></i>');
				domainTr.find('.btn_d_update .btn_inner').hide().fadeIn(400).delay( 500 ).fadeOut(400, function(){
					domainTr.find('.btn_d_update .btn_inner').html('<i class="fas fa-sync-alt"></i>');
					domainTr.find('.btn_d_update .btn_inner').show();

					
					
				});
			}, 500);
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
}


