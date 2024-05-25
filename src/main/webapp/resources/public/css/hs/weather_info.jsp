<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
$(document).ready(function() {
   	$.ajax({
	    url: 'getWeather.do',
	    method: 'post',
	    dataType: 'json',
	    success: function(data) {
	    	
	    },
	    error: function(dob) {
	    	console.log("읽기 실패");
	    }
	});
});


</script>
</head>
<body>
	<div class="weather_result"></div>>
</body>
</html>