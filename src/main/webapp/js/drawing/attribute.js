
//    1. 변수 초기화
//    var colorPick = [
//      { 
//          name : 'yellow',           //명칭
//          entityBg : '#6d6c27',     //엔티티 배경색
//          entityColor : '#ffffff',  //엔티티 폰트색
//          groupColor : '#53521f',          //속성 테두리
//          groupColorActive : '#a68db4',    //속성 테두리(선택시)
//          pkBg : '#AAA94D',                //pk 배경색
//          pkColor : '#ffffff',             //pk 폰트색
//          fkBg : '#5f5f3a',
//          fkColor : '#ffffff',
//          atBg : '#49492f',
//          atColor : '#ffffff'
//      },{ 
//          name : 'black',           //명칭
//          entityBg : '#000000',     //엔티티 배경색
//          entityColor : '#ffffff',  //엔티티 폰트색
//          groupColor : '#000000',          //속성 테두리
//          groupColorActive : '#eeeeee',    //속성 테두리(선택시)
//          pkBg : '#412d1b',                //pk 배경색
//          pkColor : '#ffffff',             //pk 폰트색
//          fkBg : '#4a3f3f',
//          fkColor : '#ffffff',
//          atBg : '#2c2c2c',
//          atColor : '#ffffff'
//      },{ 
//          name : 'red',           //명칭
//          entityBg : '#6d6c27',     //엔티티 배경색
//          entityColor : '#ffffff',  //엔티티 폰트색
//          groupColor : '#53521f',          //속성 테두리
//          groupColorActive : '#a68db4',    //속성 테두리(선택시)
//          pkBg : '#AAA94D',                //pk 배경색
//          pkColor : '#ffffff',             //pk 폰트색
//          fkBg : '',
//          fkColor : '#ffffff',
//          atBg : '49492f',
//          atColor : '#ffffff'
//      }];



//  attribute추가
    // pk_group . fk_group . attr_group
    function attributeAdd(select_group, entity, circlePos){
        
        
        var attributeGroup = entity.findOne("."+select_group);
        
        color1_num = entity.attrs.class;
        
        console.log(attributeGroup.children.length);
        
        var attrLength = attributeGroup.children.length;
        
        //속성 위치값 구하기
        var attrPosition = 23*attrLength;
        
        var attrKey;
        var containerColor;
        var backgroundColor;
        var fontColor;
        
        
        switch(select_group){
	        case "pk_group":
	            attrKey = "PrimaryKey";
	            containerColor = colorPick[color1_num].groupColor;
	            backgroundColor = colorPick[color1_num].pkBg;
	            fontColor = colorPick[color1_num].pkColor;
	            break;
	            
	        case "fk_group":
	            attrKey = "ForeignKey";
	            containerColor = colorPick[color1_num].groupColor;
	            backgroundColor = colorPick[color1_num].fkBg;
	            fontColor = colorPick[color1_num].fkColor;
	            break;
	            
	        case "attr_group":
	            attrKey = "Attribute";
	            containerColor = colorPick[color1_num].groupColor;
	            backgroundColor = colorPick[color1_num].atBg;
	            fontColor = colorPick[color1_num].atColor;
	            break;
	            
	    }
        
        
        attribute = new Konva.Group({
            x: BORDER_SIZE,
            y: attrPosition,
            name: 'attribute'
        });

        


//      속성 전체 박스
        attr_container = new Konva.Rect({
            x: 0,
            y: 0,
            width: 508,
            height: 26,
            fill: containerColor,
            name: 'attr_container'
        });

      

        //속성 종류 설정
        // key . 논리 . 물리 . 도메인 . 타입
        
        //key
        attr_key = new Konva.Rect({
            x: BORDER_SIZE,
            y: BORDER_SIZE,
            width: 98,
            height: 20,
            fill: backgroundColor,
            //stroke: 'red',
            name: 'attr_key'
        });
        
        attr_key_txt = new Konva.Text({
            text: attrKey,
            x: attr_key.x(),
            y: attr_key.y(),
            padding: 5,
            fill: fontColor,
            fontSize: 11,
            name: 'attr_key_txt'
        });
        
        
        // 논리 컬럼
        attr_logical = new Konva.Rect({
            x: BORDER_SIZE+attr_key.x() + attr_key.width(),
            y: BORDER_SIZE,
            width: 98,
            height: 20,
            fill: backgroundColor,
            name: 'attr_logical'
        });
        
        attr_logical_txt = new Konva.Text({
            text: 'key_논리',
            x: attr_logical.x(),
            y: attr_logical.y(),
            padding: 5,
            fill: fontColor,
            fontSize: 11,
            name: 'attr_logical_txt'
        });
        
        
        // 물리 컬럼
        attr_phisical = new Konva.Rect({
            x: BORDER_SIZE+attr_logical.x() + attr_logical.width(),
            y: BORDER_SIZE,
            width: 98,
            height: 20,
            fill: backgroundColor,
            name: 'attr_phisical'
        });
        
        attr_phisical_txt = new Konva.Text({
            text: 'key_물리',
            x: attr_phisical.x(),
            y: attr_phisical.y(),
            padding: 5,
            fill: fontColor,
            fontSize: 11,
            name: 'attr_phisical_txt'
        });
        
        
        // 도메인
        attr_domain = new Konva.Rect({
            x: BORDER_SIZE+attr_phisical.x() + attr_phisical.width(),
            y: BORDER_SIZE,
            width: 98,
            height: 20,
            fill: backgroundColor,
            name: 'attr_domain'
        });
        
        attr_domain_txt = new Konva.Text({
            text: 'Domain',
            x: attr_domain.x(),
            y: attr_domain.y(),
            padding: 5,
            fill: fontColor,
            fontSize: 11,
            name: 'attr_domain_txt'
        });
        
        
        // 타입
        attr_type = new Konva.Rect({
            x: BORDER_SIZE+attr_domain.x() + attr_domain.width(),
            y: BORDER_SIZE,
            width: 98,
            height: 20,
            fill: backgroundColor,
            name: 'attr_type'
        });
        
        attr_type_txt = new Konva.Text({
            text: 'Type',
            x: attr_type.x(),
            y: attr_type.y(),
            padding: 5,
            fill: fontColor,
            fontSize: 11,
            name: 'attr_type_txt'
        });
        
        
        

//      객체 등록
        attribute.add(attr_container);
        attribute.add(attr_key).add(attr_key_txt);
        attribute.add(attr_logical).add(attr_phisical).add(attr_domain).add(attr_type);
        attribute.add(attr_logical_txt).add(attr_phisical_txt).add(attr_domain_txt).add(attr_type_txt);

        attributeGroup.add(attribute);
        
        
        //리사이징 시키기
        pk_group = entity.findOne('.pk_group');
        fk_group = entity.findOne('.fk_group');
        attr_group = entity.findOne('.attr_group');
            
        pkLength = pk_group.children.length;
        fkLength = fk_group.children.length;
        atLength = attr_group.children.length;
        
        //속성 위치값 구하기
        pkPosition = 23*pkLength;
        fkPosition = 23*fkLength;
        atPosition = 23*atLength;

        //fk, attr y축 변경
        fk_group.y(26+pkPosition);
        attr_group.y(26+pkPosition+fkPosition);
        
        
        //엔티티 컨테이너 크기 변경
        entity.findOne('.entity_container').height(4+29+(pkPosition+fkPosition+atPosition));
        entity.findOne('.entity_container').width(514);
        
        
        
         layer.draw();

    }
    //entity 생성 종료
