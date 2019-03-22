package kr.or.ddit.post.dao;

import java.util.List;

import kr.or.ddit.post.model.PostVo;
import kr.or.ddit.post.model.UploadFileVo;
import kr.or.ddit.util.model.PageVo;

public interface IPostDao {
	
	List<PostVo> getAllPost(String boardNo);
	
	PostVo getSelectPost(String postNo);
	
	List<PostVo> selectPostPagingList(PageVo pageVo);
	
	int getPostCnt(int boardNo);

	int insertPost(PostVo postVo);
	
	int updatePost(PostVo postVo);
	
	int deletePost(String PostNo);
	
	String getSelectBoardNm(String boardNo);
	
	// 파일업로드
	int insertUploadFile(UploadFileVo uploadFileVo);
		
}
