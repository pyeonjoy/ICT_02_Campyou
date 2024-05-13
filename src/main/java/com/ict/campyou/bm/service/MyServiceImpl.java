package com.ict.campyou.bm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bm.dao.ChatVO;
import com.ict.campyou.bm.dao.FaqVO;
import com.ict.campyou.bm.dao.MyDAO;
import com.ict.campyou.bm.dao.QnaVO;
import com.ict.campyou.hu.dao.MemberVO;

@Service
public class MyServiceImpl implements MyService{

	@Autowired
	private MyDAO myDao; 
	@Override
	public List<FaqVO> getFaqs() {
		return myDao.getFaqs();
	}
	@Override
	public List<FaqVO> getFaqs2() {
		return myDao.getFaqs2();
	}
	@Override
	public MemberVO getMemberPwd(String memberId) {		
		return myDao.getMemberPwd(memberId);
	}
	@Override
	public int changeUserInfo(MemberVO mvo) {
		return myDao.changeUserInfo(mvo);
	}
	@Override
	public int changeUserPW(MemberVO mvo) {
		return myDao.changeUserPW(mvo);
	}
	@Override
	public int deletMember(String member_idx) {
		return myDao.deletMember(member_idx);
	}
	@Override
	public MemberVO getMember(String member_idx) {
		return myDao.getMember(member_idx);
	}
	@Override
	public int uploadQna(QnaVO qvo) {
		return myDao.uploadQna(qvo);
	}
	@Override
	public int updateQna(QnaVO qvo) {
		return myDao.updateQna(qvo);
	}
	@Override
	public List<QnaVO> getMyQna(String member_idx) {
		return myDao.getMyQna(member_idx);
	}
	@Override
	public int getTotalCount(String member_idx) {	
		return myDao.getTotalCount(member_idx);
	}

	@Override
	public QnaVO getMyOneQna(String qna_idx) {		
		return myDao.getMyOneQna(qna_idx);
	}
	@Override
	public List<TogetherVO> getMyAcc_List(String member_idx) {	
		return myDao.getMyAcc_List(member_idx);
	}
	@Override
	public int addChatMsg(ChatVO chvo) {
		return myDao.addChatMsg(chvo);
	}
	@Override
	public List<ChatVO> getChatList(String member_idx) {
	
		return myDao.getChatList(member_idx);
	}
	@Override
	public List<ChatVO> getOneRoom(String msg_room) {
		return myDao.getOneRoom(msg_room);
	}
	@Override
	public int updateMsgRead(String msg_idx) {
		return myDao.updateMsgRead(msg_idx);
	}
	@Override
	public List<ChatVO> getMessagesToUpdate(String msg_room) {
		return myDao.getMessagesToUpdate(msg_room);
	}

}