package com.ict.campyou.bm.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.hu.dao.BoardFreeVO;
import com.ict.campyou.hu.dao.CampingGearBoardVO;
import com.ict.campyou.hu.dao.CommBoardVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.CampVO;
import com.ict.campyou.jun.dao.HeartVO;
import com.ict.campyou.jun.dao.ReviewVO;

@Repository
public class MyDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<FaqVO> getFaqs() {
		try {
			return sqlSessionTemplate.selectList("bomi.faq_lists");
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public List<FaqVO> getFaqs2() {
		try {
			return sqlSessionTemplate.selectList("bomi.faq_lists2");
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public MemberVO getMemberPwd(String memberId) {
		try {
			return sqlSessionTemplate.selectOne("bomi.getPw", memberId);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public MemberVO getMember(String member_idx) {
		try {

			return sqlSessionTemplate.selectOne("bomi.getUser", member_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public int changeUserInfo(MemberVO mvo) {
		try {

			return sqlSessionTemplate.update("bomi.updateUser", mvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	public int deletMember(MemberVO mvo) {
		try {
			return sqlSessionTemplate.delete("bomi.getDeleteUser", mvo);

		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	public int changeUserPW(MemberVO mvo) {
		try {
			return sqlSessionTemplate.update("bomi.updatePw", mvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public List<ReviewVO> getReviewList(String member_idx) {
		try {
			
			return sqlSessionTemplate.selectList("bomi.getReviews",member_idx);
		} catch (Exception e) {
			System.out.println(e);
	}
		return null;
	}
	
	public int uploadQna(QnaVO qvo) {
		try {
			System.out.println("dao: " + qvo.getMember_idx());
			return sqlSessionTemplate.insert("bomi.upQna", qvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;

	}

	public int updateQna(QnaVO qvo) {
		try {
			return sqlSessionTemplate.update("bomi.modiQna", qvo);

		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	public List<QnaVO> getMyQna(String member_idx, int offset, int limit) {
		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("member_idx", member_idx);
			map.put("offset", offset);
			map.put("limit", limit);
			return sqlSessionTemplate.selectList("bomi.getQnas", map);

		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public int getTotalCount(String member_idx) {

		return sqlSessionTemplate.selectOne("bomi.count", member_idx);
	}

	public QnaVO getMyOneQna(String qna_idx) {
		try {

			return sqlSessionTemplate.selectOne("bomi.getOne", qna_idx);

		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public List<TogetherVO> getMyAcc_List(String member_idx, int offset, int limit) {
		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("member_idx", member_idx);
			map.put("offset", offset);
			map.put("limit", limit);
			return sqlSessionTemplate.selectList("bomi.getList", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public int addChatMsg(ChatVO chvo) {
		try {
			return sqlSessionTemplate.insert("bomi.addChat", chvo);
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	public List<ChatVO> getChatList(String member_idx) {
	    try {
	        List<ChatVO> chatList = new ArrayList<>();
	        Set<String> uniqueRooms = new HashSet<>();

	        List<ChatVO> allRooms = sqlSessionTemplate.selectList("bomi.getRooms", member_idx);
	        for (ChatVO room : allRooms) {
	            uniqueRooms.add(room.getMsg_room());
	        }

	        for (String room : uniqueRooms) {
	            ChatVO maxMsgIdxRoom = sqlSessionTemplate.selectOne("bomi.getMaxMsgIdxRoom", room);
	            if (maxMsgIdxRoom != null) {
	                chatList.add(maxMsgIdxRoom);
	            }
	        }

	        return chatList; 

	    } catch (Exception e) {
	        System.out.println(e);
	        return null; 
	    }
	}


	public List<ChatVO> getOneRoom(String msg_room) {
		try {
			return sqlSessionTemplate.selectList("bomi.getRoom", msg_room);			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public int updateMsgRead(String msg_idx) {
		try {
			return sqlSessionTemplate.update("bomi.msgRead", msg_idx);
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	public List<HeartVO> getFavList(String member_idx) {
		try {
			return sqlSessionTemplate.selectList("bomi.getFavList",member_idx);
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public List<CommBoardVO> getBoard1(String member_idx) {
		try {
			return sqlSessionTemplate.selectList("bomi.getBoard1", member_idx);
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public List<CampingGearBoardVO> getBoard2(String member_idx) {
		try {
			return sqlSessionTemplate.selectList("bomi.getBoard2",member_idx);
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	public CampVO getMyFavoriteCamp(String contentid) {
		try {
			return sqlSessionTemplate.selectOne("bomi.getCampDetail",contentid);
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public CommBoardVO getBoard1ByIdx(String board_idx) {
		try {
			
			return sqlSessionTemplate.selectOne("bomi.getBoard1ByIdx", board_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public CampingGearBoardVO getBoard2ByIdx(String board_idx) {	
		try {
			
			return sqlSessionTemplate.selectOne("bomi.getBoard2ByIdx", board_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
}