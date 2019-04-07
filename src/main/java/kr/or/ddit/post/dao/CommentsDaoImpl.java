package kr.or.ddit.post.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.post.model.CommentsVo;

@Repository("commentsDao")
public class CommentsDaoImpl implements ICommentsDao {
	
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<CommentsVo> getAllComments(String postNo) {
		List<CommentsVo> CommentsList = sqlSessionTemplate.selectList("post.getAllComments", postNo);

		return CommentsList;
	}

	@Override
	public CommentsVo getSelectComments(String cmtNo) {
		CommentsVo commentsVo = sqlSessionTemplate.selectOne("post.getSelectComments", cmtNo);
		
		return commentsVo;
	}

	@Override
	public int insertComments(CommentsVo commentsVo) {
		int insertCnt = sqlSessionTemplate.insert("post.insertComments", commentsVo);
		
		return insertCnt;
	}

	@Override
	public int deleteComments(String cmtNo) {
		int deleteCnt = sqlSessionTemplate.delete("post.deleteComments", cmtNo);
		
		return deleteCnt;
	}


}
