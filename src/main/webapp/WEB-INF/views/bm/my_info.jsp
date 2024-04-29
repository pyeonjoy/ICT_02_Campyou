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
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>
  <script>
  function readURL(input) {
	  if (input.files && input.files[0]) {
	   var reader = new FileReader();
	   
	   reader.onload = function (e) {
	    $('#image_section').attr('src', e.target.result);  
	   }
	   
	   reader.readAsDataURL(input.files[0]);
	   }
	 }
	  
  $(document).ready(function() {
      // 파일 선택(input 변경) 이벤트 핸들러를 바인딩
      $("#imgInput").change(function(){
          readURL(this);
      });
  });
  function handle_pwd(){
	  window.location.href = "my_change_pw.do";
  }
  
  function handle_info(){
	  window.location.href = "my_change_pw.do";
  }
  </script>
</head>
<body>
   <h3 class="my_title">마이페이지</h3>
  <form class="user_info">
    <div class="user_img_container">
      <div class="user_img">
        <img src="http://via.placeholder.com/100x100" alt="user_img">
      </div>
      <div class="file-container">
        <label for="user_img" class="btn btn_imgchg">변경</label> <input type="file" class="file hidden">
      </div>
    </div>
    <div class="user_info_container">
      <div class="detail name_detail">
        <label for="name" >이름</label><input type="text" id='name' name="name"  class="input input_name" disabled value="">
      </div>
      <div class="detail id_detail">
        <label for="id" >아이디</label> <input type="text" id="id" name="id" class="input input_id" disabled value="">
      </div>
      <div class="detail pw_detail">
        <label for="pw" >비밀번호</label> <input type="password" id="pw" name="pw" class="input input_pw" value="">
      </div>
      <button class="btn btn-check">확인</button>
      <div class="detail nickname_detail">
        <label for="nickname" >닉네임</label><input type="text" id=='nickname' name="nickname"  class="input input_nickname" value="">
      </div>
      <div class="detail phone_detail">
        <label for="phone" >전화번호</label><input type="phone" id='phone' name="phone"  class="input input_phone" value="">
      </div>
      <div class="detail email_detail">
        <label for="email" >이메일</label><input type="email" id='email' name="email"  class="input input_email" value="">
      </div>
      <div class="btn_container">
        <button class="btn btn_change">수정</button>
        <button class="btn btn_pwdreset">비밀번호 변경</button>
      </div>
    </div>
  </form>
</body>
</html>