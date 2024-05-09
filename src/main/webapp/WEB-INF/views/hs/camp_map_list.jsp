<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/80123590ac.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qpvmsbuult"></script>
<link href="resources/public/css/hs/camp_map_list.css" rel="stylesheet" />
<link rel="stylesheet" href="resources/public/css/bjs/together_list.css">
<script src="resources/public/js/hs/camp_map_list.js" ></script>
<title>CAMPYOU:지도로 검색</title>
<script type="text/javascript">
$(document).ready(function() {
	
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
	   		<div class="camp_list_inner">
		   		<div id="camp_list_show"></div>
   				<div class="page_button_space">
	   				<div class="page_button">
						<ul class="to_paging campe_list_page">
							
						</ul>
			   		</div>
	   			</div>
   			</div>
	   	</div>
   	</div>
</div>
<jsp:include page="../hs/footer.jsp" />
</body>
</html>