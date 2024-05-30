<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />	
<!DOCTYPE HTML>
<html>
<head>
<meta charset=UTF-8>
<title>관리자 페이지</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${path}/resources/public/css/hu/adminBoard.css">
<%@ include file="../hs/header.jsp" %>
<script type="text/javascript">
function permissionBtn(f) {
    var button = f.btnPermission;
    var admin_idx = f.admin_idx.value;
    
    if (button.value === "권한주기") {
    	button.value = "권한회수";       
        f.action="give_admin_permission_update.do";
		f.submit();
	
    }else {
    	button.value = "권한주기";           
        f.action="revoke_admin_permission_update.do";
		f.submit();
    }
 }
function assistant_admin_account(f) {
    f.action="admin_signup_page_go.do";
	f.submit();
 }
function delete_assistant_admin(f) {
    f.action="delete_assistant_admin.do";
	f.submit();
 }
function update_admin(f) {
    f.action="update_admin.do";
	f.submit();
 }
</script>
<style type="text/css">
body{
  background-color: #F6FFF1;
}
</style>
</head>
<body>
<jsp:include page="../hs/admin_menu.jsp" />
	<div id="board-free" align="center">
		<table id="table1">
		<caption>관리자</caption>
			<thead>
				<tr class="title">
					<th class="no">관리자번호</th>
					<th class="admin-id">관리자아이디</th>
					<th class="admin-name">관리자이름</th>
					<th class="admin-nickname">관리자닉네임</th>
					<th class="admin-phone">관리자전화번호</th>
					<th class="admin-email">관리자이메일</th>
				</tr>
			</thead>
			<tbody> 
				<c:choose>
					<c:when test="${empty admin_list}">
						<tr><td colspan="6"><h3>게시물이 존재하지 않습니다.</h3></td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="k" items="${admin_list}" varStatus="vs">
							<tr>
								<form method="post">
								    <c:choose>
								        <c:when test="${k.admin_id == 'admin'}">
								        <td class="admin-write-color" style="background-color: #C0C0C0;">슈퍼관리자</td>
								         <%--  <td class="admin-write-color" style="background-color: lightyellow;">${paging.totalRecord - ((paging.nowPage-1)*paging.numPerPage + vs.index)}</td> --%>
								            <td class="admin-write-color" style="background-color: #C0C0C0;">${k.admin_id} <br>
								            	
								            	<c:choose>
								            		<c:when test="${adminInfo.admin_id eq 'admin'}">
									            		<input type="button" value="수정" id="btnUpdateForSuperAdmin" onclick="update_admin(this.form)">
									            		<input type="hidden" name ="admin_idx" value="${k.admin_idx}">
								            		</c:when>
								            		<c:otherwise>
								            		
								            		</c:otherwise>
								            	</c:choose> 
								            </td>
								            <td class="admin-write-color" style="background-color: #C0C0C0;">${k.admin_name}</td>
								            <td class="admin-write-color" style="background-color: #C0C0C0;">${k.admin_nickname}</td>
								            <td class="admin-write-color" style="background-color: #C0C0C0;">${k.admin_phone}</td>
								            <td class="admin-write-color" style="background-color: #C0C0C0;">${k.admin_email}</td>
								        </c:when>						        
								        <c:otherwise>
								            <td>${paging.totalRecord - ((paging.nowPage-1)*paging.numPerPage + vs.index)}</td>
								            <td>${k.admin_id} <br>
								            <c:choose>
								            	<c:when test="${adminInfo.admin_id == 'admin'}">
								            		<c:choose>
								            			<c:when test="${k.admin_status == 0}">
								            				<input type="button" value="권한주기" id="btnPermission" onclick="permissionBtn(this.form)">
								                			<input type="hidden" name ="admin_idx" value="${k.admin_idx}"> 
								                			<input type="hidden" name ="cPage" value="${paging.nowPage}">
								            			</c:when>
								            			<c:otherwise>
								            				<input type="button" value="권한회수" id="btnPermission" onclick="permissionBtn(this.form)">
								                			<input type="hidden" name ="admin_idx" value="${k.admin_idx}"> 
								                			<input type="hidden" name ="cPage" value="${paging.nowPage}">
								            			</c:otherwise>
								            		</c:choose>
								            	</c:when>
								            	<c:otherwise>
								            	</c:otherwise>
								            </c:choose>
								            <c:choose>
								            	<c:when test="${adminInfo.admin_id == 'admin'}">
								            		<input type="button" value="삭제" id="btnDelete" onclick="delete_assistant_admin(this.form)">
								           			<input type="button" value="수정" id="btnUpdate" onclick="update_admin(this.form)">	           			
								            	</c:when>
								            	<c:otherwise>
								           		</c:otherwise>
								            </c:choose>
								            </td>
								            <td>${k.admin_name}</td>
								            <td>${k.admin_nickname}</td>
								            <td>${k.admin_phone}</td>
								            <td>${k.admin_email}</td>
								        </c:otherwise>
								    </c:choose>
							    </form>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<table id="table2">
		<tfoot>
			<tr id="foot-tr">
				<td id="paging-pre-next">
					<ol class="paging">
						<!-- 이전 버튼 -->
						<c:choose>
							<c:when test="${paging.beginBlock <= paging.pagePerBlock}">
								<li class="disable">이전</li>
							</c:when>
							<c:otherwise>
								<li><a href="admin_page.do?cPage=${paging.beginBlock - paging.pagePerBlock}">이전으로</a></li>
							</c:otherwise>
						</c:choose>
						<!-- 페이지번호들 -->
						<c:forEach begin="${paging.beginBlock}" end="${paging.endBlock}" step="1" var="k">
							<c:choose>
								<c:when test="${k == paging.nowPage }">
									<li class="now">${k}</li>
								</c:when>
								<c:otherwise>
									<li><a href="admin_page.do?cPage=${k}">${k}</a></li> 
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<!-- 이후 버튼 -->
						<c:choose>
							<c:when test="${paging.endBlock >= paging.totalPage }">
								<li class="disable">다음</li>
							</c:when>
							<c:otherwise>
								<li><a href="admin_page.do?cPage=${paging.beginBlock + paging.pagePerBlock }">다음으로</a></li>
							</c:otherwise>
						</c:choose>
					</ol>	
				</td>
				<td>
					<form method="post">
						<c:choose>
							<c:when test="${adminInfo.admin_id == 'admin'}">
								<input type="button" id="btnWrite" name="admin_idx" value="관리자 생성" onclick="assistant_admin_account(this.form)">
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</form>
				</td> 
				</tr>
			</tfoot>	
		</table>
	</div>
</body>
</html>