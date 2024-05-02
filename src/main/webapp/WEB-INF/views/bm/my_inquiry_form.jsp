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

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script defer src="${path}/resources/public/js/bm/lang/summernote-ko-KR.js"></script>
<script defer src="${path}/resources/public/js/bm/summernote-lite.js"></script>
<script>

</script>
</head>
<body>
<header>
<%@ include file="../hs/header.jsp"%>
<%@ include file="../hs/mypage_menu.jsp"%>
</header>
 <div class="form_container">
  <h1 class="inquiry_title">1:1문의</h1>
  <form class="form_inquiry" method="post" enctype="multipart/form-data">
    <div class="title_box">
      <input type="text" placeholder="글제목" class="input_title" name="qna_title">
    </div>
    <textarea class="text_area" id="summernote" name="qna_content">
    </textarea>
    <div class="form_bottom">
      <div class="form_btn">
      <input type="hidden" name="member_idx" value="member_idx">
        <button class="btn btn-save">저장</button>
        <button class="btn btn-cancel">취소</button>
      </div>
    </div>
  </form>
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>
   <script>
    $(document).ready(function() {
    	$('#summernote').summernote({
    	    lang : 'ko-KR',
        	height : 300,
        	focus : true, 
    	    },
    	});
    });
       
    function progressHandlingFunction(e) {
        if (e.lengthComputable) {
            //Log current progress
            console.log((e.loaded / e.total * 100) + '%');

            //Reset progress on complete
            if (e.loaded === e.total) {
                console.log("Upload finished.");
            }
        }
    }
  </script>
  </div>
</body>
</html>