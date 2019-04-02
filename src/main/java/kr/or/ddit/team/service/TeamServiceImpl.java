package kr.or.ddit.team.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.team.dao.ITeamDao;
import kr.or.ddit.team.model.TagHistVo;
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

	@Override
	public int getTagNo(String tagContent) {
		return teamDao.getTagNo(tagContent);
	}

	@Override
	public int insertTagHist(TagHistVo tagHistVo) {
		return teamDao.insertTagHist(tagHistVo);
	}

	@Override
	public int insertTeam(TeamVo teamVo, List<String> teamMember) {
		int insertTeam = teamDao.insertTeam(teamVo);

		for (String member : teamMember) {
			TeamListVo vo = new TeamListVo();
			if (teamVo.getMakerId().equals(member)) {	// 팀 생성자일 경우
				vo.setTeamAgreeFlag("y");
				vo.setTeamAuth("creator");
			}
			// 멤버일 경우
			vo.setMemId(member);
			vo.setTeamNo(teamVo.getTeamNo());
			teamDao.insertTeamMember(vo);	// 멤버 추가
		}
		return insertTeam;
	}

	@Override
	public List<ErdVo> getTeamErdList(int teamNo) {
		return teamDao.getTeamErdList(teamNo);
	}

	@Override
	public Map<String, Object> getTeamErdTagMap(int teamNo) {
		List<ErdVo> teamErdList = teamDao.getTeamErdList(teamNo); // erdList
		Map<Integer, List<TagVo>> erdTagListMap = new HashMap<>();
		for(ErdVo erdVo : teamErdList){
			int erdNo = erdVo.getErdNo();
			List<TagVo> erdTagList = teamDao.getErdTag(erdNo); // tagList
			if(!erdTagList.isEmpty()){
				erdTagListMap.put(erdNo, erdTagList); // tagList가 있을 때 erdNo를 key, tagList를 value로 설정
			}
		}
		Map<String, Object> erdTagMap = new HashMap<>();	// 리턴 값 2개 처리하기 위해 erdList와 erdTagListMap을 Map에 넣어 리턴
		erdTagMap.put("teamErdList", teamErdList);
		erdTagMap.put("erdTagListMap", erdTagListMap);
		
		return erdTagMap;
	}

	@Override
	public TeamVo getTeamInfo(int teamNo) {
		return teamDao.getTeamInfo(teamNo);
	}

	@Override
	public List<TeamListVo> getTeamAllListTeamNo(int teamNo) {
		return teamDao.getTeamAllListTeamNo(teamNo);
	}

	@Override
	public Map<String, Object> teamMemberListMap(int teamNo) {
		List<TeamListVo> teamList = teamDao.getTeamAllListTeamNo(teamNo);	// 초대 수락 한 팀 리스트
		List<MemberVo> teamMember = teamDao.getTeamMember(teamNo);	// 초대 수락 한 회원 리스트
		
		Map<String, Object> teamMemberMap = new HashMap<String, Object>();
		teamMemberMap.put("teamList", teamList);
		teamMemberMap.put("teamMember", teamMember);
		
		return teamMemberMap;
	}

	@Override
	public int authUpdate(TeamListVo teamListVo) {
		return teamDao.authUpdate(teamListVo);
	}

	@Override
	public int delMember(TeamListVo teamListVo) {
		return teamDao.delMember(teamListVo);
	}


}
