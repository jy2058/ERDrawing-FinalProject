package kr.or.ddit.post.dao;

import java.util.List;

import kr.or.ddit.post.model.BoardVo;


public interface IBoardDao {
	
	// 게시판 전체 조회
	List<BoardVo> getAllBoard();

	// 게시판 특정 조회
	BoardVo getSelectBoard(String boardNo);
	
}
