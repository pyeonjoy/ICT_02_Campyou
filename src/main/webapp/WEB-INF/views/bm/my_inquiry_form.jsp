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
 <div class="form_container">
  <h1 class="inquiry_title">1:1문의</h1>
  <form class="form_inquiry" method="post">
    <div class="title_box">
      <input type="text" placeholder="글제목" class="input_title">
    </div>
    <textarea class="text_area" id="summernote" name="editordata">

    </textarea>
    <div class="form_bottom">
      <div class="form_file">
        <div class="file1_container">

          <label for='file1'>파일1</label><input type="file" id='file1' class="file">
        </div>
        <div class="file2_container">
          <label for='file2'>파일2</label><input type="file" id='file2' class="file">
        </div>
      </div>
      <div class="form_btn">
        <button class="btn btn-modi">수정</button>
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
        });
    });
  </script>
  </div>
</body>
</html>