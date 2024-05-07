<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/public/css/bm/my_main.css">
  <link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
  <script defer src="${path}/resources/public/js/bm/my_menu.js"></script>
<title>마이페이지</title>
<script>
function handleMyBoardList(member_idx){
	href.location="my_acc_history.do?member_idx"+member_idx;
}

function handleMyFavList(member_idx){
	
}
</script>
</head>
<body>
		<%@ include file="../hs/mypage_menu.jsp"%>
		  <input
              type="hidden"
              id="memberIdx"
              name="member_idx"
              value="${mvo.member_idx}"
            />
   
  <div class="mypage">   
    <div class="welcome"> 
     <div class="user_img">   
     <c:choose>
	    <c:when test="${empty mvo.member_img}"> 
	    <img src="${path}/resources/img/cat.png" alt="user_img" class="user_img"> 
	    </c:when>	    
	    <c:otherwise>   
          <img src="${path}/resources/uploadUser_img/${mvo.member_img}" alt="user_img" class="user_img">
     </c:otherwise>
     </c:choose>  
     </div>
      <h2 class="welcome_user"> ${mvo.member_name}님, 환영합니다. </h2>
    </div>
    <div class="accompany_container">
     
      <div class="accompany_list">
        <div class="list_header">          
          <img src="http://via.placeholder.com/40x40" alt="user_img" class="otheruser_img">
          <div class="list_summery">
            <p class="list_nickname">user nickname</p>
            <p class="list_go">같이가고싶어요!</p>
          </div>
        </div>

   <div class="list_item">
    <div class="list_image_container">
        <img src="http://via.placeholder.com/180x120" alt="camping_img" class="camping_img">
        <div class="list_type type_yellow">{카라반}</div>
        <div class="list_text_overlay">
            <h4 class="list_title">캠핑 기간 {04/25 ~ 04/28}</h4>
            <p class="list_content">{오션캠핑장}</p>
        </div>
    </div>
</div>
   
<div class="btn-container">
<button class="btn btn-accept">수락</button>
<button class="btn btn-decline">거절</button>

</div>
  </div>
       <img src="${path}/resources/img/right.png" alt="arrow-left" class="arrow arrow-left">
       <img src="${path}/resources/img/right.png" alt="arrow-right" class="arrow arrow-right">    
    </div>

    <div class="list_container">
    <div class="my_list my_board_list">
      <h4 class="my_title">내가 쓴 글</h4>
      <button class="more_list" onclick="handleMyBoardList(${mvo.member_idx})">+</button>
      <div class="my_list_summery">
    
    <c:choose>
    <c:when test="${empty list }">
     <h4 class="nolist"> 작성 내역이 없습니다. </h4> 
    </c:when>
			<c:otherwise>
				<c:forEach var="list" items="${list }">
       <a href="togetherDetail.do?t_idx="${t_idx}><p class="my_list_title">{list.t_subject}</p></a> 
        </c:forEach>
			</c:otherwise>
	</c:choose>
      </div>
    </div>
    <div class="my_list my_camping_list">
      <h4 class="my_title">관심 캠핑장</h4>
       <button class="more_list" onclick="handleMyFavList(${mvo.member_idx})">+</button>
      <div class="my_list_summery">
        <p class="my_list_camping">{ 오토 캠핑장 }</p>
      </div>
    </div>
    </div>
  </div>

</body>
</html>