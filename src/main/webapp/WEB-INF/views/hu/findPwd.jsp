<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호찾기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script type="text/javascript">
	function findPwd(f) {
		f.action="email_send_ok.do";
		f.submit();
	}
</script> 
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<section class="vh-100">
  <div class="container py-5 h-100">
    <div class="row d-flex align-items-center justify-content-center h-100">
      <div class="col-md-8 col-lg-7 col-xl-6">
        <img src="https://blog.kakaocdn.net/dn/xxyIJ/btq92x3CGjB/Yc203QOlRmjDO2rjKC4TDK/img.jpg"
          class="img-fluid" alt="Phone image">
      </div>
      <div class="col-md-7 col-lg-5 col-xl-5 offset-xl-1">
      <h2>비밀번호 찾기</h2>
      <br>
        <form method="post">
	          <div data-mdb-input-init class="form-outline mb-4">
	            <input type="email" id="email" name="member_email" class="form-control form-control-lg" />
	            <label class="form-label" for="email">이메일</label>
	          </div>
	          <div data-mdb-input-init class="form-outline mb-4">
	            <input type="text" id="member_id" name="member_id" class="form-control form-control-lg" />
	            <label class="form-label" for="member_id">아이디</label>
	          </div>
	          <button type="submit" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block" onclick="findPwd(this.form)">비밀번호 찾기</button>
        </form>
      </div>
    </div>
  </div>
</section>
</body>
</html>