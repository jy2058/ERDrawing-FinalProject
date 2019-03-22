package kr.or.ddit.erd.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.erd.dao.IErdDao;
import kr.or.ddit.erd.model.ErdVo;

@Service("erdService")
public class ErdServiceImpl implements IErdService{
	@Resource(name="erdDao")
	private IErdDao erdDao;

	@Override
	public int addErd(ErdVo erdVo) {
		return erdDao.addErd(erdVo);
	}

}
