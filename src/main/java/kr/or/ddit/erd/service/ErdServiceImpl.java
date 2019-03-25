package kr.or.ddit.erd.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.ddit.erd.dao.IErdDao;
import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.team.dao.ITeamDao;
import kr.or.ddit.team.model.TagHistVo;
import kr.or.ddit.team.model.TagVo;

@Service("erdService")
public class ErdServiceImpl implements IErdService{
	private Logger logger = LoggerFactory.getLogger(ErdServiceImpl.class);
	
	@Resource(name="erdDao")
	private IErdDao erdDao;
	@Resource(name="teamDao")
	private ITeamDao teamDao;

	@Override
	public int addErd(ErdVo erdVo) {
		return erdDao.addErd(erdVo);
	}

	@Override
	public int addErdTag(ErdVo erdVo, String tag, String memId) {
		// tag 검색을 위한 list
		ArrayList<String> tagContentList = new ArrayList<>();
		int addErdCnt = 0;
		
		// 태그가 있을 때
		if(!tag.isEmpty()){
			
			String tagEmptyRemove = tag.replaceAll("\\p{Z}", "");	// 앞뒤 공백 제거
			String[] tagSplit = tagEmptyRemove.split(",");	// (,)로 자르기
			
			int cnt = 0;
			for(String tagFinal : tagSplit){
				cnt++;
				// (,)만 넣은 값 판별
				if(!tagFinal.equals("")){

					TagVo tagVo = new TagVo();
					tagVo.setTagContent(tagFinal);
					tagVo.setTagMaker(memId);
					
					teamDao.insertTag(tagVo);
					
					tagContentList.add(tagFinal);	// 입력한 태그 list에 추가
				}
			}
			// 입력받은 태그 다 넣었을 때 erd 생성
			if(cnt == tagSplit.length){
				addErdCnt = erdDao.addErd(erdVo);
				// erd 생성 후 태그와 erd 맵핑
				for(String tagContent : tagContentList){
					int tagNo = teamDao.getTagNo(tagContent);	// 입력한 태그의 tagNo 가져오기
					
					TagHistVo tagHistVo = new TagHistVo();
					tagHistVo.setErdNo(erdVo.getErdNo() + 1);	//erdNo nextKey 가져올 때 시퀀스보다 1씩 작게 가져옴. 임시로 +1 해줌
					tagHistVo.setTagNo(tagNo);
					
					teamDao.insertTagHist(tagHistVo);
				}
			}else{
				addErdCnt = 0;
			}
		}
		// 태그가 없을 경우
		else
			addErdCnt = erdDao.addErd(erdVo);
		
		return addErdCnt;
	}

	@Override
	public List<ErdVo> getMyErdList(String memId) {
		return erdDao.getMyErdList(memId);
	}

	@Override
	public Map<String, Object> getMyErdTagMap(String memId) {
		List<ErdVo> myErdList = erdDao.getMyErdList(memId);	// erdList
		Map<Integer, List<TagVo>> erdTagListMap = new HashMap<>();
		for(ErdVo erdVo : myErdList){
			int erdNo = erdVo.getErdNo();
			List<TagVo> erdTagList = teamDao.getErdTag(erdNo);	// tagList
			if(!erdTagList.isEmpty()){
				erdTagListMap.put(erdNo, erdTagList);	// tagList가 있을 때 erdNo를 key, tagList를 value로 설정
			}
		}
		Map<String, Object> erdTagMap = new HashMap<>();	// 리턴 값 2개 처리하기 위해 erdList와 erdTagListMap을 Map에 넣어 리턴 
		erdTagMap.put("myErdList", myErdList);
		erdTagMap.put("erdTagListMap", erdTagListMap);
		
		return erdTagMap;
	}

}
