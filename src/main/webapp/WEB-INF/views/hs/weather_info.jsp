<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="resources/public/js/hs/weather_info.js"></script>
<link rel="stylesheet" href="resources/public/css/hs/weather_info.css">
<link rel="stylesheet" href="resources/css/reset.css">
</head>
<body>
	<div class="weather_info_container">
		<div class="weather_info_title">
			<h4>일기예보</h4><span>데이터 제공: 기상청</span>
		</div>
		<div id="weather_info_list"></div>
	</div>
	
	<div class="weather-btn-box" >
		<div class="weather-btn">
			<img alt="날씨" src="resources/images/weather-btn.png">
		</div>
	</div>
</body>
</html>