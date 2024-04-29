<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="${path}/resources/public/css/bm/change_pw.css">
<title>비밀번호 변경</title>
</head>
<body>
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
</body>
</html>
