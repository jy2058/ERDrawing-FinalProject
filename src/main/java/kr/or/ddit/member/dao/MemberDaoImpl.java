package kr.or.ddit.member.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.member.model.MemberVo;

@Repository("memberDao")
public class MemberDaoImpl implements IMemberDao{

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession; 
	
	@Override
	public List<MemberVo> getAllMember() {
		return sqlSession.selectList("member.getAllMember");
	}

	@Override
	public MemberVo selectMember(String memId) {
		return sqlSession.selectOne("member.selectMember",memId);
	}

	@Override
	public int insertMember(MemberVo vo) {
		return sqlSession.insert("member.insertMember",vo);
	}

	@Override
	public List<MemberVo> getAutoFindMem(String memId) {
		return sqlSession.selectList("member.getAutoFindMem", memId);
	}
	

}
