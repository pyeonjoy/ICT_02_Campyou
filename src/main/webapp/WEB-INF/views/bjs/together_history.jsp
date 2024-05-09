<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_detail.css">

<%@ include file="../hs/header.jsp" %>
<script type="text/javascript">

</script>
</head>
<body>
	<div class="qadetailcontainer">
		<div class="qadetailtitlediv">
			<h3 class="qadetailtitle">Q & A 게시글</h3>
		</div>
		<div class="qadetailwrapper">
			<div class="gadetaildiv">
	            <form method="post">
					<ul class="qadetailul">
						<li class="qadetailli">
							<p class="qadetailitem1">항목</p>
							<p class="qadetailitem">&nbsp;${qavo.qa_type }</p>
						</li>
						<li class="qadetailli">
							<p class="qadetailitem1">이름</p>
							<p class="qadetailitem">&nbsp;${member_name }</p>
						</li>
						<li class="qadetailli">
							<p class="qadetailitem1">제목</p>
							<p class="qadetailitem1-1" id="qadetailitem1-1">&nbsp;${qavo.qa_subject }</p>
						</li>
						<li>
							<pre><p class="qacontent">&nbsp;${qavo.qa_content }</p></pre>
						</li>
					</ul>
					<div class="qadetail">
						<div class="qadetailupdel">
							<input type="hidden" name="qa_idx" value="${qavo.qa_idx }">
							<input type="hidden" name="cPage" value="${cPage }">
							<input type="button" class="qadetail1" value="수정하기" onclick="qa_update(this.form)">
							<input type="button" class="qadetail1" value="삭제하기" onclick="qa_delete(this.form)">
						</div>
						<div class="qadetaillist">
							<input type="button" class="qadetail2" value="목록" onclick="qa_list()"> 
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>