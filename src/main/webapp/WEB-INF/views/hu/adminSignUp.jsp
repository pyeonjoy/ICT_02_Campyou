<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>회원가입</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="${path}/resources/public/css/hu/member.css">
<script type="text/javascript">
	function isValidEmail(email) {
		const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
	    return emailPattern.test(email);
	}
	function isValidPhoneNumber(phone) {
		const phonePattern = /^\d{3}-\d{4}-\d{4}$/;
	    return phonePattern.test(phone);
	}
	function isValidDateOfBirth(dob) {
		const dobPattern = /^\d{4}-\d{2}-\d{2}$/;
        return dobPattern.test(dob);
	}
	function admin_save_go(f) {
		event.preventDefault();
		const admin_id = f.admin_id.value.trim();
		const admin_pwd = f.admin_pwd.value.trim();
		const admin_pwdCheck = f.admin_pwdCheck.value.trim();
		const admin_name = f.admin_name.value.trim();
		const admin_nickname = f.admin_nickname.value.trim();
		const admin_phone = f.admin_phone.value.trim();
		const admin_email = f.admin_email.value.trim();

        if (admin_id === "" || admin_pwd === "" || admin_pwdCheck === "" || admin_name === "" || admin_nickname === "" || admin_phone === "" || admin_email === "") {
            alert("모든 필수 항목을 입력하세요.");
            return false; 
        }
        if (admin_id.length < 4) {
            alert("최소 4자 이상이어야 합니다.");
            return false;
        }
        if (admin_pwd !== admin_pwdCheck) {
            alert("비밀번호가 일치하지 않습니다.");
            return false; 
        }      
        if (!isValidPhoneNumber(admin_phone)) {
            alert("올바른 전화번호를 입력하세요. (예: xxx-xxxx-xxxx)");
            return false;
        }  
        if (!isValidEmail(admin_email)) {
            alert("올바른 이메일 주소를 입력하세요.");
            return false;
        } 
		f.action="admin_sign_up_go.do";
		f.submit();
	}
</script>
<script type="text/javascript">
//name double check
$(document).ready(function() {
	$("#admin_id").keyup(function() {
		$.ajax({
			url: "getAdminIdChk.do",
			data : "admin_id="+$("#admin_id").val(),
			method : "post", 
			dataType: "text",
			success : function(data) {
				if(data == '1'){
					// 사용가능
					$("#m_id").removeAttr("disabled");
					$("#idSpan").text("(사용가능한 아이디 입니다)");
				}else if(data == '0'){
					// 사용불가능
					$("#m_id").attr("disabled","disabled");
					$("#idSpan").text("(중복된 아이디 입니다)");
				}
				//중복된 이름과 별명이 하나라도 있으면 회원가입 비활성화 코드!
				checkSignUpButton();
			},
			error : function() {
				alert("읽기실패");
			}
		});
	});
	//중복된 이름과 별명이 하나라도 있으면 회원가입 비활성화 코드
	function checkSignUpButton() {
       if ($("#idSpan").text() === "(중복된 아이디 입니다)" || $("#nickNameSpan").text() === "(중복된 별명 입니다)") {
           $("#m_id").attr("disabled", "disabled");
       } else {
           $("#m_id").removeAttr("disabled");
       }
   }
});
</script> 
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<section class="vh-100 bg-image" style="background-image: url('https://img.kr.news.samsung.com/kr/wp-content/uploads/2014/10/043.jpg');">
  <div class="mask d-flex align-items-center h-100 gradient-custom-3">
    <div class="container h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-12 col-md-9 col-lg-7 col-xl-6">
          <div class="card" style="border-radius: 15px;">
            <div class="card-body p-5">
              <h2 class="text-uppercase text-center mb-5">관리자 생성</h2>
	              <form>
		               	<div class="form-outline mb-2">
		               	  <label class="form-label" for="admin_id">아이디<sup>*</sup></label> &nbsp; <span id="idSpan"></span>
		                  <input type="text" id="admin_id" name="admin_id" class="form-control form-control-lg"/>
		                </div>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="admin_pwd">비밀번호<sup>*</sup></label>
		                  <input type="password" id="admin_pwd" name="admin_pwd" class="form-control form-control-lg" />
		                </div>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="admin_pwdCheck">비밀번호 확인<sup>*</sup></label>
		                  <input type="password" id="admin_pwdCheck" name="admin_pwdCheck" class="form-control form-control-lg" />
		                </div>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="admin_name">이름<sup>*</sup></label>
		                  <input type="text" id="admin_name" name="admin_name" class="form-control form-control-lg" />
		                </div> 
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="admin_nickname">별명<sup>*</sup></label> &nbsp; <span id="nickNameSpan"></span>
		                  <input type="text" id="admin_nickname" name="admin_nickname" class="form-control form-control-lg" />
		                </div>
		                <div class="form-outline mb-2">
						  <label class="form-label" for="admin_phone">전화번호<sup>*</sup></label>
		                  <input type="text" id="admin_phone" name="admin_phone" class="form-control form-control-lg"/>
		                </div>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="admin_email">이메일<sup>*</sup></label>
		                  <input type="email" id="admin_email" name="admin_email" class="form-control form-control-lg"/>
		                </div>   
		                <div class="d-flex justify-content-center">
		                  <button type="submit" id="m_id" class="btn btn-success btn-block btn-lg gradient-custom-4 text-body" onclick="admin_save_go(this.form)" >생성</button>
		                </div>
		                <p class="text-center text-muted mt-5 mb-0"><a href="admin_login_form.do"class="fw-bold text-body"><u>관리자 로그인</u></a></p>
	              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
</body>
</html>