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
	$('.under_list_box').on('click', '.btn_d_update', fn_domainUpdate);
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
	$('.under_list_box').on('click', '.btn_d_update', fn_domainUpdate);
	
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
function fn_domainUpdate(){
	var domainTr = $(this).closest('.domainTr');
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


