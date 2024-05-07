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
<script src="resources/public/js/jun/camp_list.js" ></script>
<script src="resources/public/js/hs/camp_map_list.js" ></script>
<title>CAMPYOU:지도로 검색</title>
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
	   		<div class="camp_list_inner">
		   		<div id="camp_list_show"></div>
   				<div class="page_button_space">
	   				<div class="page_button">
						<ul class="to_paging">
							<!-- 이전 버튼 -->
							<li class="to_disable "><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; color: 041601; font-size: 1.2rem;"></i></li>
							<li class="to_disable camp_list_before"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; color: 041601; font-size: 1.2rem;"></i></li>
				
							<!-- 페이지번호들 -->
							<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock }" step="1" var="k">
								<c:choose>
									<c:when test="${k == paging.nowPage }">
										<li class="nowpagecolor">${k }</li>
									</c:when>
									<c:otherwise>
										<li><a href="together_list.do?cPage=${k }" class="nowpage">${k }</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<!-- 이후 버튼 -->
							<li>
								<i class="fa-solid fa-chevron-right to_able camp_list_next" style="color: 041601; border-radius: 50%; font-size: 1.2rem;"></i>
							</li>
							<li>
								<i class="fa-solid fa-angles-right to_able" style="color: 041601; border-radius: 50%; font-size: 1.2rem;"></i>
							</li>
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