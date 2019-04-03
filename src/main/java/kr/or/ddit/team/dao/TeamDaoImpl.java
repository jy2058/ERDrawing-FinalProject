package kr.or.ddit.team.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.member.model.MemberVo;
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

	@Override
	public List<TagVo> getErdTag(int erdNo) {
		return sqlSession.selectList("team.getErdTag", erdNo);
	}

	@Override
	public int insertTeam(TeamVo teamVo) {
		return sqlSession.insert("team.insertTeam", teamVo);
	}

	@Override
	public List<ErdVo> getTeamErdList(int teamNo) {
		return sqlSession.selectList("team.getTeamErdList", teamNo);
	}

	@Override
	public int insertTeamMember(TeamListVo teamListVo) {
		return sqlSession.insert("team.insertTeamMember", teamListVo);
	}

	@Override
	public List<TeamListVo> getTeamAllListTeamNo(int teamNo) {
		return sqlSession.selectList("team.getTeamAllListTeamNo", teamNo);
	}

	@Override
	public List<MemberVo> getTeamMember(int teamNo) {
		return sqlSession.selectList("team.getTeamMember", teamNo);
	}

	@Override
	public int authUpdate(TeamListVo teamListVo) {
		return sqlSession.update("team.authUpdate", teamListVo);
	}

	@Override
	public int delMember(TeamListVo teamListVo) {
		return sqlSession.delete("team.delMember", teamListVo);
	}

	@Override
	public int updateAgreeFlag(TeamListVo teamListVo) {
		return sqlSession.update("team.updateAgreeFlag", teamListVo);
	}

}
