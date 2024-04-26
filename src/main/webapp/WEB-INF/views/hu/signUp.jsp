<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>회원가입</title>
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
	function save_go(f) {
		const member_id = f.member_id.value.trim();
		const member_name = f.member_name.value.trim();
		const member_nickname = f.member_nickname.value.trim();
		const member_dob = f.member_dob.value.trim();
		const member_email = f.member_email.value.trim();
		const member_pwd = f.member_pwd.value.trim();
		const member_pwdCheck = f.member_pwdCheck.value.trim();
		const member_phone = f.member_phone.value.trim();

        if (member_id === "" || member_name === "" || member_nickname === "" || member_dob === "" || member_email === "" || member_pwd === "" || member_pwdCheck === "" || member_phone === "") {
            alert("모든 필수 항목을 입력하세요.");
            return false; 
        }
        if (member_id.length < 4) {
            alert("아이디는 최소 4자 이상이어야 합니다.");
            return false;
        }
        if (member_pwd !== member_pwdCheck) {
            alert("비밀번호가 일치하지 않습니다.");
            return false; 
        }     
        if (!isValidEmail(member_email)) {
            alert("올바른 이메일 주소를 입력하세요.");
            return false;
        }  
        if (!isValidPhoneNumber(member_phone)) {
            alert("올바른 전화번호를 입력하세요. (예: xxx-xxxx-xxxx)");
            return false;
        } 
        if (!isValidDateOfBirth(member_dob)) {
            alert("올바른 생년월일을 입력하세요. (예: 1990-03-03)");
            return false;
        } 
        if (!document.getElementById('chkbox').checked) {
            alert("이용약관에 동의해주세요.");
            return false;
        }
		f.action="sign_up_go.do";
		f.submit();
	}
</script>
<script type="text/javascript">
//name double check
$(document).ready(function() {
	$("#member_id").keyup(function() {
		$.ajax({
			url: "getIdChk.do",
			data : "member_id="+$("#member_id").val(),
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
	
	$("#member_nickname").keyup(function() {
		$.ajax({
			url: "getNickNameChk.do",
			data : "member_nickname="+$("#member_nickname").val(),
			method : "post", 
			dataType: "text",
			success : function(data) {
				if(data == '1'){
					// 사용가능
					$("#m_id").removeAttr("disabled");
					$("#nickNameSpan").text("(사용가능한 별명 입니다)");
				}else if(data == '0'){
					// 사용불가능
					$("#m_id").attr("disabled","disabled");
					$("#nickNameSpan").text("(중복된 별명 입니다)");
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
              <h2 class="text-uppercase text-center mb-5">회원가입</h2>
	              <form>
		               	<div class="form-outline mb-2">
		               	  <label class="form-label" for="member_id">아이디<sup>*</sup></label> &nbsp; <span id="idSpan"></span>
		                  <input type="text" id="member_id" name="member_id" class="form-control form-control-lg" placeholder="아이디 4자이상"/>
		                </div>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="member_name">이름<sup>*</sup></label>
		                  <input type="text" id="member_name" name="member_name" class="form-control form-control-lg" />
		                </div> 
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="member_nickname">별명<sup>*</sup></label> &nbsp; <span id="nickNameSpan"></span>
		                  <input type="text" id="member_nickname" name="member_nickname" class="form-control form-control-lg" />
		                </div>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="member_dob">생년월일<sup>*</sup></label>
		                  <input type="text" id="member_dob" name="member_dob" class="form-control form-control-lg" placeholder="예)  yyyy-mm-dd" />
		                </div>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="member_email">이메일<sup>*</sup></label>
		                  <input type="email" id="member_email" name="member_email" class="form-control form-control-lg" placeholder="예) jejudo@naver.com"/>
		                </div>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="member_pwd">비밀번호<sup>*</sup></label>
		                  <input type="password" id="member_pwd" name="member_pwd" class="form-control form-control-lg" />
		                </div>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="member_pwdCheck">비밀번호 확인<sup>*</sup></label>
		                  <input type="password" id="member_pwdCheck" name="member_pwdCheck" class="form-control form-control-lg" />
		                </div>
						 <div class="form-outline mb-2">
						  <label class="form-label" for="member_phone">전화번호<sup>*</sup></label>
		                  <input type="text" id="member_phone" name="member_phone" class="form-control form-control-lg" placeholder="예) 010-0000-0000"/>
		                </div>
		             	<div class="form-check d-flex justify-content-center mb-4">
		                  <input class="form-check-input me-2" type="checkbox" value="" id="chkbox" name="chkbox" />
		                  <label class="form-check-label" for="chkbox"> 이용약관에 동의합니다. <a href="terms_of_use_go.do" target="_blank" onclick="window.open(this.href,'targetWindow','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=700'); return false;" class="text-body"><u>이용약관</u></a></label>
		                </div> 
		                <div class="d-flex justify-content-center">
		                  <button type="submit" id="m_id" class="btn btn-success btn-block btn-lg gradient-custom-4 text-body" onclick="save_go(this.form)" >회원가입</button>
		                </div>
		                <p class="text-center text-muted mt-5 mb-0">이미 회원이신가요?<a href="login_form.do"class="fw-bold text-body"><u>로그인</u></a></p>
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