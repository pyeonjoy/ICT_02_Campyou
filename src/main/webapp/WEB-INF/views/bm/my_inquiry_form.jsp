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
  <form class="form_inquiry" method="post" enctype="multipart/form-data">
    <div class="title_box">
      <input type="text" placeholder="글제목" class="input_title" name="qna_title">
    </div>
    <textarea class="text_area" id="summernote" name="qna_content">
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
    	$('.summernote').summernote({

    	    lang : 'ko-KR',
        	height : 300,
        	focus : true,
    	    callbacks: {
    	        onFileUpload: function(file) {
    	            myOwnCallBack(file[0]);
    	        },
    	    },
    	});
    });
       
    function myOwnCallBack(file) {
        let data = new FormData();
        data.append("file", file);
        $.ajax({
            data: data,
            type: "POST",
            url: "file-uploader.do",
            cache: false,
            contentType: false,
            processData: false,
            xhr: function() { 
                let myXhr = $.ajaxSettings.xhr();
                if (myXhr.upload) myXhr.upload.addEventListener('progress', progressHandlingFunction, false);
                return myXhr;
            },
            success: function(reponse) {
                if(reponse.status === true) {
                    let listMimeImg = ['image/png', 'image/jpeg', 'image/webp', 'image/gif', 'image/svg'];
                    let listMimeAudio = ['audio/mpeg', 'audio/ogg'];
                    let listMimeVideo = ['video/mpeg', 'video/mp4', 'video/webm'];
                    let elem;

                    if (listMimeImg.indexOf(file.type) > -1) {
                        //Picture
                        $('.summernote').summernote('editor.insertImage', reponse.filename);
                    } else if (listMimeAudio.indexOf(file.type) > -1) {
                        //Audio
                        elem = document.createElement("audio");
                        elem.setAttribute("src", reponse.filename);
                        elem.setAttribute("controls", "controls");
                        elem.setAttribute("preload", "metadata");
                        $('.summernote').summernote('editor.insertNode', elem);
                    } else if (listMimeVideo.indexOf(file.type) > -1) {
                        //Video
                        elem = document.createElement("video");
                        elem.setAttribute("src", reponse.filename);
                        elem.setAttribute("controls", "controls");
                        elem.setAttribute("preload", "metadata");
                        $('.summernote').summernote('editor.insertNode', elem);
                    } else {
                        //Other file type
                        elem = document.createElement("a");
                        let linkText = document.createTextNode(file.name);
                        elem.appendChild(linkText);
                        elem.title = file.name;
                        elem.href = reponse.filename;
                        $('.summernote').summernote('editor.insertNode', elem);
                    }
                }
            }
        });
    }

    function uploadFileAndContent() {
        const content = $('.summernote').summernote('code');

        const file = document.querySelector('input[type=file]').files[0];
        const formData = new FormData();
        formData.append('file', file);
        formData.append('content', content);

        $.ajax({
            url: 'upload.do', 
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                console.log('파일 및 게시물 내용 업로드 완료');
            },
            error: function(xhr, status, error) {
                console.error('파일 및 게시물 내용 업로드 실패:', status, error);
            }
        });
    }
    
    
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