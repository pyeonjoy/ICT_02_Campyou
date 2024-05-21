<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<%@ include file="../hs/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${path}/resources/public/css/hu/member.css">
<script type="text/javascript">
function logIn(f) {
	if(f.member_id.value === ""){
		 alert("아이디를 입력하세요.");
		 f.member_id.focus();
		 return;
	 }
	 if(f.member_pwd.value === ""){
		 alert("패스워드 확인를 입력하세요.");
		 f.member_pwd.focus();
		 return;
	 }
	f.action="login_go_ok.do";
	f.submit();
}
function kakaoLogIn() {
	alert("Coming Soon!!")
}
function naverLogIn() {
	alert("Coming Soon!!")
}
</script>
<style>
.bg-image {
  background-repeat: no-repeat;
  background-size: cover; /* 배경 이미지를 화면에 꽉 차게 설정 */
}
#a-color{
	color: white;
}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
   <section class="vh-100 bg-image" style="background-image: url('https://jindongri.zapza.me/upload/2021/0604/202106041622791076238010.jpg');">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12 col-md-8 col-lg-6 col-xl-5">
        <div class="card shadow-2-strong" style="border-radius: 1rem;">
          <div class="card-body p-5 text-center">
            <h3 class="mb-5">로그인</h3>
			<form>
				<div data-mdb-input-init class="form-outline mb-4">
	              <input type="text" id="member_id" name="member_id" class="form-control form-control-lg" /><br>
	              <label class="form-label" for="member_id"><b>아이디</b></label>&nbsp;<span id="idSpanLogIn"></span>
	            </div>
	            <div data-mdb-input-init class="form-outline mb-4">
	              <input type="password" id="member_pwd" name="member_pwd" class="form-control form-control-lg" /><br>
	              <label class="form-label" for="member_pwd"><b>비밀번호</b></label>
	            </div>
	            <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block" type="submit" id="m_id" onclick="logIn(this.form)">로그인</button>
	            <br><br>
	            <p class="small mb-5 pb-lg-2"><a class="text-muted" href="find_pwd_go.do">비밀번호 찾기</a> &nbsp;
	           	<a class="text-muted" href="find_id_go.do">아이디 찾기</a></p>
	           	<p class="text-center text-muted mt-5 mb-1">회원이 아니신가요?&nbsp;<a href="sign_up_page_go.do"class="fw-bold text-body">회원가입</a></p>
	            <hr class="my-4">  
			</form>
				<a id="a-color" href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=4a601447a1662d2919cfc432b342bc38&redirect_uri=http://localhost:8090/kakaologin.do">
					<img src="resources/images/kakao_login_medium_narrow.png" width="160px">
				</a>
				<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=Yg5gbW0JV9cs8cbMiejA&redirect_uri=http://localhost:8090/naverlogin.do&state=test">
				 	<img src="resources/images/btnG.png" width="160px">
				</a> 
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>