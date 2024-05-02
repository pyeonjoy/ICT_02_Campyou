<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/public/css/bm/grid.css">
<title>1:1문의내역</title>
</head>
<body>
<header>
<%@ include file="../hs/header.jsp"%>
</header>
  <div class="grid_container">
<h3 class="grid_title">1:1문의 내역</h3>
    <div class="grid_col grid_header">
      <div class="grid_row grid_row1">번호</div>
      <div class="grid_row grid_row2">제목</div>
      <div class="grid_row grid_row3">닉네임</div>
      <div class="grid_row grid_row4">날짜</div>
      <div class="grid_row grid_row5">상태</div>
    </div>
    <div class="grid_col grid_content">
      <div class="grid_row grid_row_content">1</div>
      <div class="grid_row grid_row_content">아이디변경하고싶어요</div>
      <div class="grid_row grid_row_content">둘리</div>
      <div class="grid_row grid_row_content">2020-02-20</div>
      <div class="grid_row grid_row_content">완료</div>
    </div>
    <div class="grid_last_row">
      <div class="paging">
        <a><span class="paging_list paging_prev"><</span></a>
        <a class="paging-link"><span class="paging_list paging_num">1</span></a>
        <a><span class="paging_list paging_next">></span></a>
      </div>
      <button class="btn btn-inquiry">문의글 작성하기</button>

    </div>
  </div>
</body>
</html>