<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qpvmsbuult"></script>

<script src="/resources/js/jun/camp_list.js"></script>
<title>CAMPYOU:지도로 검색</title>
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

.camp_map_list_wrap {
	border: 1px solid #ccc;
	width: 80vw;
	height: 740px;
	margin-bottom: 100px;
	position: relative;
	overflow:hidden;
	overflow-y: scroll;
}

.map_show{
	float: left;
	width: 60%;
	height: 100%;
}

#map {
	position: absolute;
	width: 100%;
	height: 100%;
}

.camp_list_wrap{
	float:left;
    width: 40%;
    height: 100%;
}

#camp_list_show {
 	display:inline;
	position: absolute;
}
.camp_item {
	width: 100%;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	//지도를 삽입할 HTML 요소 또는 HTML 요소의 id를 지정합니다.
	let mapDiv = document.querySelector('.map_show #map'); // 'map'으로 선언해도 동일
	
	//옵션 없이 지도 객체를 생성하면 서울 시청을 중심으로 하는 16 레벨의 지도가 생성됩니다.
	let map = new naver.maps.Map(mapDiv);
});
</script>
</head>
<body>
<jsp:include page="../hs/header.jsp" />
<div style="height: 100px;"></div>
	<div class="camp_list_container">
		<jsp:include page="../hs/camp_search_box.jsp" />
	<div class="camp_map_list_wrap">
	    <div class="map_show">
	    	<div id="map"></div>
	    </div>
	   	<div class="camp_list_wrap">
	   		<div id="camp_list_show"></div>
	   	</div>
   	</div>
</div>
<jsp:include page="../hs/footer.jsp" />
</body>
</html>