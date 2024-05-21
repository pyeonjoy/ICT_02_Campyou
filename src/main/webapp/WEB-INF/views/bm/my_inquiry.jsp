<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${path}/resources/public/css/bm/inquiry_form.css">
  <link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
  <script defer src="${path}/resources/public/js/bm/my_menu.js"></script>
  <script>
      function handleModi(qna_idx) {
    	  window.location.href = "QnaUpdateForm.do?qna_idx=" + qna_idx;
      }
    </script>
</head>
<body>

	<%@ include file="../hs/mypage_menu.jsp"%>

 <div class="form_container">
   <h1 class="inquiry_title">1:1문의</h1>
      <div class="form_inquiry">
        <div class="title_box">${qvo.qna_title}</div>
        <div class="text_area summernote" >
          ${qvo.qna_content}
        </div>
          <div class="form_btn">
            <input
              type="hidden"
              id="memberIdx"
              name="member_idx"
              value="${qvo.member_idx}"
            />
        
            <button class="btn btn-modi" onclick="handleModi(${qvo.qna_idx})">
              수정
            </button>
       		 <button class="btn btn-cancel" onclick="history.back()">취소</button>
    		</div>
  </div>
  </div>
    <%@ include file="../hs/footer.jsp"%>
</body>
</html>
