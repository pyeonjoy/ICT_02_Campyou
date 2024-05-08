package com.ict.campyou.bjs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.campyou.jun.dao.CampVO;

@Repository
public class TogetherDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int getToTotalCount() throws Exception{
		return sqlSessionTemplate.selectOne("bjs.count");
	}
	
	public int getToTotalCount2(String searchType, String searchKeyword) throws Exception {
		Map<String, String> map = new HashMap<String, String>(); 
		map.put("searchType", searchType);
		map.put("searchKeyword", searchKeyword);
		return sqlSessionTemplate.selectOne("bjs.count2", map);
	}
	
	public List<TogetherVO> getTogetherList(int offset, int limit) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();  
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("bjs.to_list", map);
	}
	
	public List<CampVO> getTogetherCampList() throws Exception {
		return sqlSessionTemplate.selectList("bjs.camp_list");
	}
	
	public int getPomiseCount(String t_idx) throws Exception {
		return sqlSessionTemplate.selectOne("bjs.promiseCount", t_idx);
	}
	
	public TogetherVO getTogetherDetail(String t_idx) throws Exception {
		sqlSessionTemplate.update("bjs.to_hit", t_idx);
		return sqlSessionTemplate.selectOne("bjs.to_detail", t_idx);
	}
	
	public int getTogetherWriteOK(TogetherVO tvo) throws Exception {
		sqlSessionTemplate.insert("bjs.to_insert", tvo);
		int t_idx = sqlSessionTemplate.selectOne("bjs.write_t_idx");
		return t_idx;
	}
	
	public int getPromiseUpdate(PromiseVO pvo) throws Exception {
		return sqlSessionTemplate.insert("bjs.promise_insert", pvo);
	}
	
	public String getSearchCamp(String campName) throws Exception {
		int result = sqlSessionTemplate.selectOne("bjs.camp_chk", campName);
		if(result > 0) {
			return "ok";
		}
		return "fail";
	}
	
	public CampVO getSearchCampDetail(String campName) throws Exception {
		return sqlSessionTemplate.selectOne("bjs.camp_detail", campName);
	}
	
	public List<TogetherVO> getTogetherListSearch(int offset, int limit, String searchType, String searchKeyword) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();  
		map.put("offset", offset);
		map.put("limit", limit);
		map.put("searchType", searchType);
		map.put("searchKeyword", searchKeyword);
		return sqlSessionTemplate.selectList("bjs.to_list_search", map);
	}
	
	public int getPromiseChk(PromiseVO pvo) {
		return sqlSessionTemplate.selectOne("bjs.promise_chk", pvo);
	}
	
	public int getToPomise(PromiseVO pvo) throws Exception {
		return sqlSessionTemplate.insert("bjs.promise", pvo);
	}
	
	public int getToPomiseCancel(PromiseVO pvo) throws Exception {
		return sqlSessionTemplate.delete("bjs.promise_delete", pvo);
	}
	
	public int getTogetherUpdateOK(TogetherVO tvo) throws Exception {
		return sqlSessionTemplate.update("bjs.to_update", tvo);
	}
	
	public int getTogetherDeleteOK(String t_idx) throws Exception {
		return sqlSessionTemplate.update("bjs.to_delete", t_idx);
	}
	
	public List<String> getTIdxList(String member_idx) throws Exception {
		return sqlSessionTemplate.selectList("bjs.together_idxList", member_idx);
	}
	
	public List<PromiseVO> getPromiseApplyList(String tIdx) throws Exception {
		return sqlSessionTemplate.selectList("bjs.promise_apply_list", tIdx);
	}
	
}
