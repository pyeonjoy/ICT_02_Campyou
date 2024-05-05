<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="${path}/resources/public/css/bm/grid.css">
   <link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
<title>동행내역</title>
</head>
<body>

		<%@ include file="../hs/mypage_menu.jsp"%>

  <div class="grid_container">
 <h3 class="grid_title">동행내역</h3>
    <div class="grid_col grid_header">
      <div class="grid_row grid_row1">이미지</div>
      <div class="grid_row grid_row2">캠핑장</div>
      <div class="grid_row grid_row3">날짜</div>
      <div class="grid_row grid_row4">동행인원</div>
      <div class="grid_row grid_row5">동행상태</div>
    </div>    
    <div class="grid_col grid_content">
    
     <c:choose>
    <c:when test="${empty list }">
     <h3 class="nolist"> 문의 내역이 없습니다. </h3> 
    </c:when>
			<c:otherwise>
				<c:forEach var="list" items="${list }">
      <div class="grid_row grid_row_content"><img src="http://via.placeholder.com/120x60" alt="camping-img"></div>
     <div class="grid_row grid_row_content">  <a href="togetherDetail.do?t_idx="${list.t_idx }>
          <p class="place place-name">${list.t_campname}</p>
          <p class="place place-address">${list.t_address }</p>
      </a>
      </div>
      <div class="grid_row grid_row_content">${list.t_regdate }</div>
      <div class="grid_row grid_row_content">${list.t_numpeople }</div>
      <div class="grid_row grid_row_content">${list.t_active }</div>
      				</c:forEach>
			</c:otherwise>
	</c:choose>
    </div>
    <div class="paging">
    <c:choose>
			<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
			<li class ="disable"><</li>
			</c:when>
			<c:otherwise>
			<li>
			<a href="qna_list.do?cPage=${paging.beginBlock-paging.pagePerBlock}"><</a>
			</li>
			</c:otherwise>
		</c:choose>
      
      <!-- 페이지번호들 -->
		<c:forEach begin="${paging.beginBlock }"
			end="${paging.endBlock }" step="1" var="k">
			<c:choose>
			<c:when test="${ k== paging.nowPage}">
				<li class="paging_list paging_num">${k }</li> 
				</c:when>
			<c:otherwise>
				<li class="paging_list paging_num"><a href="qna_list.do?cPage=${k}">${k}</a></li>
			</c:otherwise>
			</c:choose>
		</c:forEach>
 
      <!-- 이후 버튼 -->
		<c:choose>
			<c:when test="${paging.endBlock >= paging.totalPage }">
			<li class = "disable">next</li>
			</c:when>
			<c:otherwise>
			<li>
			<a href="qna_list.do?cPage=${paging.beginBlock+paging.pagePerBlock}">next</a>
			</li>
			</c:otherwise>
		</c:choose>
		
		<!--
      <a><span class="paging_list paging_prev"><</span></a>
      <a class="paging-link"><span class="paging_list paging_num">1</span></a>
      <a><span class="paging_list paging_next">></span></a>
      -->
    </div>
  </div>
</body>
</html>