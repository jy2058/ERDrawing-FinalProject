package kr.or.ddit.post.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.post.dao.ICommentsDao;
import kr.or.ddit.post.model.CommentsVo;

@Service("commentsService")
public class CommentsServiceImpl implements ICommentsService{
	
	@Resource(name="commentsDao")
	private ICommentsDao commentsDao;
	
	public CommentsServiceImpl(){
	}

	@Override
	public List<CommentsVo> getAllComments(String postNo) {
		List<CommentsVo> commentsList = commentsDao.getAllComments(postNo);
		
		return commentsList;
	}

	@Override
	public CommentsVo getSelectComments(String cmtNo) {
		CommentsVo commentsVo = commentsDao.getSelectComments(cmtNo);
		
		return commentsVo;
	}

	@Override
	public int insertComments(CommentsVo commentsVo) {
		int insertCnt = commentsDao.insertComments(commentsVo);
		
		return insertCnt;
	}

	@Override
	public int updateComments(CommentsVo commentsVo) {
		int updateCnt = commentsDao.updateComments(commentsVo); 
		
		return updateCnt;
	}

	@Override
	public int deleteComments(String cmtNo) {
		int deleteCnt = commentsDao.deleteComments(cmtNo);
		
		return deleteCnt;
	}
	
	

}
