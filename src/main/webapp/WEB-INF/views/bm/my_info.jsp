<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
  <link rel="stylesheet" href="${path}/resources/public/css/bm/my_info.css">
  <script defer src="${path}/resources/public/js/bm/my_info.js"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>
  <script>
  function readURL(input) {
	  if (input.files && input.files[0]) {
	   const reader = new FileReader();
	   
	   reader.onload = function (e) {
	    $('#image_section').attr('src', e.target.result);  
	   }	   
	   reader.readAsDataURL(input.files[0]);
	   }
	 }
	  
  $(document).ready(function() {
      $("#imgInput").change(function(){
          readURL(this);
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
	        <img src="http://via.placeholder.com/100x100" alt="user_img">
	      </div>
	    </c:when>
	    
	    <c:otherwise>	
	      <div class="user_img">
	        <img src="${path}/resources/uploadUser_img/${mvo.member_img}" alt="user_img">
	      </div>
	     </c:otherwise>
	      <div class="file-container">
	        <label for="user_img" class="btn btn_imgchg">변경</label> <input type="file" class="file hidden" id="user_img">
	      </div>
      </c:choose>
    </div>
    <div class="user_info_container">
      <div class="detail name_detail">
        <label for="name" >이름</label><input type="text" id="name" name="name"  class="input input_name" disabled value="${mvo.member_name }">
      </div>
      <div class="detail id_detail">
        <label for="id" >아이디</label> <input type="text" id="id" name="id" class="input input_id" disabled value="${mvo.member_id }">
      </div>
      <div class="detail pw_detail">
        <label for="password" >비밀번호</label> <input type="password" id="password" name="password" class="input input_pw" >
      </div>
      <button class="btn btn-check">확인</button>
      <div class="detail nickname_detail">
        <label for="nickname" >닉네임</label><input type="text" id="nickname" name="nickname"  class="input input_nickname" value="${mvo.member_nickname }">
      </div>
      <div class="detail phone_detail">
        <label for="phone" >전화번호</label><input type="text" id="phone" name="phone"  class="input input_phone" value="${mvo.member_phone}">
      </div>
      <div class="detail email_detail">
        <label for="email" >이메일</label><input type="email" id="email" name="email"  class="input input_email" value="${mvo.member_email}">
      </div>
      <div class="btn_container">
        <input type="hidden" id="memberIdx" name="memberIdx" value="${mvo.member_idx}">
        <button class="btn btn_change" onclick="handleChangeInfo(f)">저장</button>
        <button class="btn btn_pwdreset" onclick="handle_pwd(${mvo.member_idx})">비밀번호 변경</button>
      </div>
    </div>
     <a href="deleteMember.do" class="btn btn-userDelete">회원탈퇴</a>
  </form>
</body>
</html>