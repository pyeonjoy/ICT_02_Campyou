<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심캠핑장</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<script>
let data = ${jsonString}; 
const path = "${path}";
</script>
<link rel="stylesheet" href="${path}/resources/public/css/bm/my_fav_camping.css">
 <link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
 <script defer src="${path}/resources/public/js/bm/fav_camping.js"></script>
 <script defer src="${path}/resources/public/js/jun/camp_list.js"></script>
</head>
<body>
	<%@ include file="../hs/mypage_menu.jsp"%>
<div class="body">	
 <div class="mypage">
      <h3 class="my_camping"> 관심 캠핑장 </h3>

      <div class="camping_container"> 
    
      </div>
  </div>
    <%@ include file="../hs/footer.jsp"%>
 </div>
</body>
</html>