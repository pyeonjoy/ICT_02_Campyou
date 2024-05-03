<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
 <link rel="stylesheet" href="${path}/resources/public/css/bm/change_pw.css">
   <script>
   function handlePwChange(e, form) {
	    e.preventDefault();
	    const pwd = document.getElementById("pwd").value.trim();
	    const pwd_checkInput = document.getElementById("pwd_check");
	    const pwd_check = pwd_checkInput.value.trim();

	    if (pwd !== pwd_check) {
	        alert("비밀번호가 일치하지 않습니다.");
	        pwd_checkInput.focus();
	        return;
	    }

	    form.action = "pwd_change.do?member_idx=" + form.member_idx.value;	
	    form.submit();
	}

	function goBack() {
	    window.history.back();
	}

    </script>
</head>
<body>

 <form class="password" method="post" action="pwd_change.do">
      <h3 class="password_title">비밀번호 변경</h3>
      <div class="pwd_container">
        <label for="pwd">비밀번호</label
        ><input type="password" name="password" class="input_pwd" id="pwd" />
      </div>
      <div class="pwd_container">
        <label for="pwd_check">비밀번호 확인</label
        ><input
          type="password"
          name="pwdCheck"
          class="input_pwd"
          id="pwd_check"
        />
      </div>

      <div class="btn_container">
<input type="hidden" name="member_idx" value ="${member_idx }">
        <button type="submit" class="btn btn_change" onclick="handlePwChange(event, this.form)">
          변경
        </button>
        <button class="btn btn_back" onclick="goBack()">뒤로가기</button>
      </div>
    </form>

</body>
</html>
