package kr.or.ddit.post.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.post.model.PostVo;
import kr.or.ddit.post.model.UploadFileVo;
import kr.or.ddit.util.model.PageVo;

public interface IPostService {
	
	List<PostVo> getAllPost(String boardNo);
	
	PostVo getSelectPost(String postNo);
	
	//Map<String, Object> selectPostPagingList(PageVo pageVo, String boardNo);
	
	List<PostVo> selectPostPagingList(PageVo pageVo);
	
	int insertPost(PostVo postVo);
	
	int updatePost(PostVo postVo);
	
	int deletePost(String PostNo);
	
	String getSelectBoardNm(String boardNo);
	
	// 파일업로드
	int insertUploadFile(UploadFileVo uploadFileVo);

}
