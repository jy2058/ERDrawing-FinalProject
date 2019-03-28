/**
 * erdDrawing.jsp minimap 기능에 관련된 스크립트 입니다.
 */
//미니맵 켜기/끄기
$(document).ready(function() {
	var flag = true;
	$("#button4").on('click', function() {
		if (flag) {
			$("#container_mini").css('display', 'block');
		} else if (!flag) {
			$("#container_mini").css('display', 'none');
		}
		flag = !flag;
	});
	mini_rect.on('dragmove', function() {
		console.log('move');
		collision_check_mini();
		moveMiniStage();
	});

	//미니맵 사각형의 충돌 체크
	function collision_check_mini() {
		console.log((mini_stage.width() - mini_rect.width()));
		console.log((mini_stage.height() - mini_rect.height()));
		//x좌표의 왼쪽쪽 끝
		if (mini_rect.x() <= 0) {
			mini_rect.x(0);
		}
		//y좌표의 왼쪽 끝
		if (mini_rect.y() <= 0) {
			mini_rect.y(0);
		}

		//x좌표의 오른쪽 끝
		if (mini_rect.x() >= (mini_stage.width() - mini_rect.width())) { //160
			mini_rect.x(mini_stage.width() - mini_rect.width());
		}
		//y좌표의 오른쪽 끝
		if (mini_rect.y() >= (mini_stage.height() - mini_rect.height())) { //90
			mini_rect.y(mini_stage.height() - mini_rect.height());
		}
	}

	//미니맵에 사각형을 움직였을 때. 메인 스테이지의 위치를 바꿔주는 메서드
	function moveMiniStage() {
		stage.x(-mini_rect.x() * 30);
		stage.y(-mini_rect.y() * 40);
		console.log('스테이지 이동');
		layer.draw();
	}

	//메인 스테이지를 드래그로  이동할 때
	stage.on('dragmove', function() {
		console.log('Main Stage move');
		collision_check();
		moveStage();
	});

	//메인스테이지의  충돌체크
	function collision_check() {
		//x좌표의 왼쪽쪽 끝
		if (stage.x() > 0) {
			stage.x(0);
		}
		//y좌표의 왼쪽 끝
		if (stage.y() > 0) {
			stage.y(0);
		}

		//x좌표의 오른쪽 끝
		if (stage.x() < -3680) {
			stage.x(-3680);
		}
		//y좌표의 오른쪽 끝
		if (stage.y() < -1714) {
			stage.y(-1714);
		}
	}
	;

	//메인 스테이지가 움직 일 때, 미니맵 스테이지를 움직이게 하는 메서드
	function moveStage() {
		mini_rect.x(-stage.x() / 30);
		mini_rect.y(-stage.y() / 40);
		mini_layer.draw();
	}
	;

});