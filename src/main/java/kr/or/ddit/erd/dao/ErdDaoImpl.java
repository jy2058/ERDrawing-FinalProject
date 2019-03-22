package kr.or.ddit.erd.dao;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.erd.model.ErdVo;

@Repository("erdDao")
public class ErdDaoImpl implements IErdDao{
	
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int addErd(ErdVo erdVo) {
		return sqlSession.insert("erd.addErd", erdVo);
	}

}
