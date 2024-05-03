package com.ict.campyou.hu.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommentReplyDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public CommentVO getCommentReplyDetail(String b_idx) {
		try {
			return sqlSessionTemplate.selectOne("member.comment_reply_list", b_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public int getLevUpdate(Map<String, Integer> map) {
		try {
			return sqlSessionTemplate.update("member.lev_update", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	public int getAnsInsert(CommentVO cvo3) {
		try {
			return sqlSessionTemplate.insert("member.ans_insert", cvo3);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	public int getCommentReplyInsert(CommentVO cvo) {
		
		return sqlSessionTemplate.insert("member.comment_reply_insert", cvo);
	}
}
