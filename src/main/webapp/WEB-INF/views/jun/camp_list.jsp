<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="/resources/public/js/jun/camp_list.js"></script>
<link rel="stylesheet" href="resources/public/css/bjs/together_list.css">
<script src="https://kit.fontawesome.com/80123590ac.js" crossorigin="anonymous"></script>
<%@ include file="../hs/profile_small_info.jsp" %>
<title>캠핑장리스트</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<style type="text/css">
.camp_list_container {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 100%;
}

#camp_list_show {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    width: 100%;
}

#camp_list_show .firstImg{
    width: 40%;
    height: 300px;
    object-fit: cover;
    flex-shrink: 0;
}

.camp_item {
    position: relative;
    display: flex;
    margin-bottom: 40px;
    padding: 35px;
    border: 1px solid black;
    box-sizing: border-box;
    margin-right: 2%;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    width: 45%;
    max-width: 45%; 
    border-radius: 20px;
}

.camp_info {
    padding: 0 20px;
    line-height: 75px;
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

.page_button_space {
	display: flex;
	justify-content: center;
	padding: 20px;
}
.page_button2{
	display: flex;
	justify-content: center;
	padding: 20px;
	flex-direction: row;
}
.page_button2 ul{
	display: flex;
}
.search_nowpagecolor{
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	text-decoration: none;
	background-color: white;
	color: #FFBA34;
	font-size: 1.4rem;
}
.search_nowpage{
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	background-color: white;
	color: black;
	text-decoration: none;
	font-size: 1.4rem;
}
.search_th_disable{
	color: silver;
	margin: 0 1rem;
	text-decoration: none;
}
.search_th_able{
	color: black;
	margin: 0 1rem;
	text-decoration: none;
}
.search_nowpage:hover{
	color: #FFBA34;
}

.go_map_button{
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    }
.go_map_button h4{
	margin-left: 57px;
    width: 34%;
}
.go_map_button input[type="button"]{
	font-weight: 600;
	width: 100px;
	height: 36px;
	background-color: #FFBA34;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-left-radius: 0px;
	border-bottom-right-radius: 0px;
	margin-right: 97px;
}

.go_map_button input[type="button"]:hover{
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-left-radius: 0px;
	border-bottom-right-radius: 0px;
}

.result_info {
	padding: 0 5px;
}
.total_count {
	color: orange;
}

.keyword {
	font-weight: 300;
}

.result_info_line {
	width: 90vw;
	display: flex;
	line-height: 30px;
	justify-content: space-between;
}
.heart-button{
    position: absolute;
    bottom: 30px;
    right: 15px;
    width: 30px;
}
</style>
</head>
<body>
	<jsp:include page="../hs/header.jsp" />
	<div style="height: 100px;"></div>
	<div class="camp_list_container">
		<jsp:include page="../hs/camp_search_box.jsp" />
		<div class="go_map_button">
			<h4><span class="keyword"></span> 검색 결과 <span class="total_count"></span></h4>	
			<input type="button" value="지도로 검색" onclick="go_map()">
		</div>
		<div id="camp_list_show"></div>
		<div class="page_button">
			<ul class="to_paging camp_list_page">
			</ul>
		</div>
	</div>
		<div class ="page_button2">
			<ul class="th_paging">
			</ul>
		</div>
	<jsp:include page="../hs/footer.jsp" />
</body>

</html>
