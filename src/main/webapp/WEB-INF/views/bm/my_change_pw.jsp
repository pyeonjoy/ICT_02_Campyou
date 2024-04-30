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
        form.submit();
        form.action("pwd_change.do");
      }
    </script>
</head>
<body>
<<<<<<< HEAD
 <form class="password">
      <h3 class="password_title">비밀번호 변경</h3>
      <div class="pwd_container">
        <label for="pwd">비밀번호</label
        ><input type="password" name="pwd" class="input_pwd" id="pwd" />
      </div>
      <div class="pwd_container">
        <label for="pwd_check">비밀번호 확인</label
        ><input
          type="password"
          name="pwd_check"
          class="input_pwd"
          id="pwd_check"
        />
      </div>

      <div class="btn_container">
        <button class="btn btn_change" onclick="handlePwChange(event, form)">
          변경
        </button>
        <button class="btn btn_back">뒤로가기</button>
      </div>
    </form>
=======
<div class="password">
    <h3 class="password_title">비밀번호 변경</h3>
    <div class="pwd_container">
      <label for="pwd" >비밀번호</label><input type="password" name="pwd"  class="input_pwd">
    </div>
    <div class="pwd_container">
      <label for="pwd_check" >비밀번호 확인</label><input type="password" name="pwd_check" class="input_pwd">
    </div>
    <div class="btn_container">
      <button class="btn btn_change">변경</button>
      <button class="btn btn_back">뒤로가기</button>
    </div>
  </div>
>>>>>>> 34666877002463d506047ba34adbbe45a5270551
</body>
</html>
