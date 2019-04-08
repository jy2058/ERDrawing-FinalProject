/**
 * erdDrawing.jsp relation 기능에 관련된 스크립트 입니다.
 */


// entity 중에 _id가 일치하는 값을 찾기 위한 메서드
function findEntity(findEntityArr, id){
	id = parseInt(id);
	for(var i =0; i<findEntityArr.length; i++){
		if(findEntityArr[i]._id == id){
			return findEntityArr[i]; 
		}
	}
}


function findLine(arr, id){ //해당 아이디 값을  seocondEntity로 참조하는 배열 선택
	for(var i =0; i<arr.length; i++){
		if(arr[i].attrs.lastPos == id){
			return arr[i]; 
		}
	}
}

function findLineAtName(arr,id){
	for(var i =0; i<arr.length; i++){
		if(arr[i].attrs.name == id){
			return arr[i]; 
		}
	}
}


// 라인 객체 중에 해당 id를 pos으로 가지고 있는 라인을 가지고 옴
function findLineRefPos(id){
	var arr_Line = new Array();
	for(var i =0; i<relationLine_layer.children.length; i++){
		if(relationLine_layer.children[i].attrs.lastPos == id){
			arr_Line.push(relationLine_layer.children[i]);
		}
	}
	return arr_Line; 
}



//2개의 entity에서 2개이상의 관계선이 나온 경우 좌표값을 변경해주는 메서드 (생성 할 때) 
function sameEntityRelationLineaboutCreate(arr_XY,type){
	firstEntity
	secondEntity
	var cnt =0;
	for(var i = 0;i<relationLine_layer.children.length; i++){
		
		if(relationLine_layer.children[i].attrs.name == firstEntity._id
				&& relationLine_layer.children[i].attrs.lastPos == secondEntity._id){
			cnt++;
		}
		else if(relationLine_layer.children[i].attrs.name== secondEntity._id
				&& relationLine_layer.children[i].attrs.lastPos == firstEntity._id){
			cnt++;
		}
	}
		console.log('==== cnt:'+ cnt);
				switch(type){
				case 0:
				case 2:
					arr_XY[1] = arr_XY[1] - (cnt*10);//startY-=10;
					arr_XY[3] = arr_XY[3] - (cnt*10);//entY-=10;
				break;	
				
				case 1:
				case 3:
					arr_XY[0]= arr_XY[0] - (cnt*10);//startX-=10;
					arr_XY[2]= arr_XY[2] - (cnt*10);//startY-=10;
					break;
				}
				
				return arr_XY;
}





//2개의 entity에서 2개이상의 관계선이 나온 경우 좌표값을 변경해주는 메서드
function sameEntityRelationLine(arr_XY,arr_line_To,type){
	
	//전체 관계선에서 자기자신과 같은 객체를 참조하는 관계선이 있는 지 검사한다.  //자기자신도 포함되므로 무조건 1개이상 나옴
	for(var i = 0;i<relationLine_layer.children.length; i++){
		var temp_i;
		if(arr_line_To.parent.children[arr_line_To.index]._id ==relationLine_layer.children[i]._id){ //자기자신과 만났을 때 
			console.log('자기자신을 참조');
			temp_i = i;
			continue;
		}
		
		if(arr_line_To.parent.children[arr_line_To.index].attrs.name == relationLine_layer.children[i].attrs.name
		&& arr_line_To.parent.children[arr_line_To.index].attrs.lastPos == relationLine_layer.children[i].attrs.lastPos){
			console.log('arr_line_To.index : '+ arr_line_To.index);
			console.log('같은 객체를 참조');
		if(arr_line_To.index < i){//위와같이 진행하면 같은 객체 2개가 둘다 좌표값이 변하기 때문에 처음에 나온 애는 뺴준다.
			continue;
			}
		switch(type){
		case 0:
		case 2:
			arr_XY[1]-=10;//startY-=10;
			arr_XY[3]-=10;//endY-= 10; 
		break;	
		
		case 1:
		case 3:
			arr_XY[0]-=10;//startX-=10;
			arr_XY[2]-=10;//endX-= 10;
			break;
		}
			}
		}
}

// 클릭 한 객체에 위치속성을 다시 업데이트 해주는 메서드
function updLinePosition(first_Entity,second_Entity,arr_line_To){
	console.log('first_Entity.x()' + first_Entity.x());
	console.log('first_Entity.y()' + first_Entity.y());
	console.log('second_Entity().x()' + second_Entity.x());
	console.log('second_Entity.y()' + second_Entity.y());
	
	var compare_X = first_Entity.x() - second_Entity.x();
	var compare_Y = first_Entity.y() - second_Entity.y();
	
	var degree = getAngle(compare_X,compare_Y);
	console.log('두 객체 사이의 각도:', degree);
	var startX, startY, endX, endY;   // 선에 관한 좌표 값을 담을 변수들
	degree = degree-45;
	
	var firstEntityWidth = first_Entity.children[0].attrs.width;
	var firstEntityheight = first_Entity.children[0].attrs.height;
	var secondEntitywidth = second_Entity.children[0].attrs.width;
	var secondEntityheight = second_Entity.children[0].attrs.height;
	startX = first_Entity.x();
	startY = first_Entity.y();
	endX   = second_Entity.x();
	endY   = second_Entity.y();
	
	
	
	// arr_line_To[i].attrs.points.length
	
	switch(Math.floor(degree/90)){
	case 0 : 	 // 45~134 도
		console.log('case0');
		startY+=(firstEntityheight/2);
		endX += (secondEntitywidth);
		endY += (secondEntityheight/2);
		
		var arr_XY =calculatePositionXY(startX,startY,endX,endY,0,second_Entity);
		
		
		
		

//		if([arr_line_To.index]>0){
//			if(arr_line_To.parent.children[arr_line_To.index-1].attrs.name== arr_line_To.parent.children[arr_line_To.index].attrs.name 
//					&& arr_line_To.parent.children[arr_line_To.index-1].attrs.lastPos == arr_line_To.parent.children[arr_line_To.index].attrs.lastPos){
//				console.log('같은 객체 참조');
//				startY-=10;
//				  endY-= 10; // 2개의 같은 entity에서 관계를 가지면 위치값을 변경 
//			}
//		}
		
		sameEntityRelationLine(arr_XY,arr_line_To,0);
		
		
			
		startX = arr_XY[0];
		startY = arr_XY[1];
		endX   = arr_XY[2];
		endY   = arr_XY[3];
		
		
		
		if(arr_line_To.attrs.stroke =='#e08ba3'){ // 기존에 있던 선의 색이 핑크색일 경우 즉,
													// 1대 1 모양일 경우에
			arr_line_To.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX+10,endY-5,endX+10,endY+5,endX+10,endY,endX,endY]);	
		}
		else if(arr_line_To.attrs.stroke == '#86f5e5'){ // 기존에 있던 선의 색이 청록색일 경우
														// 즉, 1대 다 모양일 경우에
			arr_line_To.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX,endY+5,endX+10,endY,endX,endY-5,endX+10,endY,endX,endY]);
			
		}
	break;
	
	case 1 :   // 135~224
		console.log('case1');
		startX += (firstEntityWidth/2);
		startY += (firstEntityheight);
		endX += (secondEntitywidth/2);
		
		var arr_XY =calculatePositionXY(startX,startY,endX,endY,1,second_Entity);
		sameEntityRelationLine(arr_XY,arr_line_To,1);
		
		startX = arr_XY[0];
		startY = arr_XY[1];
		endX   = arr_XY[2];
		endY   = arr_XY[3];
		
	/*	if([arr_line_To.index]>0){
			if(arr_line_To.parent.children[arr_line_To.index-1].attrs.name== arr_line_To.parent.children[arr_line_To.index].attrs.name 
					&& arr_line_To.parent.children[arr_line_To.index-1].attrs.lastPos == arr_line_To.parent.children[arr_line_To.index].attrs.lastPos){
				console.log('같은 객체 참조');
				startX -=10;
				endX   -= 10;
			}
		}*/
		
		if(arr_line_To.attrs.stroke =='#e08ba3'){
			arr_line_To.points([startX,startY,startX,startY+10,startX-5,startY+10,startX+5,startY+10,startX,startY+10,endX,endY-15,endX,endY-10,endX-5,endY-10,endX+5,endY-10,endX,endY-10,endX,endY]);	
		}
		else if(arr_line_To.attrs.stroke == '#86f5e5'){
			arr_line_To.points([startX,startY,startX,startY+10,startX-5,startY+10,startX+5,startY+10,startX,startY+10,endX,endY-15,endX,endY-10,endX+5,endY,endX,endY-10,endX-5,endY,endX,endY-10,endX,endY]);
		}
	break;
	
	case 2 :   // 225~314
		console.log('case2');
		startX += (firstEntityWidth);
		startY += (firstEntityheight/2);
		endY   += (secondEntityheight/2);
		
		var arr_XY =calculatePositionXY(startX,startY,endX,endY,2,second_Entity);
		
		sameEntityRelationLine(arr_XY,arr_line_To,2);
		
		startX = arr_XY[0];
		startY = arr_XY[1];
		endX   = arr_XY[2];
		endY   = arr_XY[3];
		
		/*if([arr_line_To.index]>0){
			if(arr_line_To.parent.children[arr_line_To.index-1].attrs.name== arr_line_To.parent.children[arr_line_To.index].attrs.name 
					&& arr_line_To.parent.children[arr_line_To.index-1].attrs.lastPos == arr_line_To.parent.children[arr_line_To.index].attrs.lastPos){
				console.log('같은 객체 참조');
				startY -=10;
				endY   -= 10;
			}
		}*/
		if(arr_line_To.attrs.stroke =='#e08ba3'){
			arr_line_To.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX-10,endY-5,endX-10,endY+5,endX-10,endY,endX,endY]);	
		}
		else if(arr_line_To.attrs.stroke == '#86f5e5'){
		arr_line_To.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX,endY+5,endX-10,endY,endX,endY-5,endX-10,endY,endX,endY]);
		}
	break;	
	
	default :  	// 315<X이거나 45>X
		console.log('default');
	startX += (firstEntityWidth/2); // 첫번 째 객체의 가운데 위에서 선이 출발 (Y값 변화 X)
	endX   += (secondEntitywidth/2); // 두번 째 객체의 가운데 아래에서 선이 종료
	endY   += secondEntityheight; 
	
	var arr_XY =calculatePositionXY(startX,startY,endX,endY,3,second_Entity);
	
	sameEntityRelationLine(arr_XY,arr_line_To,3);
	
	startX = arr_XY[0];
	startY = arr_XY[1];
	endX   = arr_XY[2];
	endY   = arr_XY[3];
	
	/*if([arr_line_To.index]>0){
		if(arr_line_To.parent.children[arr_line_To.index-1].attrs.name== arr_line_To.parent.children[arr_line_To.index].attrs.name 
				&& arr_line_To.parent.children[arr_line_To.index-1].attrs.lastPos == arr_line_To.parent.children[arr_line_To.index].attrs.lastPos){
			console.log('같은 객체 참조');
			startX -=10;
			endX   -= 10;
		}
	}*/
	
	
	if(arr_line_To.attrs.stroke =='#e08ba3'){
		console.log('1대1');
		arr_line_To.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX-5,endY+10,endX+5,endY+10,endX,endY+10,endX,endY]);	
	}
	else if(arr_line_To.attrs.stroke == '#86f5e5'){
		console.log('1대다');
		arr_line_To.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX+5,endY,endX,endY+10,endX-5,endY,endX,endY+10,endX,endY]);
	}
	break;	
	}
}

		
function CntSamePositionLine(X,Y){ //선을 만드려는 좌표 x,y에 다른 선에 x,y가  몇개나 선점하고 있는 지 갯수를 반환하는 메서드
	var findEntityXY  = new Array();
	
	for(var i =0; i<relationLine_layer.children.length; i++){ 
		if(relationLine_layer.children[i].attrs.points[0]==X && relationLine_layer.children[i].attrs.points[1] ==Y){
		
		findEntityXY.push(findEntity(stage.find('.entity'),relationLine_layer.children[i].attrs.lastPos).attrs.x); //중복된 값이 있을 경우 해당 라인이 참조하는 객체의 x좌표를 넣는다.
		findEntityXY.push(findEntity(stage.find('.entity'),relationLine_layer.children[i].attrs.lastPos).attrs.y); //중복된 값이 있을 경우 해당 라인이 참조하는 객체의 x좌표를 넣는다.
		
		} 
		else if(relationLine_layer.children[i].attrs.points[relationLine_layer.children[i].attrs.points.length-2]==X && relationLine_layer.children[i].attrs.points[relationLine_layer.children[i].attrs.points.length-1] ==Y){
//		samePositionCnt++;
//		findEntityXY.push(findEntity(stage.find('.entity'),relationLine_layer.children[i].attrs.lastPos).attrs.x); //중복된 값이 있을 경우 해당 라인이 참조하는 객체의 x좌표를 넣는다.
//		findEntityXY.push(findEntity(stage.find('.entity'),relationLine_layer.children[i].attrs.lastPos).attrs.y); //중복된 값이 있을 경우 해당 라인이 참조하는 객체의 x좌표를 넣는다.
		findEntityXY.push(findEntity(stage.find('.entity'),relationLine_layer.children[i].attrs.name).attrs.x); //중복된 값이 있을 경우 해당 라인이 참조하는 객체의 x좌표를 넣는다.
		findEntityXY.push(findEntity(stage.find('.entity'),relationLine_layer.children[i].attrs.name).attrs.y); //중복된 값이 있을 경우 해당 라인이 참조하는 객체의 x좌표를 넣는다.
		}
	}
	return findEntityXY;
}

function calculatePositionXY(startX,startY,endX,endY,type,secondEntity){ //모듈화  선택한 좌표에 이미 관계선 객체가 차지하고 있으면, 새로만들 관계선 객체의 x,y값을 변경해주는 메서드  type=: 새로생성하는 건 지 업데이트 하는 것인지?
	
	do{																			
		var findEntityXY = CntSamePositionLine(startX,startY); //시작하는 점 X Y에 중복이 있다면 해당 라인이 참조하는 객체를 반환한다.
		var flag = true;   
		console.log('1');
		
		
		switch(type){
		case 0 : 
		case 2 :	
			if(findEntityXY.length > 0){ //해당 좌표에 이미 값이 존재함...
				if(findEntityXY[1]>secondEntity.y()){ //
					startY-=10;
				}
				else if(findEntityXY[1]< secondEntity.y()){
					startY+=10;
				}
				else{ //같을 경우 
//					if(method){
//						startY-=10;
//					}
				flag = false;
			}
			}
			break;
			
		case 1 :
		case 3 :
			if(findEntityXY.length > 0){
				if(findEntityXY[0]>secondEntity.x()){
					startX-=10;
				}
				else if(findEntityXY[0]< secondEntity.x()){
					startX+=10;
				}
				else{ //같을 경우 
					flag = false;
				}
			}
			break;
		}
		}while(CntSamePositionLine(startX,startY).length!=0 && flag);
		
		do{
		console.log('2');
		var findEntityXY = CntSamePositionLine(endX,endY);
		var flag = true;
		switch(type){
		case 0 : 
		case 2 :
			if(findEntityXY.length > 0){
				if(findEntityXY[1]>secondEntity.y()){
					endY-=10;
				}
				else if(findEntityXY[1]< secondEntity.y()){
					endY+=10;
				}
				else{
					flag = false;
				}
			}
		break;
		
		case 1 :
		case 3 :
			if(findEntityXY.length > 0){
				if(findEntityXY[0]>secondEntity.x()){
					endX-=10;
				}
				else if(findEntityXY[0]< secondEntity.x()){
					endX+=10;
				}
				else{ //같을 경우 
					flag = false;
				}
			}
			break;
		}
	}while(CntSamePositionLine(endX,endY).length!=0 && flag);
		
	
		var arr_XY = new Array(startX,startY,endX,endY);
		
		return arr_XY;
	
}

function makeArrow(e) {
	if (isRRelationClick) { // 관계연결선 버튼을 클릭한 했을 경우만 실행
		// 화살표를 생성
		var pos = stage.getPointerPosition();
		console.log(pos.x);
		console.log(pos.y);

		var p_x = allNode.findAncestor('.entity').x();
		var p_y = allNode.findAncestor('.entity').y();
		firstEntity = allNode.findAncestor('.entity');
		var click_target = allNode.findAncestor('.entity').children[0];
		console.log('click_target :' + click_target);

		plus_width = click_target.width() / 2;
		plus_height = click_target.height() / 2;

		temp_arrow = new Konva.Arrow({
			points : [ p_x + plus_width, p_y + plus_height, pos.x, pos.y ],
			pointerLength : 10,
			pointerWidth : 10,
			stroke : '#ffff00',
			strokeWidth : 3
		});

		console.log('create temp_arrow');
		temp_arrow_layer.add(temp_arrow);
		stage.add(temp_arrow_layer);

		console.log('adjustPoint 호출');

		// 나중에 끌일이 생길 듯
		stage.on('mousemove', adjustPoint);

		function adjustPoint(e) {
			console.log('adjustPoint 호출됨');
			pos = stage.getPointerPosition();

			// 원래 temp_arrow의 x,y 값을 가져옴
			var x = temp_arrow.attrs.points[0];
			var y = temp_arrow.attrs.points[1];
			var point = [ x, y, pos.x - 10, pos.y - 10 ]; // -10을 안하면 빈 스테이지를
															// 찍으면 arrow객체가 클릭 됨
			
			temp_arrow.setPoints(point);
			temp_arrow_layer.draw();

		}
	}
};

function getAngle(compareX,compareY) { // 두 점 사이의 각도를 구하는 함수 (firstEntity 기준)
	var r = Math.atan2(compareX, compareY);
	if (r < 0) r += Math.PI * 2;
	var degree = r * 180 / Math.PI;
	while (degree < 0){ 
		degree += 360; 
	}
	return degree;
}

/*  -1.firstEntity  범위값에 해당하는 inputLIne과 outputLine의 라인배열을 가져온다.
 *  -2. 1.에서 구한 배열들이 가지고 있는 secondEntity에 있는 X또는Y값을 비교하여 오름차순으로 정렬한다.
 *  -3. 오름차순에 순서에 맞게 해당 라인에 start(inputLIne)값과 end(outputLine)값을 바꿔준다.
 *  -4. SecondEntity에 관한 작업도 해줘야한다. 
 */  

	function extractLineXY(temp_line){ //라인객체의 startXstartYendXendY 값을 추출하는 메서드 
		var startXYendXY = new Array();
		var pointLength = temp_line.attrs.points.length;
		
		startXYendXY.push(temp_line.attrs.points[0]);
		startXYendXY.push(temp_line.attrs.points[1]); 
		startXYendXY.push(temp_line.attrs.points[pointLength-2]); 
		startXYendXY.push(temp_line.attrs.points[pointLength-1]);
		
		return startXYendXY; 
	}	

	function calculatestartXY(arr_first_totalEntity,j){
		var center_index = Math.ceil(arr_first_totalEntity.length/2);
 		var changeValue = 10;
 		var result = 0;
		if(arr_first_totalEntity.length%2 == 0){ //짝수일 때 
				var center_index_2 = Math.ceil(arr_first_totalEntity.length/2)+1;   //짝수일 경우 기준값이 2개여야 한다.
				
				 if(j<center_index-1){
					var step = (center_index-1)-j;
//					startXYendXY[1] = xy[1]-(changeValue*step)-changeValue/2;
					result = -((changeValue*step)+changeValue/2);
				 }	 
				 else if(j>center_index_2-1){
					var step = j-(center_index_2-1);
//					startXYendXY[1] = xy[1]+(changeValue*step) +changeVal1ue/2;
					result = ((changeValue*step)+changeValue/2);
				 }
				else if(j == center_index-1){
//					startXYendXY[1] = xy[1]-changeValue/2;  
					result = -changeValue/2;
			 }
				else if(j == center_index_2-1){
//					startXYendXY[1] = xy[1]+changeValue/2;  	
					result = changeValue/2;
			 }
				
			}
			else{ //홀수 일 때
				if(j == center_index-1){
//					startXYendXY[1] = xy[1];  	 
					result = 0;
				}
				
				else if(j <center_index-1){
					var step = (center_index-1)-j;
//					startXYendXY[1] = xy[1]-(changeValue*step);
					result = -(changeValue*step);
				}
				else if(j >center_index-1){
					var step = j-(center_index-1);
//					startXYendXY[1] = xy[1]+(changeValue*step);
					result = (changeValue*step);
				}
			}
		return result;
	}
	
	
	//firstEntity에 속해있는 outputLine과 inPutLine를 배열에 담음
	function selectLine(arr_outputLine,arr_inputLine,arr_range,type){  // 해당객체에
		for(var i = 0; i<relationLine_layer.children.length; i++){
			var pointLength = relationLine_layer.children[i].attrs.points.length;
			
			switch(type){
			case 0 : //45~134도 
			case 2 : //225~314도
 			// firstEntity에 범위에 속해있는 outputLine을 검색
			if(relationLine_layer.children[i].attrs.points[0] == arr_range[0] && 
			   (relationLine_layer.children[i].attrs.points[1] >arr_range[1] &&
			    relationLine_layer.children[i].attrs.points[1] <arr_range[3]))
					{
				arr_outputLine.push(relationLine_layer.children[i]);	
					}
			
			// firstEntity에 범위에 속해있는 inPutLine을 검색
			if(relationLine_layer.children[i].attrs.points[pointLength-2] == arr_range[0] && 
					   (relationLine_layer.children[i].attrs.points[pointLength-1] >=arr_range[1] &&
					    relationLine_layer.children[i].attrs.points[pointLength-1] <=arr_range[3]))
					{
				arr_inputLine.push(relationLine_layer.children[i]);	
					}
			break;
			
			case 1 : //135~224도
			case 3 : //315~360도
	 			// firstEntity에 범위에 속해있는 outputLine을 검색
				if(relationLine_layer.children[i].attrs.points[1] == arr_range[1] && 
				   (relationLine_layer.children[i].attrs.points[0] >arr_range[0] &&
				    relationLine_layer.children[i].attrs.points[0] <arr_range[2]))
						{
					arr_outputLine.push(relationLine_layer.children[i]);	
						}
				
				// firstEntity에 범위에 속해있는 inPutLine을 검색
				if(relationLine_layer.children[i].attrs.points[pointLength-1] == arr_range[1] && 
						   (relationLine_layer.children[i].attrs.points[pointLength-2] >=arr_range[0] &&
						    relationLine_layer.children[i].attrs.points[pointLength-2] <=arr_range[2]))
						{
					arr_inputLine.push(relationLine_layer.children[i]);	
						}
				break;
			
				}
			}
		}
	
	function drawUpdLine(startXYendXY,temp_line,type){
		var	startX = startXYendXY[0];
		var	startY = startXYendXY[1];
		var	endX = startXYendXY[2];
		var	endY = startXYendXY[3];

		switch(type){
		case 0 :
				if(temp_line.attrs.points.length == 22){ // 1대 1
					temp_line.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX+10,endY-5,endX+10,endY+5,endX+10,endY,endX,endY]);	
				}
				else if(temp_line.attrs.points.length == 24){ //1대 다
					temp_line.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX,endY+5,endX+10,endY,endX,endY-5,endX+10,endY,endX,endY]);
				}
		break;
		
		case 1 :
			if(temp_line.attrs.points.length == 22){ // 1대 1
				temp_line.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX+10,endY-5,endX+10,endY+5,endX+10,endY,endX,endY]);	
			}
			else if(temp_line.attrs.points.length == 24){ //1대 다
				temp_line.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX,endY+5,endX+10,endY,endX,endY-5,endX+10,endY,endX,endY]);
			}
			break;
			
		case 2 :
		  if(temp_line.attrs.points.length == 22){ // 1대 1
			  temp_line.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX-10,endY-5,endX-10,endY+5,endX-10,endY,endX,endY]);	
			}
		   else if(temp_line.attrs.points.length == 24){ //1대 다
			   temp_line.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX,endY+5,endX-10,endY,endX,endY-5,endX-10,endY,endX,endY]);	
			}
			
			break;
			
		case 3 :
			  if(temp_line.attrs.points.length == 22){ // 1대 1
				  temp_line.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX-5,endY+10,endX+5,endY+10,endX,endY+10,endX,endY]);	
			  }
			   else if(temp_line.attrs.points.length == 24){ //1대 다
				   temp_line.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX+5,endY,endX,endY+10,endX-5,endY,endX,endY+10,endX,endY])
				}
			break;
		}
	}
	
	
	
	function  totalEntitysort(arr_first_totalEntity,type){  //각도에 따라 x ,y로 정렬해주는 메서드
		switch(type){
		case 0:
		case 2:
 		arr_first_totalEntity.sort(function (a,b){
 			return a.attrs.y<b.attrs.y?-1 : a.attrs.y>b.attrs.y?1:0;   //현재 이 배열에는 내가 선택한 곳에 포함되는 객체들이 모두 들어있다.
 		});
 		break;
 		
		case 1:
		case 3:
	 		arr_first_totalEntity.sort(function (a,b){
	 			return a.attrs.x<b.attrs.x?-1 : a.attrs.x>b.attrs.x?1:0;   //현재 이 배열에는 내가 선택한 곳에 포함되는 객체들이 모두 들어있다.
	 		});
	 		break;

		}
	}
	
	function rePositioning(arr_first_range,arr_second_range,xy,secondEntity,type){
		var newLineXY = xy; //새로만들 라인의 좌표값을 담아주는 배열
		
		var arr_first_outputLine = new Array(); // firstEntity에서 나온 outputLine 배열
		var arr_first_inputLine = new Array(); // firstEntity에 들어오는 inputLine 배열
		
		var arr_second_outputLine = new Array(); // secondEntity에서 나온 outputLine 배열
		var arr_second_inputLine = new Array(); // secondEntity에 들어오는 inputLine 배열
		
	  	var EntityArr  = stage.find('.entity'); //entity 객체가 들어있는 배열 
	  	
 	  	var arr_first_outputEntity = new Array(); //firstEntity에 들어오는 inputLine의 참조값들이 들어있는 배열
 	  	var arr_first_inputEntity = new Array(); //firstEntity에 나가는 inputLine의 참조값들이 들어있는 배열
 	  	
 	  	var arr_second_outputEntity = new Array(); //secondEntity에 들어오는 outputLine의 참조값들이 들어있는 배열
 	  	var arr_second_inputEntity = new Array(); //secondEntity에 나가는 inputLine의 참조값들이 들어있는 배열
 	  	
 	  	
 	  	var arr_first_totalEntity//   arr_first_outputEntity + arr_first_inputEntity
 	  	var arr_second_totalEntity//   arr_second_outputEntity + arr_second_inputEntity
 	  	
 	  	var secondType;
 	  	
		if(type ==0 || type == 2){
			secondType = Math.abs(type-2);
		}
		else if(type == 1 || type==3){
			secondType =  (type>2)?secondType=1:secondType=3;
		}
 	  	
 	  	//firstEntity에 속해있는 outputLine과 inPutLine를 배열에 담음
 	  	selectLine(arr_first_outputLine,arr_first_inputLine,arr_first_range,type);

 	  	//secondEntity에 속해있는 속해있는 outputLine과 inPutLine를 배열에 담음
 	  	selectLine(arr_second_outputLine,arr_second_inputLine,arr_second_range,type);
 	  	
 	  	
 	  	
 		//해당범위 참조하는 라인이 없으면 리턴
 		if(arr_first_outputLine.length == 0 && arr_first_inputLine.length == 0 
 		&& arr_second_outputLine.length == 0 && arr_second_inputLine.length == 0  ){ 
 			return newLineXY;
 		}
 		
 		//arr_first_outputLine이 참조하는 객체를 구함
 		for(var i =0; i<arr_first_outputLine.length; i++){
 			var temp_Entity = findEntity(EntityArr,arr_first_outputLine[i].attrs.lastPos);
 			arr_first_outputEntity.push(temp_Entity);
 		}
 		
 		//새로 연결된 라인도 계산해야 함으로 arr_first_outputEntity에 넣어준다.
			arr_first_outputEntity.push(secondEntity); 
 		
 		//arr_second_outputLine이 참조하는 객체를 구함
 		for(var i =0; i<arr_second_outputLine.length; i++){
 			var temp_Entity = findEntity(EntityArr,arr_second_outputLine[i].attrs.lastPos);
 			arr_second_outputEntity.push(temp_Entity);
 		}
 		
 		//arr_first_inputLine 참조하는 객체를 구함
 		for(var i =0; i<arr_first_inputLine.length; i++){
 			var temp_Entity = findEntity(EntityArr,arr_first_inputLine[i].attrs.name);
 			arr_first_inputEntity.push(temp_Entity);
 		}
 		
 		//arr_second_inputLine 참조하는 객체를 구함
 		for(var i =0; i<arr_second_inputLine.length; i++){
 			var temp_Entity = findEntity(EntityArr,arr_second_inputLine[i].attrs.name);
 			arr_second_inputEntity.push(temp_Entity);
 		}
 		
 		//새로 연결된 라인도 계산해야 함으로 second_inputEntity에 넣어준다.
 		arr_second_inputEntity.push(firstEntity);
 		
 		//배열 합치기
 		  arr_first_totalEntity = arr_first_outputEntity.concat(arr_first_inputEntity);
 		  arr_second_totalEntity = arr_second_outputEntity.concat(arr_second_inputEntity);
 		  
 		  
 		 //y값을 기준으로 오름차순 (각도에 따라 x가 될 수도 있음)
 		 totalEntitysort(arr_first_totalEntity,type);
 		totalEntitysort(arr_second_totalEntity,type);
 		 
 		
 		//선택한 객체에서 outLine의 위치를 재조정해주는 부분 (firstEntity 관련)
 		for(var i =0; i<arr_first_outputEntity.length; i++ ){
 			for(var j=0; j<arr_first_totalEntity.length; j++){
 				if(arr_first_outputEntity[i]  == arr_first_totalEntity[j]){
 					//var result=0;	
 					//서로 같은 엔터티에서 참조할 경우 예외가 일어날 확률이 높다...
 					if(arr_first_totalEntity[j] == secondEntity){
 					var result = calculatestartXY(arr_first_totalEntity,j);
 					
 					 if(type==0 || type == 2){
 						newLineXY[1] = xy[1]+result;  
 					 }
 					 else if(type==1 || type == 3){
 						newLineXY[0] = xy[0]+result;  
 					 }
 					continue;	
 					}
 					
 					var temp_line = findLine(arr_first_outputLine,arr_first_outputEntity[i]._id);
 					var startXYendXY = extractLineXY(temp_line); //해당 객체의 좌표정보를 얻어온다.
 					
 					 var result = calculatestartXY(arr_first_totalEntity,j);
 					
 					 if(type==0 || type == 2){
 						startXYendXY[1] = xy[1]+result;  
  					 }
  					 else if(type==1 || type == 3){
  						startXYendXY[0] = xy[0]+result;  
  					 }
 					
 					drawUpdLine(startXYendXY,temp_line,type);
 					}
 				}
 			}
 		
 		//선택한 객체에서 inLine의 위치를 재조정해주는 부분
 		for(var i =0; i<arr_first_inputEntity.length; i++ ){
 			for(var j=0; j<arr_first_totalEntity.length; j++){
 				if(arr_first_inputEntity[i]  == arr_first_totalEntity[j]){
 					
 					var temp_line = findLineAtName(arr_first_inputLine,arr_first_inputEntity[i]._id);
 					var startXYendXY = extractLineXY(temp_line); //해당 객체의 좌표정보를 얻어온다.
 					
 					var result = calculatestartXY(arr_first_totalEntity,j);
 					if(type==0 || type == 2){
 						startXYendXY[3] = xy[1]+result;  
   					 }
   					 else if(type==1 || type == 3){
   						startXYendXY[2] = xy[0]+result;  
   					 }
 					drawUpdLine(startXYendXY,temp_line,secondType);
 					}
 				}
 			}
 		
 		
 		//선택한 객체에서 outLine의 위치를 재조정해주는 부분 (secondEntity 관련)
 		for(var i =0; i<arr_second_outputEntity.length; i++ ){
 			for(var j=0; j<arr_second_totalEntity.length; j++){
 				if(arr_second_outputEntity[i]  == arr_second_totalEntity[j]){
 					//var result=0;	
 					//서로 같은 엔터티에서 참조할 경우 예외가 일어날 확률이 높다...
 					
 					
 					var temp_line = findLine(arr_second_outputLine,arr_second_outputEntity[i]._id);
 					var startXYendXY = extractLineXY(temp_line); //해당 객체의 좌표정보를 얻어온다.
 					
 					 var result = calculatestartXY(arr_second_totalEntity,j);
 					
 					 if(type==0 || type == 2){
 						startXYendXY[1] = xy[3]+result;  
  					 }
  					 else if(type==1 || type == 3){
  						startXYendXY[0] = xy[2]+result;  
  					 }
 					 
 					
 					 
 					drawUpdLine(startXYendXY,temp_line,secondType);
 					}
 				}
 			}
 		
 		//선택한 객체에서 inLine의 위치를 재조정해주는 부분 (secondEntity)
 		for(var i =0; i<arr_second_inputEntity.length; i++ ){
 			for(var j=0; j<arr_second_totalEntity.length; j++){
 				if(arr_second_inputEntity[i]  == arr_second_totalEntity[j]){
 						
 					if(arr_second_totalEntity[j] == firstEntity){
 	 					var result = calculatestartXY(arr_second_totalEntity,j);
 	 					
 	 					 if(type==0 || type == 2){
 	 						newLineXY[3] = xy[3]+result;  
 	 					 }
 	 					 else if(type==1 || type == 3){
 	 						newLineXY[2] = xy[2]+result;  
 	 					 }
 	 					continue;	
 	 					}
 					
 					var temp_line = findLineAtName(arr_second_inputLine,arr_second_inputEntity[i]._id);
 					var startXYendXY = extractLineXY(temp_line); //해당 객체의 좌표정보를 얻어온다.
 					
 					var result = calculatestartXY(arr_second_totalEntity,j);
 					if(type==0 || type == 2){
 						startXYendXY[3] = xy[3]+result;  
   					 }
   					 else if(type==1 || type == 3){
   						startXYendXY[2] = xy[2]+result;  
   					 }
 					drawUpdLine(startXYendXY,temp_line,type);
 					}
 				}
 			}
 		return newLineXY;
	}
	
 	

 function compareEntityPosition() {
	compareX = firstEntity.x() - secondEntity.x();
	compareY = firstEntity.y() - secondEntity.y();
	
	var degree = getAngle(compareX,compareY);
	
	var startX, startY, endX, endY;   // 선에 관한 좌표 값을 담을 변수들
	
	var arr_first_range = new Array(); //firstEntity 범위 값에 관한 좌표를 담을 변수
	var arr_second_range = new Array();//SecondEntity 범위 값에 관한 좌표를 담을 변수
	var xy = new Array();//firstEntity와 SecondEntity의 좌표 정보를 담은 변수
	degree = degree-45;
	
	var firstEntityWidth = firstEntity.children[0].attrs.width;
	var firstEntityheight = firstEntity.children[0].attrs.height;
	var secondEntitywidth = secondEntity.children[0].attrs.width;
	var secondEntityheight = secondEntity.children[0].attrs.height;
	
	startX = firstEntity.x();
	startY = firstEntity.y();
	endX   = secondEntity.x();
	endY   = secondEntity.y();
	
	// 라인객체 생성 좌표값은 switch에서 결정
	 relationLine = new Konva.Line({  
		 // stroke :'red',
		 strokeWidth:2,
			lineCap : 'round',
			linerJoin: 'round',
			name:firstEntity._id+'',   // 첫번째 엔터티에 관한 ID값을 참조
			lastPos : secondEntity._id, // 두번째 엔터티에 관한 ID값을 참조
		});
	
	switch(Math.floor(degree/90)){
	case 0 : 	 // 45~134 도
		console.log('case0');
		startY+=(firstEntityheight/2);
		endX += (secondEntitywidth);
		endY += (secondEntityheight/2);
		
		//범위값을 정해준다.
		arr_first_range[0] = firstEntity.x();
		arr_first_range[1] = firstEntity.y();
		arr_first_range[2] = firstEntity.x();
		arr_first_range[3] = firstEntity.y()+firstEntityheight;
		
		arr_second_range[0] = secondEntity.x()+secondEntitywidth;
		arr_second_range[1] = secondEntity.y();
		arr_second_range[2] = secondEntity.x()+secondEntitywidth;
		arr_second_range[3] = secondEntity.y()+secondEntityheight;
		
		xy.push(startX);
		xy.push(startY);
		xy.push(endX);
		xy.push(endY);
		
		 var newLineXY= rePositioning(arr_first_range,arr_second_range,xy,secondEntity,0);
		
		
		arr_XY = sameEntityRelationLineaboutCreate(newLineXY,0);
		
		startX = newLineXY[0];
		startY = newLineXY[1];
		endX   = newLineXY[2];
		endY   = newLineXY[3];
	
		if(cardinality=='single'){
			relationLine.stroke('#e08ba3'), // 핑크
			relationLine.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX+10,endY-5,endX+10,endY+5,endX+10,endY,endX,endY]);	
		}
		else if(cardinality=='multi'){
			relationLine.stroke('#86f5e5'), // 청록
			relationLine.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX,endY+5,endX+10,endY,endX,endY-5,endX+10,endY,endX,endY]);
		}
	break;
	case 1 :   // 135~224
		console.log('case1');
		startX += (firstEntityWidth/2);
		startY += (firstEntityheight);
		endX += (secondEntitywidth/2);
		
		//범위값을 정해준다.
		arr_first_range[0] = firstEntity.x();
		arr_first_range[1] = firstEntity.y()+firstEntityheight;
		arr_first_range[2] = firstEntity.x()+firstEntityWidth;
		arr_first_range[3] = firstEntity.y()+firstEntityheight;
		
		arr_second_range[0] = secondEntity.x();
		arr_second_range[1] = secondEntity.y();
		arr_second_range[2] = secondEntity.x()+secondEntitywidth;
		arr_second_range[3] = secondEntity.y();
		
		xy.push(startX);
		xy.push(startY);
		xy.push(endX);
		xy.push(endY);
		
		 var newLineXY= rePositioning(arr_first_range,arr_second_range,xy,secondEntity,1);
		
		
		//var arr_XY =calculatePositionXY(startX,startY,endX,endY,1,secondEntity);
		//arr_XY = sameEntityRelationLineaboutCreate(arr_XY,1);
		startX = newLineXY[0];
		startY = newLineXY[1];
		endX   = newLineXY[2];
		endY   = newLineXY[3];
		
		if(cardinality=='single'){
			relationLine.stroke('#e08ba3'),
			relationLine.points([startX,startY,startX,startY+10,startX-5,startY+10,startX+5,startY+10,startX,startY+10,endX,endY-15,endX,endY-10,endX-5,endY-10,endX+5,endY-10,endX,endY-10,endX,endY]);	
		}
		else if(cardinality=='multi'){
			relationLine.stroke('#86f5e5'),
			relationLine.points([startX,startY,startX,startY+10,startX-5,startY+10,startX+5,startY+10,startX,startY+10,endX,endY-15,endX,endY-10,endX+5,endY,endX,endY-10,endX-5,endY,endX,endY-10,endX,endY]);
		}
	break;
	
	case 2 :   // 225~314
		console.log('case2');
		startX += (firstEntityWidth);
		startY += (firstEntityheight/2);
		endY   += (secondEntityheight/2);
		
		//범위값을 정해준다.
		arr_first_range[0] = firstEntity.x()+firstEntityWidth;
		arr_first_range[1] = firstEntity.y();
		arr_first_range[2] = firstEntity.x()+firstEntityWidth;
		arr_first_range[3] = firstEntity.y()+firstEntityheight;
		
		arr_second_range[0] = secondEntity.x();
		arr_second_range[1] = secondEntity.y();
		arr_second_range[2] = secondEntity.x();
		arr_second_range[3] = secondEntity.y()+secondEntityheight;
		
		xy.push(startX);
		xy.push(startY);
		xy.push(endX);
		xy.push(endY);
		
		var newLineXY= rePositioning(arr_first_range,arr_second_range,xy,secondEntity,2);
		
		//var arr_XY =calculatePositionXY(startX,startY,endX,endY,2,secondEntity);
		//arr_XY = sameEntityRelationLineaboutCreate(arr_XY,2);
		
		startX = newLineXY[0];
		startY = newLineXY[1];
		endX   = newLineXY[2];
		endY   = newLineXY[3];
		
		if(cardinality=='single'){
			relationLine.stroke('#e08ba3'),
			relationLine.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX-10,endY-5,endX-10,endY+5,endX-10,endY,endX,endY]);	
		}
		else if(cardinality=='multi'){
		relationLine.stroke('#86f5e5'),
		relationLine.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX,endY+5,endX-10,endY,endX,endY-5,endX-10,endY,endX,endY]);
		}
	break;	
	
	default :  	// 315<X이거나 45>X
		console.log('default');
	startX += (firstEntityWidth/2); // 첫번 째 객체의 가운데 위에서 선이 출발 (Y값 변화 X)
	endX   += (secondEntitywidth/2); // 두번 째 객체의 가운데 아래에서 선이 종료
	endY   += secondEntityheight; 
	
	//범위값을 정해준다.
	arr_first_range[0] = firstEntity.x();
	arr_first_range[1] = firstEntity.y();
	arr_first_range[2] = firstEntity.x()+firstEntityWidth;
	arr_first_range[3] = firstEntity.y();
	
	arr_second_range[0] = secondEntity.x();
	arr_second_range[1] = secondEntity.y()+secondEntityheight;
	arr_second_range[2] = secondEntity.x()+secondEntitywidth;
	arr_second_range[3] = secondEntity.y()+secondEntityheight;
	
	xy.push(startX);
	xy.push(startY);
	xy.push(endX);
	xy.push(endY);
	
	var newLineXY= rePositioning(arr_first_range,arr_second_range,xy,secondEntity,3);
	
	//var arr_XY =calculatePositionXY(startX,startY,endX,endY,3,secondEntity);
	//arr_XY = sameEntityRelationLineaboutCreate(arr_XY,3);
	
	startX = newLineXY[0];
	startY = newLineXY[1];
	endX   = newLineXY[2];
	endY   = newLineXY[3];
	
	if(cardinality=='single'){
		relationLine.stroke('#e08ba3'),
		relationLine.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX-5,endY+10,endX+5,endY+10,endX,endY+10,endX,endY]);	
	}
	else if(cardinality=='multi'){
	relationLine.stroke('#86f5e5'),
	relationLine.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX+5,endY,endX,endY+10,endX-5,endY,endX,endY+10,endX,endY])
	}
	break;	
	}
	
	if(!relationType){
		relationLine.dash([5,5]); //점선으로 바꿈
	}
	 
	 relationLine_layer.add(relationLine);
	 stage.add(relationLine_layer);
};


