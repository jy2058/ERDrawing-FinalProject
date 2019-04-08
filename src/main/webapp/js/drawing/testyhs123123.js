/**
 * erdDrawing.jsp relation 기능에 관련된 스크립트 입니다.
 */


// entity 중에 _id가 일치하는 값을 찾기 위한 메서드
function findEntity(findEntityArr, id){
	for(var i =0; i<findEntityArr.length; i++){
		if(findEntityArr[i]._id == id){
			return findEntityArr[i]; 
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
		
		var arr_XY =calculatePositionXY(startX,startY,endX,endY,0);
		
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
		
		var arr_XY =calculatePositionXY(startX,startY,endX,endY,1);
		
		startX = arr_XY[0];
		startY = arr_XY[1];
		endX   = arr_XY[2];
		endY   = arr_XY[3];
		
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
		
		var arr_XY =calculatePositionXY(startX,startY,endX,endY,2);
		
		startX = arr_XY[0];
		startY = arr_XY[1];
		endX   = arr_XY[2];
		endY   = arr_XY[3];
		
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
	
	var arr_XY =calculatePositionXY(startX,startY,endX,endY,3);
	
	startX = arr_XY[0];
	startY = arr_XY[1];
	endX   = arr_XY[2];
	endY   = arr_XY[3];
	
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
	var samePositionCnt = 0;
	for(var i =0; i<relationLine_layer.children.length; i++){
		if(relationLine_layer.children[i].attrs.points[0]==X && relationLine_layer.children[i].attrs.points[1] ==Y){
		samePositionCnt++; 
		} 
		if(relationLine_layer.children[i].attrs.points[relationLine_layer.children[i].attrs.points.length-2]==X && relationLine_layer.children[i].attrs.points[relationLine_layer.children[i].attrs.points.length-1] ==Y){
		samePositionCnt++;
		}
	}
	return samePositionCnt;
}

function calculatePositionXY(startX,startY,endX,endY,type){ //모듈화  선택한 좌표에 이미 관계선 객체가 차지하고 있으면, 새로만들 관계선 객체의 x,y값을 변경해주는 메서드 
	
	do{																			
		var samePositionCnt = CntSamePositionLine(startX,startY); //같은 위치에 있는 선은 값을 조정한다.
		switch(type){
		case 0 : 
			startY = startY+(5*samePositionCnt);
			break;
		case 1 :
			startX = startX+(5*samePositionCnt);
			break;
		case 2 :
			startY = startY+(5*samePositionCnt);
			break;
		case 3 :
			startX = startX+(5*samePositionCnt);
			break;
		}
		}while(CntSamePositionLine(startX,startY)!=0);
		
		do{
		samePositionCnt = CntSamePositionLine(endX,endY); // 도착점에 중복된 값이 있으면 xy좌표의 값을 +5 증가시킨다.
		switch(type){
		case 0 : 
			endY = endY+(5*samePositionCnt);
		break;
		case 1 :
			endX = endX+(5*samePositionCnt);
			break;
		case 2 :
			endY = endY+(5*samePositionCnt);
			break;
			
		case 3 :
			endX = endX+(5*samePositionCnt);
			break;	
		}
		}while(CntSamePositionLine(endX,endY)!=0);
	
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


function compareEntityPosition() {
	//console.log('secondEntity.x()' + secondEntity.x());
	
	compareX = firstEntity.x() - secondEntity.x();
	compareY = firstEntity.y() - secondEntity.y();
	
	var degree = getAngle(compareX,compareY);
	console.log('두 객체 사이의 각도:', degree);
	var startX, startY, endX, endY;   // 선에 관한 좌표 값을 담을 변수들
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
	
	// console.log('name'+relationLine.name());
	
	 
	 
	switch(Math.floor(degree/90)){
	case 0 : 	 // 45~134 도
		console.log('case0');
		startY+=(firstEntityheight/2);
		endX += (secondEntitywidth);
		endY += (secondEntityheight/2);
		
		var arr_XY =calculatePositionXY(startX,startY,endX,endY,0);
		startX = arr_XY[0];
		startY = arr_XY[1];
		endX   = arr_XY[2];
		endY   = arr_XY[3];
		
	
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
		
		var arr_XY =calculatePositionXY(startX,startY,endX,endY,1);
		startX = arr_XY[0];
		startY = arr_XY[1];
		endX   = arr_XY[2];
		endY   = arr_XY[3];
		
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
		
		var arr_XY =calculatePositionXY(startX,startY,endX,endY,2);
		startX = arr_XY[0];
		startY = arr_XY[1];
		endX   = arr_XY[2];
		endY   = arr_XY[3];
		
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
	
	var arr_XY =calculatePositionXY(startX,startY,endX,endY,3);
	startX = arr_XY[0];
	startY = arr_XY[1];
	endX   = arr_XY[2];
	endY   = arr_XY[3];
	
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
		relationLine.dash([5,5]);
	}
	 
	 relationLine_layer.add(relationLine);
	 stage.add(relationLine_layer);
};


