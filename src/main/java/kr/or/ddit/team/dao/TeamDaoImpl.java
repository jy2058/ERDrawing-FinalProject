package kr.or.ddit.team.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.team.model.TagHistVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.team.model.TeamVo;

@Repository("teamDao")
public class TeamDaoImpl implements ITeamDao{
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	@Override
	public List<TeamListVo> getTeamAllList(String memId) {
		return sqlSession.selectList("team.getTeamAllList", memId);
	}

	@Override
	public TeamVo getTeamInfo(int teamNo) {
		return sqlSession.selectOne("team.getTeamInfo", teamNo);
	}

	@Override
	public int insertTag(TagVo tagVo) {
		return sqlSession.insert("team.insertTag", tagVo);
	}

	@Override
	public int getTagNo(String tagContent) {
		return sqlSession.selectOne("team.getTagNo", tagContent);
	}

	@Override
	public int insertTagHist(TagHistVo tagHistVo) {
		return sqlSession.insert("team.insertTagHist", tagHistVo);
	}

}
