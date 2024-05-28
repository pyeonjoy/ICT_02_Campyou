<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>SNS 회원가입</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="${path}/resources/public/css/hu/member.css">
<script type="text/javascript">
	// 이메일 ,아이디
	function isValidPhoneNumber(phone) {
		const phonePattern = /^\d{3}-\d{4}-\d{4}$/;
	    return phonePattern.test(phone);
	}
	function isValidDateOfBirth(dob) {
		const dobPattern = /^\d{4}-\d{2}-\d{2}$/;
        return dobPattern.test(dob);
	}
	function save_go(f) {
		event.preventDefault();
		const member_name = f.member_name.value.trim();
		const member_dob = f.member_dob.value.trim();
		const member_pwd = f.member_pwd.value.trim();
		const member_pwdCheck = f.member_pwdCheck.value.trim();
		const member_phone = f.member_phone.value.trim();

        if (member_name === ""  || member_dob === "" || member_pwd === "" || member_pwdCheck === "" || member_phone === "" || member_gender === "") {
            alert("모든 필수 항목을 입력하세요.");
            return false; 
        }
        if (member_pwd !== member_pwdCheck) {
            alert("비밀번호가 일치하지 않습니다.");
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
		f.action="sns_update.do";
		f.submit();
	}
</script>
<script type="text/javascript">
//name double check
$(document).ready(function() {
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
<br><br><br>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<section class="vh-100 bg-image" style="background-image: url('https://img.kr.news.samsung.com/kr/wp-content/uploads/2014/10/043.jpg');">
  <div class="mask d-flex align-items-center h-100 gradient-custom-3">
    <div class="container h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-12 col-md-7 col-lg-5 col-xl-5">
          <div class="card" style="border-radius: 15px;">
            <div class="card-body p-3">
              <h2 class="text-uppercase text-center mb-3">정보수정</h2>
	              <form>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="member_name">이름<sup>*</sup></label>
		                  <input type="text" id="member_name" name="member_name" class="form-control form-control-sm" />
		                </div> 
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="member_dob">생년월일<sup>*</sup></label>
		                  <input type="text" id="member_dob" name="member_dob" class="form-control form-control-sm" placeholder="예)  yyyy-mm-dd" />
		                </div>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="member_pwd">비밀번호<sup>*</sup></label>
		                  <input type="password" id="member_pwd" name="member_pwd" class="form-control form-control-sm" />
		                </div>
		                <div class="form-outline mb-2">
		                  <label class="form-label" for="member_pwdCheck">비밀번호 확인<sup>*</sup></label>
		                  <input type="password" id="member_pwdCheck" name="member_pwdCheck" class="form-control form-control-sm" />
		                </div>
						 <div class="form-outline mb-2">
						  <label class="form-label" for="member_phone">전화번호<sup>*</sup></label>
		                  <input type="text" id="member_phone" name="member_phone" class="form-control form-control-sm" placeholder="예) 010-0000-0000"/>
		                </div><br>
		                <div class="form-outline mb-2">
		                	<label class="form-label" for="member_phone">성별<sup>*</sup></label>&nbsp;&nbsp;
			                <div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="member_gender" id="member_gender" value="남" checked>
								  <label class="form-check-label" for="inlineRadio1">남</label>
							</div>
							<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="member_gender" id="member_gender" value="여">
								  <label class="form-check-label" for="inlineRadio2">여</label>
							</div>
 						</div>
		             	<div class="form-check d-flex justify-content-center mb-3">
		                  <input class="form-check-input me-2" type="checkbox" value="" id="chkbox" name="chkbox" />
		                  <label class="form-check-label" for="chkbox"> 이용약관에 동의합니다. <a href="terms_of_use_go.do" target="_blank" onclick="window.open(this.href,'targetWindow','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=700'); return false;" class="text-body"><u>이용약관</u></a></label>
		                </div> 
		                <div class="d-flex justify-content-center">
		                  <button type="submit" id="m_id" class="btn btn-success btn-block btn-sm gradient-custom-4 text-body" onclick="save_go(this.form)" >정보수정</button>
		                </div>
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