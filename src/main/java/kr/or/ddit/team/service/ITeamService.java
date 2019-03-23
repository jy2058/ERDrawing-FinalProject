package kr.or.ddit.team.service;

import java.util.List;

import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.team.model.TeamVo;

public interface ITeamService {
	/**
	* Method : getTeamAllList
	* 작성자 : kjy
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 팀 리스트 가져오기
	*/
	List<TeamListVo> getTeamAllList(String memId);

	/**
	* Method : getMemberTeamInfoList
	* 작성자 : kjy
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 회원의 팀 정보 가져오기
	*/
	List<TeamVo> getMemberTeamInfoList(String memId);
	
	/**
	* Method : getMemberAgreTeamInfoList
	* 작성자 : kjy
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 회원이 수락한 팀 정보 가져오기
	*/
	List<TeamVo> getMemberAgreTeamInfoList(String memId);
	
	/**
	* Method : insertTag
	* 작성자 : kjy
	* 변경이력 :
	* @param tagVo
	* @return
	* Method 설명 : 태그 insert
	*/
	int insertTag(TagVo tagVo);

}
