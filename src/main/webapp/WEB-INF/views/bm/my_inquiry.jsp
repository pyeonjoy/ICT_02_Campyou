<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의</title>
<link rel="stylesheet" href="${path}/resources/public/css/bm/inquiry_form.css">
 <script>
      function handleModi(qna_idx) {
        href.location = "QnaUpdateForm.do?qna_idx="+qna_idx;
      }
    </script>
</head>
<body>
 <div class="form_container">
      <h1 class="inquiry_title">1:1문의</h1>
      <form class="form_inquiry" method="post" enctype="multipart/form-data">
        <div class="title_box">${qvo.qna_title}</div>
        <div class="text_area summernote" id="summernote" name="qna_content">
          ${qvo.qna_content}
        </div>
        <div class="form_bottom">
          <div class="form_btn">
            <input
              type="hidden"
              id="memberIdx"
              name="member_idx"
              value="${qvo.member_idx}"
            />
        
            <button class="btn btn-modi" type="submit" onclick="handleModi(${qvo.qna_idx})">
              수정
            </button>

            <button class="btn btn-cancel">취소</button>
          </div>
        </div>
      </form>
    </div>
</body>
</html>