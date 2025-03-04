package com.ict.campyou.hu.sns.naver;

public class NaverVO {
	private String access_token, token_type,refresh_token;

	public NaverVO(String access_token, String token_type, String refresh_token) {
		this.access_token = access_token;
		this.token_type = token_type;
		this.refresh_token = refresh_token;
	}

	public String getAccess_token() {
		return access_token;
	}

	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}

	public String getToken_type() {
		return token_type;
	}

	public void setToken_type(String token_type) {
		this.token_type = token_type;
	}

	public String getRefresh_token() {
		return refresh_token;
	}

	public void setRefresh_token(String refresh_token) {
		this.refresh_token = refresh_token;
	}
}
