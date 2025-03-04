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
     <script defer src="${path}/resources/public/js/bm/my_menu.js"></script>
<title>동행내역</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
</head>
<body>

		<%@ include file="../hs/mypage_menu.jsp"%>
		<!-- 
 board_idx, member_idx, b_subject, b_regdate, board_type

		 -->
		 <div class="inquiry">
 <h3 class="grid_title">내가 작성한 글</h3>
  <div class="grid_container">
    <div class="grid_table">
    <div class="grid_col2 grid_header">
      <div class="grid_row grid_row1">번호</div>
      <div class="grid_row grid_row2">게시판</div>
      <div class="grid_row grid_row3">제목</div>
      <div class="grid_row grid_row4">날짜</div>
      <div class="grid_row grid_row5">조회수</div>
    </div>    
    <div class="grid_col2 grid_content">
    
     <c:choose>
    <c:when test="${empty list }">
     <h3 class="nolist"> 작성한 글이 없습니다. </h3> 
    </c:when>
			<c:otherwise>
				<c:forEach var="list" items="${list }" varStatus="vs">
       <div class="grid_row grid_row_content">${paging.totalRecord - ((paging.nowPage-1)* paging.numPerPage + vs.index)}</div> 
      <div class="grid_row grid_row_content">
       <c:choose>
       <c:when test="${list.board_type==1}"> 자유게시판</c:when>
       <c:otherwise> 캠핑제품추천 </c:otherwise>
       </c:choose>
      </div>
      <div class="grid_row grid_row_content"><a href="boardDetail.do?board_idx=${list.board_idx}&board_type=${list.board_type}">${list.b_subject }</a></div>
      <div class="grid_row grid_row_content">${list.b_regdate.substring(0,10) }</div>
      <div class="grid_row grid_row_content">${list.hit }</div>
      				</c:forEach>
			</c:otherwise>
	</c:choose>
    </div>
    </div>
    <div class="paging">
    	<c:choose>
			<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
			<li class ="disable paging_list paging_prev">&#8249;</li>
			</c:when>
			<c:otherwise>
			<li>
			<a href="my_board.do?cPage=${paging.beginBlock-paging.pagePerBlock}" class="paging_list paging_prev">&#8249;</a>
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
				<li class="paging_list paging_num"><a href="my_board.do?cPage=${k}">${k}</a></li>
			</c:otherwise>
			</c:choose>
		</c:forEach>
    
		<c:choose>
			<c:when test="${paging.endBlock >= paging.totalPage }">
			<li class = "disable paging_list paging_next">&#8250;</li>
			</c:when>
			<c:otherwise>
			<li>
			<a href="my_board.do?cPage=${paging.beginBlock+paging.pagePerBlock}" class="paging_list paging_next">&#8250;</a>
			</li>
			</c:otherwise>
		</c:choose>
    </div>
  </div>
  </div>
    <%@ include file="../hs/footer.jsp"%>
</body>
</html>