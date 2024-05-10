package com.ict.campyou.bm.service;

import java.util.List;

import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bm.dao.ChatVO;
import com.ict.campyou.bm.dao.FaqVO;
import com.ict.campyou.bm.dao.QnaVO;
import com.ict.campyou.hu.dao.MemberVO;

public interface MyService {

	// get faq questions
	public List<FaqVO> getFaqs();

	public List<FaqVO> getFaqs2();

	public MemberVO getMemberPwd(String memberId);

	public MemberVO getMember(String member_idx);

	public int changeUserInfo(MemberVO mvo);

	public int changeUserPW(MemberVO mvo);

	public int deletMember(String member_idx);

	public int uploadQna(QnaVO qvo);

	public QnaVO getMyOneQna(String qna_idx);

	public int updateQna(QnaVO qvo);

	public List<QnaVO> getMyQna(String member_idx);

	public int getTotalCount(String member_idx);

	public List<TogetherVO> getMyAcc_List(String member_idx);

	public int addChatMsg(ChatVO chvo);

	public List<ChatVO> getChatList(String member_idx);

	public List<ChatVO> getOneRoom(String msg_room);
	
	public int updateMsgRead(String msg_idx);

}

	

