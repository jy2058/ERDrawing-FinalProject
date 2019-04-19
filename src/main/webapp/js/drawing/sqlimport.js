//ERD로 변환하기 전, sql이 create,alter.drop인지 판별하고 해당 메서드로 보내준다.
function  	drawERD(arr_query){
	for(var i = 0; i<arr_query.length-1; i++ ){ //마지막 방은 비어있으므로 -1로 빼준다.
		arr_query[i] = arr_query[i].trim();
		if(arr_query[i].toUpperCase().startsWith('CREATE')){
			console.log('create');
			drawCreateTable(arr_query[i]);
		}
		else if(arr_query[i].toUpperCase().startsWith('ALTER')){
			console.log('alter');
			drawAlterTable(arr_query[i]);
		}
		else if(arr_query[i].toUpperCase().startsWith('DROP')){
			console.log('drop');
			//drawDropTable(arr_query[i]);
		}
		else{
			console.log("****예외*****");
		}
	}
}

//생성 쿼리를 그려주는 메서드
function drawCreateTable(arr_query){
	console.log(arr_query);
	
}

//수정 쿼리를 그려주는 메서드
function drawAlterTable(arr_query){
	console.log(arr_query);
	
}