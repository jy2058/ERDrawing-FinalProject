package kr.or.ddit.team.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.team.dao.ITeamDao;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.team.model.TeamVo;

@Service("teamService")
public class TeamServiceImpl implements ITeamService{
	@Resource(name="teamDao")
	private ITeamDao teamDao;

	@Override
	public List<TeamListVo> getTeamAllList(String memId) {
		return teamDao.getTeamAllList(memId);
	}

	@Override
	public List<TeamVo> getMemberTeamInfoList(String memId) {
		List<TeamListVo> teamAllList = teamDao.getTeamAllList(memId);
		ArrayList<TeamVo> teamInfoList = new ArrayList<>();
		
		for(TeamListVo teamListVo : teamAllList){
			int teamNo = teamListVo.getTeamNo();
			TeamVo teamVo = teamDao.getTeamInfo(teamNo);
			teamInfoList.add(teamVo);
		}
		return teamInfoList;
	}
	
	@Override
	public List<TeamVo> getMemberAgreTeamInfoList(String memId) {
		List<TeamListVo> teamAllList = teamDao.getTeamAllList(memId);
		ArrayList<TeamVo> teamInfoList = new ArrayList<>();
		
		for(TeamListVo teamListVo : teamAllList){
			
			if(teamListVo.getTeamAgreeFlag().equals("y")){
				int teamNo = teamListVo.getTeamNo();
				TeamVo teamVo = teamDao.getTeamInfo(teamNo);
				teamInfoList.add(teamVo);
			}
		}
		return teamInfoList;
	}

	@Override
	public int insertTag(TagVo tagVo) {
		return teamDao.insertTag(tagVo);
	}

}
