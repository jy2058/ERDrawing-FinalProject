<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/erdDrawing.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://unpkg.com/konva@3.2.0/konva.min.js"></script>
<script src="../../../js/drawing/minimap.js"></script>

</head>

<body id='my_body'>

	<div id="drawing_container">
		<div class="drawing_top">
			<a id="botton0" class="buttons" href="/">홈</a>
			<div id="button1" class="buttons">테이블 이름 가져오기</div>
			<div id="button2" class="buttons">확대/축소 초기화</div>
			<div id="button3" class="buttons">테이블 추가하기</div>
			<div id="button4" class="buttons">미니맵 Toggle</div>
		</div>
	<div id="container_mini"></div>
		
        <div class="drawing_box">

            <session class="drawing_left drawing_pannel">
                L
            </session>

            <session class="drawing_right drawing_pannel">
                R
            </session>

            <session class="drawing_bottom drawing_pannel">
                B
            </session>

            <session class="drawing_content drawing_pannel">
                <div id="container_Shin"></div>
            </session>

        </div>
    </div>
    
</body>






<script>
        

        $("#button1").on('click', function(){
           alert(textNode.text());
        });
        $("#button2").on('click', function(){
        	//미니맵 빨간 사각형 초기화
        	 console.log('mini_width/3'+mini_width/3);
             mini_rect.x(0),
  			mini_rect.y(0),
  			mini_rect.width(mini_width/3),
  			mini_rect.height(mini_height/2)
  			
  			mini_layer.draw();
             
           stage.scale({ x: 1, y: 1 });
            stage.position({x:0, y:0});
            stage.batchDraw();
        });
        
        $("#button3").on('click', function(){
            
            
           $('html').css({'cursor':'url(/image/erase.cur), auto'});
           
            
            stage.on("click", function(){
                // what is transform of parent element?
                var transform = layer.getAbsoluteTransform().copy();

                // to detect relative position we need to invert transform
                transform.invert();

              var pos = stage.getPointerPosition();
              var circlePos = transform.point(pos);
              entityAdd(circlePos);
                
                
                $('html').css({'cursor':'url(x), auto'});
                
                 //stage.off('click');

           });
        });
        
//    1. 변수 초기화
      var width = window.innerWidth;
      var height = window.innerHeight;

      var width2 = $('#container_Shin').width();
      var height2 = $('#container_Shin').height();
      
      console.log("width2 : "+width2);
      console.log("height2 : "+height2);
        
      var BORDER_SIZE = 3;
      var color1 = [ 'red', 'black', 'blue' ];
        
      var target, activeWedge, stage, layer, wheel, pointer, box, textNode, allNode;
      
        
      var entity, entity_container, entity_logical, entity_phisical, entity_logical_txt, entity_phisical_txt;
        
    
      var btn_entity_group, btn_entity_delete, btn_color, btn_pk_add, btn_col_add, btn_entity_delete_txt, btn_color_txt, btn_pk_add_txt, btn_col_add_txt;
        
        
        
//    2. ERD화면 초기화
      function init_ERD(){
          
          stage = new Konva.Stage({
            container: 'container_Shin',
            width: width2,
            height: height2,
            draggable: true
          });
          
          layer = new Konva.Layer();
          layer2 = new Konva.Layer();
          
          stage.add(layer).add(layer2);
          
          layer.draw();
          
      }  
        
    
      init_ERD();
      console.log(stage);
        
  // 미니맵용 스테이지 생성
  var mini_width = $('#container_mini').width();
		var mini_height = $('#container_mini').height();
		var mini_stage = new Konva.Stage({
			container: 'container_mini',
			width: mini_width,
			height: mini_height
		});
		
		var mini_layer = new Konva.Layer();
	
		//미니맵에 보이는 사각형 생성(빨간네모)
		var mini_rect = new Konva.Rect({
			x: 0,
			y: 0,
			width: mini_width/3,
			height: mini_height/2,
			stroke: 'red',
			strokeWidth: 2
			/* opacity: 0.3 */
		});
		mini_rect.draggable('true');
		mini_layer.add(mini_rect);
		mini_stage.add(mini_layer);
		
		
        
//        테이블 생성
        function entityAdd(circlePos){
            
            var color1_num = Math.floor(Math.random() * 3);
            
            entity = new Konva.Group({
                x: circlePos.x,
                y: circlePos.y,
                name: 'entity'
            });
            
          
            
//            테이블 전체 박스
            entity_container = new Konva.Rect({
                x: 0,
                y: 0,
                width: 200,
                height: 26,
                fill: color1[color1_num],
                stroke: 'white',
                strokeWidth: 0,
                name: 'entity_container'
            });
            
            //미니맵에 표시할 테이블 생성
            var mini_tb = new Konva.Rect({
				x: circlePos.x/30,
				y: circlePos.y/40,
				width: entity_container.width()/30,
				height: entity_container.height()/40,
				fill: 'black',
				id :entity._id        //메인스테이지 테이블의 id값을 참조함 
				/* opacity: 0.3 */
			});
            console.log('mini_tb 아이디 :'+mini_tb.id());
			mini_layer.add(mini_tb);
			mini_stage.add(mini_layer);
            
            entity_logical = new Konva.Rect({
                x: BORDER_SIZE,
                y: BORDER_SIZE,
                width: 98,
                height: 20,
                //fill: '#000000',
                //stroke: 'red',
                name: 'entity_logical'
            });
            
            
            
            entity_phisical = new Konva.Rect({
                x: entity_logical.x() + entity_logical.width(),
                y: BORDER_SIZE,
                width: 98,
                height: 20,
                //fill: '#000000',
                //stroke: 'red',
                name: 'entity_phisical'
            });
            
            entity_logical_txt = new Konva.Text({
                text: 'tableName',
                x: entity_logical.x(),
                y: entity_logical.y(),
                padding: 5,
                fill: '#ffffff',
                fontSize: 11,
                name: 'entity_logical_txt'
            });

            entity_phisical_txt = new Konva.Text({
                text: '테이블명(물리)',
                x: entity_phisical.x(),
                y: entity_phisical.y(),
                padding: 5,
                fill: '#ffffff',
                fontSize: 11,
                name: 'entity_phisical_txt'
            });
            
            entity.add(entity_container);
            entity.add(entity_logical).add(entity_phisical);
            entity.add(entity_logical_txt).add(entity_phisical_txt);
            
//            버튼 생성
            btn_entity_group = new Konva.Group({
                x: 0,
                y: 0,
                visible:false,
                name: 'btn_entity_group'
            });

            //entity 삭제 버튼
            btn_entity_delete = new Konva.Rect({
                x: entity_container.width() -(20-(BORDER_SIZE-1)),
                y: -(20+(BORDER_SIZE-1)),
                width: 20,
                height: 20,
                fill: '#333333',
                //stroke: 'red',
                cornerRadius: 5,
                name: 'btn_entity_delete'
                
            });
            
            btn_entity_delete_txt = new Konva.Text({
                text: 'x',
                x: btn_entity_delete.x()+4,
                y: btn_entity_delete.y()+3.5,
                fill: '#ffffff',
                fontSize: 12,
                name: 'btn_entity_delete_txt'
            });

            
            //색상 변경 버튼
            btn_color = new Konva.Rect({
                x: btn_entity_delete.x() - 21,
                y: btn_entity_delete.y(),
                width: 20,
                height: 20,
                fill: '#333333',
                //stroke: 'red',
                cornerRadius: 5,
                name: 'btn_color'
            });
            
            btn_color_txt = new Konva.Text({
                text: 'o',
                x: btn_color.x()+4,
                y: btn_color.y()+3.5,
                fill: '#ffffff',
                fontSize: 12,
                name: 'btn_color_txt'
            });

            btn_entity_group.add(btn_entity_delete).add(btn_color);
            btn_entity_group.add(btn_entity_delete_txt).add(btn_color_txt);
            
            
            //pk추가 버튼
            btn_pk_add = new Konva.Rect({
                x: -1,
                y: btn_entity_delete.y(),
                width: 20,
                height: 20,
                fill: '#FFD403',
                //stroke: 'red',
                cornerRadius: 5,
                name: 'btn_pk_add'
            });
            
            btn_pk_add_txt = new Konva.Text({
                text: '+',
                x: btn_pk_add.x()+4,
                y: btn_pk_add.y()+1.5,
                fill: '#000000',
                fontSize: 20,
                name: 'btn_pk_add_txt'
            });
            
            
            
            //일반 컬럼 추가 버튼
            btn_col_add = new Konva.Rect({
                x: btn_pk_add.x()+21,
                y: btn_entity_delete.y(),
                width: 20,
                height: 20,
                fill: '#0EB6FF',
                //stroke: 'red',
                cornerRadius: 5,
                name: 'btn_col_add'
            });
            
            btn_col_add_txt = new Konva.Text({
                text: '+',
                x: btn_col_add.x()+4,
                y: btn_col_add.y()+1.5,
                fill: '#000000',
                fontSize: 20,
                name: 'btn_col_add_txt'
            });
            
            
            btn_entity_group.add(btn_pk_add).add(btn_col_add);
            btn_entity_group.add(btn_pk_add_txt).add(btn_col_add_txt);
            
            layer.add(entity);
            entity.add(btn_entity_group);

             entity_resize();
             
            layer.draw();
            
            
             entity.off('dblclick');
             entity.on('dblclick', textClick);
            
             stage.off('click');
             stage.on('click', stageClick);

             //미니맵 이벤트
             entity.on('dragmove click', function(e){
//             	 e.target
//             	 if(e.target.findaasdasd(.length != old_target.findaasdasd().length){
            		 
//             	 }
				

            	 
//             	 console.log('gg3');
            	 var mini_entity = mini_stage.find('#'+e.target._id+'');
            	 mini_entity.x(e.target.x()/30);
            	 mini_entity.y(e.target.y()/40);
            	 mini_entity.width(e.target.width()/30);
            	 mini_entity.height(e.target.height()/40);
            	 mini_layer.draw();
            	 
            	 
            	 old_target = e.target;
            	 

             });
        }
        //entity 생성 종료
        
        
        
        
        
        //스테이지 클릭
        function stageClick(e){
            allNode = e.target;
            var old_container = entity_container;
            var old_entity = entity;
            var old_btn_pk_add = btn_pk_add;
            var old_btn_col_add = btn_col_add;
            var old_btn_entity_delete = btn_entity_delete;
            var old_btn_color = btn_color;
            var old_btn_entity_group = btn_entity_group;
            
            //입력창 삭제
           if(document.body.getElementsByTagName('input').length > 0){
               document.body.removeChild(inputss);
           }
            
            if(allNode.parent === null){
                console.log("스테이지 선택");
                
                old_btn_entity_group.hide();
                
                old_entity.draggable(false);
                old_container.strokeWidth(0);
                
            }else {
                
                
                //삭제 
                if(allNode.attrs.name.indexOf('btn_entity_delete') > -1){
                    var removeTableNo=allNode.findAncestor('.entity')._id;
                    console.log('삭제할번호'+ removeTableNo);
                    mini_stage.find('#'+removeTableNo+'').remove(); //미니맵 테이블 삭제
                    allNode.findAncestor('.entity').remove();
                    mini_layer.draw();
                    layer.draw();
                    return;
               }
                
                
                allNode.parent.children.each(function(f){
                    switch(f.attrs.name){
                        case "entity_container":
                            entity_container = f;
                            break;
                        case "entity_logical":
                            entity_logical = f;
                            break;
                        case "entity_phisical":
                            entity_phisical = f;    
                            break;
                        case "entity_logical_txt":
                            entity_logical_txt = f;    
                            break;
                        case "entity_phisical_txt":
                            entity_phisical_txt = f;    
                            break;
                        case "btn_entity_group":
                            btn_entity_group = f;
                            
                            
                            f.children.each(function(g){
                                switch(g.attrs.name){
                                    case "btn_entity_delete":
                                        btn_entity_delete = g;
                                        break;
                                    case "btn_color":
                                        btn_color = g;
                                        break;
                                    case "btn_pk_add":
                                        btn_pk_add = g;
                                        break;
                                    case "btn_col_add":
                                        btn_col_add = g;
                                        break;       
                                }
                                        
                            });
                            
                            
                            break;
                            
                            
                        
                   }

                });
                
                
                if(allNode.parent.attrs.name === "entity"){
                    entity = allNode.parent;
                }

                entity.moveTo(layer2);
       
                old_btn_entity_group.hide();
                
                old_entity.draggable(false);
                old_container.strokeWidth(0);
 
                btn_entity_group.show();
                
                entity.draggable(true);
                
                entity_container.strokeWidth(BORDER_SIZE);
                
                entity.moveTo(layer);
            }
            layer.draw();
        }
        
//        텍스트 값 입력 메소드
        var inputss = document.createElement('input');
        
        function textClick(e){
            
            console.log("double click!!!");
            
            textNode = e.target;
            
            if(textNode.className != "Text" || textNode.attrs.name.indexOf('btn') > -1){
                return;
            }
            
            
            console.log(textNode.text());
            var textPosition = textNode.getAbsolutePosition();


            var stageBox = stage.container().getBoundingClientRect();


            var areaPosition = {
              x: stageBox.left + textPosition.x,
              y: stageBox.top + textPosition.y
            };


			console.log((textNode.width()*stage.scale().x)+3);
            document.body.appendChild(inputss);

            inputss.value = textNode.text();
            inputss.style.position = 'absolute';
            inputss.style.top = (areaPosition.y) + 'px';	/* (areaPosition.y-(stage.scale().x+1)) + 'px'; */
            inputss.style.left = (areaPosition.x) + 'px';
            inputss.style.width = (textNode.width()-6)*stage.scale().x + 'px';
            inputss.style.height = (textNode.height()-3)*stage.scale().y + 'px';
            inputss.style.fontSize = textNode.fontSize()*stage.scale().x + 'px';
            inputss.style.paddingLeft = (5*stage.scale().x)+'px';
            
            inputss.style.background = textNode.findAncestor('.entity').findOne('.entity_container').attrs.fill;
            inputss.style.color = textNode.findAncestor('.entity').findOne('.entity_container').attrs.stroke;
            inputss.style.border = '0px';
            inputss.style.fontFamily = textNode.fontFamily();
           
//             inputss.style.border = (2*stage.scale().x)+'px solid #000';

            inputss.focus();

            inputss.addEventListener('keydown', enterK);
    
        }
       
        
        
        
        
        
        
        
        //엔터입력
        function enterK(e){
             if (e.keyCode === 13) {
                //텍스트 입력 값 적용
                 textNode.text(inputss.value);
                 
                //형제들 돌려
                 textNode.parent.children.each(function(f){
                     
                    if(textNode.attrs.name === f.attrs.name+"_txt"){
                        f.width(textNode.width());
                    }
                     
                     
                    switch(f.attrs.name){
                        case "entity_container":
                            entity_container = f;
                            break;
                        case "entity_logical":
                            entity_logical = f;
                            break;
                        case "entity_phisical":
                            entity_phisical = f;    
                            break;
                        case "entity_logical_txt":
                            entity_logical_txt = f;    
                            break;
                        case "entity_phisical_txt":
                            entity_phisical_txt = f;    
                            break;
                        case "btn_entity_group":
                            btn_entity_group = f;
                            
                            
                            f.children.each(function(g){
                                switch(g.attrs.name){
                                    case "btn_entity_delete":
                                        btn_entity_delete = g;
                                        break;
                                    case "btn_color":
                                        btn_color = g;
                                        break;
                                    case "btn_pk_add":
                                        btn_pk_add = g;
                                        break;
                                    case "btn_col_add":
                                        btn_col_add = g;
                                        break;  
                                    case "btn_entity_delete_txt":
                                        btn_entity_delete_txt = g;
                                        break; 
                                    case "btn_color_txt":
                                        btn_color_txt = g;
                                        break;
                                }
                            });
                            break;
      
                   }
                });
                 
                 
                 
                 
                 
                 
                 
                 
                 
                if(allNode.parent.attrs.name === "entity"){
                    entity = allNode.parent;
                }
                //리사이징 시작
                 entity_resize();
                 
                layer.draw();
                document.body.removeChild(inputss);
                //this.removeEventListener('keydown',arguments.callee);
                 console.log("엔터입력 완료");
              }
        }
        
        
      
        
        
        
        //리사이징
        
        function entity_resize(){
             entity_logical.width(entity_logical_txt.width());
             entity_phisical.x(entity_logical.width()+BORDER_SIZE);
             entity_phisical_txt.x(entity_phisical.x());
             entity_phisical.width(entity_phisical_txt.width()); entity_container.width(entity_logical_txt.width()+entity_phisical_txt.width()+(BORDER_SIZE*2));
            
            btn_entity_delete.x(entity_container.width() -(20-(BORDER_SIZE-1)));
            btn_color.x(btn_entity_delete.x() - 21);
            btn_entity_delete_txt.x(btn_entity_delete.x()+7);
            btn_color_txt.x(btn_color.x()+7);
            
            
            
            
        }
        
        
        
        
        
        
        
        //스크롤 확대 축소
        var SCALE_MIN = 0.34;
        var SCALE_MAX = 1.8;
        var scaleBy = 1.05;
        stage.on('wheel', e => {
                e.evt.preventDefault();
                var oldScale = stage.scaleX();
				console.log('stage.scaleX()'+ stage.scaleX());
				
			
				var plusWidth = (mini_width-(mini_width/3))/24;
				var plusHeight= (mini_height-(mini_height/2))/24;
				
				console.log(plusWidth);
				console.log(plusHeight);
				
				//확대할 경우에...
			if (e.evt.deltaY > 0) {
				if(mini_rect.width()<40){  //작은 돋보기 크기가 너무 작아지는 것을 막아줌
					return;
				}
				mini_rect.width(mini_rect.width() - plusWidth);
				mini_rect.height(mini_rect.height() - plusHeight);

			}
			//축소할 경우에...
			else if (e.evt.deltaY < 0) {
				if(mini_rect.width()>=184){ //작은 돋보기 크기가 너무 커지는 것을 막아줌
					return;
				}
				mini_rect.width(mini_rect.width() + plusWidth);
				mini_rect.height(mini_rect.height() + plusHeight);
			}
				
                var mousePointTo = {
                  x: stage.getPointerPosition().x / oldScale - stage.x() / oldScale,
                  y: stage.getPointerPosition().y / oldScale - stage.y() / oldScale
                };
                
            
                //최소, 최대 스케일 추가
                var newScale
                if(stage.scaleX() <= SCALE_MIN){
                newScale = e.evt.deltaY > 0 ? oldScale * scaleBy : oldScale;
                }else if(stage.scaleX() >= SCALE_MAX){
                newScale = e.evt.deltaY > 0 ? oldScale : oldScale / scaleBy;
                }else{    
                newScale = e.evt.deltaY > 0 ? oldScale * scaleBy : oldScale / scaleBy;
                }
                    
                stage.scale({ x: newScale, y: newScale });

                var newPos = {
                  x:
                    -(mousePointTo.x - stage.getPointerPosition().x / newScale) *
                    newScale,
                  y:
                    -(mousePointTo.y - stage.getPointerPosition().y / newScale) *
                    newScale
                };
                mini_layer.draw();//돋보기창
                stage.position(newPos);
                stage.batchDraw();
                console.log(stage.scale().x);
                    
      });
        

        
</script>


</html>


