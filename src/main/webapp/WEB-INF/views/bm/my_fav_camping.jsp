<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심캠핑장</title>
<link rel="stylesheet" href="${path}/resources/public/css/bm/my_fav_camping.css">
 <link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
 <script defer src="${path}/resources/public/js/bm/fav_camping.js"></script>
</head>
<body>
	<%@ include file="../hs/mypage_menu.jsp"%>
	
 <div class="mypage">
      <h2 class="my_camping"> 관심 캠핑장 </h2>

    <div class="camping_container"> 
    <c:choose>
		<c:when test="${empty camps }">
			<h4 class="nolist">관심캠핑장이 없습니다.</h4>
		</c:when>
		<c:otherwise>
			<c:forEach var="list" items="${camps}"> 
      <div class="accompany_list">       
          <div class="list_summery">
            <p class="list_addr1">${list.donm} ${list.sigungunm}</p>
            <c:set var="addressParts" value="${fn:split(list.addr1, ' ')}" /> 
            <p class="list_rest_addr">${addressParts[2]} ${addressParts[3]} ${addressParts[4]}</p> 
          </div>
          <div class="list_item">
              <img src="${list.firstimageurl }" alt="camping_img" class="camping_img">
              <div class="list_type">${list.induty}</div>
              <div class="list_text_overlay">
                  <h4 class="list_name">${list.facltnm}</h4>
                  <p class="list_content">${list.tel}</p>
              </div>
          </div>
    
         
            <button class="btn btn-accept" onclick="goToHomepage('${list.homepage}')">홈페이지</button>
     
      </div>
     	 </c:forEach>
		</c:otherwise>
		</c:choose>
    </div>
  </div>
</body>
</html>