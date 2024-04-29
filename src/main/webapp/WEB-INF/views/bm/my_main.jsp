<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
                    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/public/css/bm/my_main.css">
<title>마이페이지</title>
</head>
<body>
<div class="body_mypage">
  <div class="mypage">
    
    <div class="welcome">         
          <img src="http://via.placeholder.com/65x65" alt="user_img" class="user_img">
    
      <h2 class="welcome_user"> {name} 환영합니다. </h2>
    </div>

    <div class="accompany_container">
      <div class="accompany_list">
        <div class="list_header">          
          <img src="http://via.placeholder.com/40x40" alt="user_img" class="user_img">
          <div class="list_summery">
            <p class="list_date">캠핑 기간 {04/25 ~ 04/28}</p>
            <p class="list_place">{오션캠핑장}</p>
          </div>
        </div>
        <div class="list_image">
          <img src="http://via.placeholder.com/180x120" alt="camping_img" class="camping_img">
          <div class="list_type type_yellow">{카라반}</div>
        </div>
        <h4 class="list_title">{같이 가실분}</h4>
        <p class="list_content">{같이 가실분 같이 가실분 같이 가실분 같이 가실분}</p>
      </div> 
      <img src="${path}/resources/img/right.png" alt="arrow-left" class="arrow arrow-left">
       <img src="${path}/resources/img/right.png" class="arrow arrow-right">    
    </div>

    <div class="list_container">
    <div class="my_list my_board_list">
      <h4 class="my_title">내가 쓴 글</h4>
      <span class="more_list">+</span>
      <div class="my_list_summery">
        <p class="my_list_title">제목: {3월중으로 여행 가실분 }</p>
      </div>
    </div>
    <div class="my_list my_camping_list">
      <h4 class="my_title">관심 캠핑장</h4>
       <span class="more_list">+</span>
      <div class="my_list_summery">
        <p class="my_list_camping">{ 오토 캠핑장 }</p>
      </div>
    </div>
    </div>
  </div>
  </div>
</body>
</html>