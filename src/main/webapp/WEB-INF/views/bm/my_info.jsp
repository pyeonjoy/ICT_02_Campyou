<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<%@ include file="../hs/header.jsp"%>
  <link rel="stylesheet" href="${path}/resources/public/css/bm/my_info.css">
  <script defer src="${path}/resources/public/js/bm/my_info.js"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>
 <script>
      function setThumbnail(input, e) {
	  if (input.files && input.files[0]) {
	   const reader = new FileReader();
	   
	   reader.onload = function (e) {
	    $('#user_img').attr('src', e.target.result);  
	   }	   
	   reader.readAsDataURL(input.files[0]);
	   }
	 }
	  
  $(document).ready(function() {
      $("#user_img").change(function(){
    	  setThumbnail(this);
      });
  });
  </script>
</head>
<body>

   <h3 class="my_title">마이페이지</h3>
  <form class="user_info" method="post" enctype="multipart/form-data">
    <div class="user_img_container">
    <c:choose>
	    <c:when test="${empty mvo.member_img}">
	     <div class="user_img">
	        <img src="${path}/resources/img/cat.png" alt="user_img" id="user_img">
	      </div>
	    </c:when>	    
	    <c:otherwise>	
	      <div class="user_img">
	        <img src="${path}/resources/uploadUser_img/${mvo.member_img}" alt="user_img">
	      </div>
	     </c:otherwise>
      </c:choose>    
	      <div class="file-container">
	      <%--
	       <label class="btn btn_imgchg hidden">변경
        <input type="file" name="file" class="file" id="user_img" onchange="setThumbnail(this, event)">
</label> --%>
<input type="file" name="file" class="file" id="user_img" onchange="setThumbnail(this, event)">
	      </div>
    </div>
    <div class="user_info_container">
      <div class="detail name_detail">
        <label for="name" >이름</label><input type="text" id="name" name="member_name"  class="input input_name" disabled value="${mvo.member_name }">
      </div>
      <div class="detail id_detail">
        <label for="id" >아이디</label> <input type="text" id="id" name="member_id" class="input input_id" disabled value="${mvo.member_id }">
      </div>
      <div class="detail pw_detail">
        <label for="password" >비밀번호</label> <input type="password" id="password" name="member_pwd" class="input input_pw" >
      </div>
      <button class="btn btn-check" onclick="checkPassword(event)">확인</button>
      <div class="detail nickname_detail">
        <label for="nickname" >닉네임</label><input type="text" id="nickname" name="member_nickname"  class="input input_nickname" value="${mvo.member_nickname }">
      </div>
      <div class="detail phone_detail">
        <label for="phone" >전화번호</label><input type="text" id="phone" name="member_phone"  class="input input_phone" value="${mvo.member_phone}">
      </div>
      <div class="detail email_detail">
        <label for="email" >이메일</label><input type="email" id="email" name="member_email"  class="input input_email" value="${mvo.member_email}">
      </div>
      <div class="btn_container">
        <input type="hidden" id="memberIdx" name="member_idx" value="${mvo.member_idx}">
        <button class="btn btn_change" onclick="handleChangeInfo(this.form)">저장</button>
        <button class="btn btn_pwdreset" onclick="handle_pwd(${mvo.member_idx}, this.form)">비밀번호 변경</button>
      </div>
    </div>
     <a href="deleteMember.do" class="btn btn-userDelete">회원탈퇴</a>
  </form>
</body>
</html>