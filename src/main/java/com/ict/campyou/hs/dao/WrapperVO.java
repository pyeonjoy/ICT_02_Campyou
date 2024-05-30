package com.ict.campyou.hs.dao;

import com.ict.campyou.hu.dao.MemberVO;

public class WrapperVO {
	private MemberVO mvo;
	private boolean sameMember;

	// Constructors
	public WrapperVO() {}

	public WrapperVO(MemberVO mvo, boolean sameMember) {
	        this.mvo = mvo;
	        this.sameMember = sameMember;
	    }

	// Getters and Setters
	public MemberVO getMember() {
		return mvo;
	}

	public void setMember(MemberVO mvo) {
		this.mvo = mvo;
	}

	public boolean getSameMember() {
		return sameMember;
	}

	public void setSameMember(boolean sameMember) {
		this.sameMember = sameMember;
	}
}
