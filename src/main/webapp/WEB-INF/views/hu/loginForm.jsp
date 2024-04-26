<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function logIn(f) {
	const memberId = document.getElementById("member_id").value;
	const memberPwd = document.getElementById("member_pwd").value;

    if(memberId.trim() === "" || memberPwd.trim() === "") {
        alert("아이디와 비밀번호를 입력하세요.");
        return false; 
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
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
   <section class="vh-100" style="background-color: #508bfc;">
   <section class="vh-100 bg-image" style="background-image: url('https://a.cdn-hotels.com/gdcs/production68/d64/b63a25ae-248e-4ca0-823d-381fa7156982.jpg');">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12 col-md-8 col-lg-6 col-xl-5">
        <div class="card shadow-2-strong" style="border-radius: 1rem;">
          <div class="card-body p-5 text-center">
            <h3 class="mb-5">로그인</h3>
			<form>
	            <div data-mdb-input-init class="form-outline mb-4">
	              <input type="text" id="member_id" name="member_id" class="form-control form-control-lg" />
	              <label class="form-label" for="member_id">아이디</label>
	            </div>
	            <div data-mdb-input-init class="form-outline mb-4">
	              <input type="password" id="member_pwd" name="member_pwd" class="form-control form-control-lg" />
	              <label class="form-label" for="member_pwd">비밀번호</label>
	            </div>
				
	            <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block" type="submit" onclick="logIn(this.form)">로그인</button>
	            
	            <br><br>
	            <p class="small mb-5 pb-lg-2"><a class="text-muted" href="find_pwd_go.do">비밀번호 찾기</a> &nbsp;
	           	<a class="text-muted" href="find_id_go.do">아이디 찾기</a></p>
	            <hr class="my-4">
	            <button data-mdb-button-init data-mdb-ripple-init class="btn btn-lg btn-block" type="submit" onclick="kakaoLogIn(this.form)"><img src="${path}/resources/img/kakao_login_medium_narrow.png"/></button>
	            <button data-mdb-button-init data-mdb-ripple-init class="btn btn-lg btn-block" type="submit" onclick="naverLogIn(this.form)"><img src="${path}/resources/img/btnG.png" /></button>
			</form>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
</body>
</html>