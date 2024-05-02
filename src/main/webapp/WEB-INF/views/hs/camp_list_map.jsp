<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CAMPYOU:지도로 검색</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qpvmsbuult"></script>
<script type="text/javascript">
</script>
<style type="text/css">
.camp_map_search_body {
	padding-top: 100px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.camp_map_result {
	border: 1px solid #ccc;
	width: 80%;
	height: 80vh;
	margin: 50px;
	position: relative;
}
/* 
.camp_map_list_wrap {
	width: 40%;
	height: 100%;
	border: 1px solid #ccc;
	position: absolute;
} */

#map {
	position: absolute;
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<jsp:include page="../hs/header.jsp" />
	<div class="camp_map_search_body">
		<jsp:include page="../hs/camp_search_box.jsp" />
		<div class="camp_map_result">
			<div class="camp_map_wrap">
				<div id="map" style="width:100%;height:100%;"></div>
			</div>
			<div class="camp_map_list_wrap">
			</div>

		</div>
	</div>
</body>
</html>