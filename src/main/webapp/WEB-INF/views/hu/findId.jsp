<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<%@ include file="../hs/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script type="text/javascript">
function findId(f) {
	if(f.email.value === ""){
		 alert("이메일을 입력하세요.");
		 f.email.focus();
		 return;
	 }
	 if(f.member_name.value === ""){
		 alert("이름을 입력하세요.");
		 f.member_name.focus();
		 return;
	 }
	 alert("귀하의 아이디를 보냈습니다.\n이메일을 확인해 주세요");
	 f.action="id_send_ok.do";
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
        <img src="https://skinnonews.com/wp-content/uploads/2016/08/%EC%BA%A0%ED%95%91%EC%9E%A5-%EC%86%8D-%EC%84%9D%EC%9C%A0_%EB%B3%B8%EB%AC%B8.png"
          class="img-fluid" alt="Phone image">
      </div>
      <div class="col-md-7 col-lg-5 col-xl-5 offset-xl-1">
      <h2>아이디 찾기</h2>
      <br>
        <form method="post">
	          <div data-mdb-input-init class="form-outline mb-4">
	            <input type="email" id="email" name="email" class="form-control form-control-lg" />
	            <label class="form-label" for="email">이메일</label>
	          </div>
	          <div data-mdb-input-init class="form-outline mb-4">
	            <input type="text" id="member_name" name="member_name" class="form-control form-control-lg" />
	            <label class="form-label" for="member_name">이름</label>
	          </div>
	          <button type="submit" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block" onclick="findId(this.form)">아이디 찾기</button>
        </form>
      </div>
    </div>
  </div>
</section>
 <%@ include file="../hs/footer.jsp" %>
</body>
</html>