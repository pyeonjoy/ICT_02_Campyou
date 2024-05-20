<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>관리자 로그인</title>
<%@ include file="../hs/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${path}/resources/public/css/hu/member.css">
<!-- <script type="text/javascript">
$(document).ready(function() {
    $("#member_id").keyup(function() {
        $.ajax({
            url: "getLogInIdChk.do",
            data : "member_id="+$("#member_id").val(),
            method : "post", 
            dataType: "text",
            success : function(data) {
                if(data == '0'){
                    // 존재하는 아이디
                    $("#m_id").removeAttr("disabled");
                    $("#idSpanLogIn").text("");
                    // 버튼 색상 변경
                    $("#m_id").removeClass("btn-secondary").addClass("btn-primary");
                } else if(data == '1'){
                    // 존재하지 않는 아이디
                    $("#m_id").attr("disabled","disabled");
                    $("#idSpanLogIn").text("");
                    // 버튼 색상 변경
                    $("#m_id").removeClass("btn-primary").addClass("btn-primary");
                }
            },
            error : function() {
                alert("읽기실패");
            }
        });
    });
});
</script>  -->

<!-- <script type="text/javascript">
	$(document).ready(function() {
		let pwdchk = "${pwdchk}";
		if(pwdchk.trim() === 'fail'){
			console.log("Password check failed.");
			alert("비밀번호틀림");
			return;
		}
	});
</script>  -->


<!-- <script type="text/javascript">
$(document).ready(function() {
    $("#member_id").keyup(function() {
        $.ajax({
            url: "login_go_ok.do",
            data : "member_id="+$("#member_id").val(),
            method : "post", 
            dataType: "text",
            success : function(data) {
            
                  if ($("#member_id").val() == "admin") {
                      $("#member_id").attr("name", "admin_id");
                      $("#member_pwd").attr("name", "admin_pwd");
                  }
              } 
          },
          error : function() {
              alert("읽기실패");
          }
      });
  });
});
</script>  -->
<script type="text/javascript">
function adminLogIn(f) {
	if(f.admin_id.value === ""){
		 alert("아이디를 입력하세요.");
		 f.admin_id.focus();
		 return;
	 }
	 if(f.admin_pwd.value === ""){
		 alert("패스워드 확인를 입력하세요.");
		 f.admin_pwd.focus();
		 return;
	 }
	f.action="admin_login_go_ok.do";
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
            <h3 class="mb-5">관리자 로그인</h3>
			<form>
				<div data-mdb-input-init class="form-outline mb-4">
	              <input type="text" id="admin_id" name="admin_id" class="form-control form-control-lg" /><br>
	              <label class="form-label" for="admin_id"><b>아이디</b></label>&nbsp;<span id="idSpanLogIn"></span>
	            </div>
	            <div data-mdb-input-init class="form-outline mb-4">
	              <input type="password" id="admin_pwd" name="admin_pwd" class="form-control form-control-lg" /><br>
	              <label class="form-label" for="admin_pwd"><b>비밀번호</b></label>
	            </div>
	            <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block" type="submit" id="m_id" onclick="adminLogIn(this.form)">로그인</button>
	            <br><br>
	            <hr class="my-4">  
			</form>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>