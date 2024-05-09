<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="/resources/public/js/jun/camp_list.js"></script>
<title>캠핑장리스트</title>
<style type="text/css">
.camp_list_container {
	display: flex;
	flex-direction: column;
	align-items: center;
}

#camp_list_show {
	display: flex;
	justify-content: center;
	align-items: flex-start;
	flex-wrap: wrap;
}

.camp_item {
	position: relative;
	display: flex;
	width: 45%;
	margin-bottom: 40px;
	padding: 20px;
	border: 1px solid black;
	box-sizing: border-box;
	margin-right: 4%;
}

.camp_item img {
	width: 220px;
	height: 180px;
	margin-right: 20px;
}

.camp_info {
	width: 60%;
}

.camp_item p {
	margin: 0;
	margin-bottom: 10px;
}

.button_container {
	position: absolute;
	top: 10px;
	right: 10px;
}

#camp_list_button {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

#camp_list_button button {
	margin: 0 10px;
}
.Heart_button{
    position: relative;
    top: 80px;
    right: -30px;
}
</style>
</head>
<body>
	<jsp:include page="../hs/header.jsp" />
	<div style="height: 100px;"></div>
	<div class="camp_list_container">
		<jsp:include page="../hs/camp_search_box.jsp" />
		<div id="camp_list_show"></div>
	</div>
	<div id="camp_list_button">
		<button class="camp_list_before">이전 페이지</button>
		<button class="camp_list_next">다음 페이지</button>
	</div>
	<jsp:include page="../hs/footer.jsp" />
</body>

</html>
