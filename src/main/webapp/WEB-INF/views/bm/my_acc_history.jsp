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
      <div class="grid_row grid_row_content"><img src="http://via.placeholder.com/120x60" alt="camping-img"></div>
      <div class="grid_row grid_row_content">캠핑장</div>
      <div class="grid_row grid_row_content">2020-02-20</div>
      <div class="grid_row grid_row_content">1</div>
      <div class="grid_row grid_row_content">동행중</div>
    </div>
    <div class="paging">
      <a><span class="paging_list paging_prev"><</span></a>
      <a class="paging-link"><span class="paging_list paging_num">1</span></a>
      <a><span class="paging_list paging_next">></span></a>
    </div>
  </div>
</body>
</html>