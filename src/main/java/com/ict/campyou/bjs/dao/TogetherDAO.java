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
		return sqlSessionTemplate.selectOne("bjs.promise_people_count", t_idx);
	}
	
	public TogetherVO getTogetherDetail(String t_idx) throws Exception {
		sqlSessionTemplate.update("bjs.to_hit", t_idx);
		return sqlSessionTemplate.selectOne("bjs.to_detail", t_idx);
	}
	
	public int getTogetherWriteOK(TogetherVO tvo) throws Exception {
		sqlSessionTemplate.update("bjs.write_count", tvo.getMember_idx());
		Map<String, Integer> writeAllCount = sqlSessionTemplate.selectOne("bjs.writeAll_count", tvo.getMember_idx());
		int memberGrade = writeAllCount.get("member_grade");
		int writeCountSum = writeAllCount.get("member_free") + writeAllCount.get("member_with") + writeAllCount.get("member_camp");
		if(writeCountSum % 10 == 0) {
			switch (writeCountSum) {
			case 10: tvo.setMember_grade(String.valueOf(memberGrade + 1));
					 sqlSessionTemplate.update("bjs.member_grade_update", tvo); break;
			case 20: tvo.setMember_grade(String.valueOf(memberGrade + 1));
					 sqlSessionTemplate.update("bjs.member_grade_update", tvo); break;
			case 30: tvo.setMember_grade(String.valueOf(memberGrade + 1));
					 sqlSessionTemplate.update("bjs.member_grade_update", tvo); break;
			case 40: tvo.setMember_grade(String.valueOf(memberGrade + 1));
					 sqlSessionTemplate.update("bjs.member_grade_update", tvo); break;
			}
		}
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
	
	public String getPromiseChk(PromiseVO pvo) {
		return sqlSessionTemplate.selectOne("bjs.promise_chk", pvo);
	}
	
	public int getPmStateChk(PromiseVO pvo) throws Exception {
		return sqlSessionTemplate.selectOne("bjs.pm_state_chk", pvo);
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
	
	public List<PromiseVO> getPromiseList(String member_idx) throws Exception {
		return sqlSessionTemplate.selectList("bjs.promise_list", member_idx);
	}
	
	public int getAcceptPromise(String pm_idx) throws Exception {
		return sqlSessionTemplate.update("bjs.accept_promise", pm_idx);
	}
	
	public int getPromiseMyCount(String member_idx) throws Exception {
		return sqlSessionTemplate.selectOne("bjs.promise_ok_my_count", member_idx);
	}
	
	public int getDeclinePromise(String pm_idx) throws Exception {
		return sqlSessionTemplate.update("bjs.decline_promise", pm_idx);
	}
	
	public int getToHistoryCount(String member_idx) throws Exception {
		return sqlSessionTemplate.selectOne("bjs.history_count", member_idx);
	}
	
	public List<PromiseVO> getTogetherHistoryGet(String member_idx, int offset, int limit) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_idx", member_idx);
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("bjs.together_history", map);
	}
	
	public int getToHistorySendCount(String member_idx) throws Exception {
		return sqlSessionTemplate.selectOne("bjs.histor_send_count", member_idx);
	}
	
	public List<PromiseVO> getTogetherSendHistory(String member_idx, int offset, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_idx", member_idx);
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("bjs.together_send_history", map);
	}
	
	public List<TogetherCommentVO> getToCommentList(String t_idx) throws Exception {
		return sqlSessionTemplate.selectList("bjs.to_comment_list", t_idx);
	}
	
	public int getToCommentMaxStep(Map<String, Integer> map) throws Exception {
		return sqlSessionTemplate.selectOne("bjs.to_step_max", map);
	}
	
	public int getToCommentSame(Map<String, Integer> map) throws Exception {
		return sqlSessionTemplate.selectOne("bjs.to_comment_same", map);
	}
	
	public List<TogetherCommentVO> getGroupList(Map<String, Integer> map) throws Exception {
		return sqlSessionTemplate.selectList("bjs.group_list", map);
	}
	
	public int getToCommentGSUpdate(Map<String, Integer> map) throws Exception {
		return sqlSessionTemplate.update("bjs.to_comment_gs_update", map);
	}
	
	public int getToCommentWrite(TogetherCommentVO tcvo) throws Exception {
		if(tcvo.getWc_idx() != null && !tcvo.getWc_idx().isEmpty()) {
			return sqlSessionTemplate.insert("bjs.to_comment_in_write", tcvo);
		}else {
			return sqlSessionTemplate.insert("bjs.to_comment_write", tcvo);
		}
	}
	
	public int getToCommentDelete(String wc_idx) throws Exception {
		return sqlSessionTemplate.update("bjs.to_comment_delete", wc_idx);
	}
	
	public int getToCommentUpdate(TogetherCommentVO tcvo) throws Exception {
		return sqlSessionTemplate.update("bjs.to_comment_update", tcvo);
	}
	
	public int getBoardWithCount(String member_idx) throws Exception {
		return sqlSessionTemplate.selectOne("bjs.my_board_with_count", member_idx);
	}
	
	public List<TogetherVO> getPromiseIng(String member_idx, int offset, int limit) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_idx", member_idx);
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("bjs.promise_ing", map);
	}
	
	public List<PromiseVO> getPromisePeopleDetail(String t_idx) throws Exception {
		return sqlSessionTemplate.selectList("bjs.promise_people_detail", t_idx);
	}
	
	public int getStarRatingCheck(StarRatingVO srvo) throws Exception {
		return sqlSessionTemplate.selectOne("bjs.star_rating_check", srvo);
	}
	
	public int getPromiseBanMember(PromiseVO pvo) throws Exception {
		return sqlSessionTemplate.update("bjs.promise_ban_member", pvo);
	}
	
	public int getBoardWithCountReady(String member_idx) throws Exception {
		return sqlSessionTemplate.selectOne("bjs.my_board_with_ready_count", member_idx);
	}
	
	public List<TogetherVO> getPromiseReady(String member_idx, int offset, int limit) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_idx", member_idx);
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("bjs.promise_ready", map);
	}
	
	public int getBoardWithCountEnd(String member_idx) throws Exception {
		return sqlSessionTemplate.selectOne("my_board_with_end_count", member_idx);
	}
	
	public List<TogetherVO> getPromiseEnd(String member_idx, int offset, int limit) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_idx", member_idx);
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("bjs.promise_End", map);
	}
	
	public int getEnddateUpdate(String t_idx) throws Exception {
		return sqlSessionTemplate.update("bjs.enddate_update", t_idx);
	}
	
	public int getConfirmPartner(PromiseVO pvo) throws Exception {
		return sqlSessionTemplate.update("bjs.confirm_partner", pvo);
	}
	
}
