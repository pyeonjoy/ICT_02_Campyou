<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />	
<!DOCTYPE HTML>
<html>ㄱㄱ
<head>
<meta charset=UTF-8>
<title>Insert title here</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${path}/resources/public/css/hu/communityBoard.css">
<%@ include file="../../hs/header.jsp" %>
<script type="text/javascript">
	function commBoard_write() {
		location.href = "comm_board_write.do";
	}
	function commBoard_write_alert(){
		alert("회원님만 글쓰기 하실수 있습니다.\n회원가입이나 로그인 해주세요");
	}
	function board_free_list_go(f) {
		f.action="board_free_list_go.do";
		f.submit();
	}
	function board_free_search(f) {
		f.action="board_free_search.do";
		f.submit();
	}
	console.log("${kakaoMemberInfo.kakao_nickname}")
</script>
<style type="text/css">
.member-grade {
	vertical-align: middle; 
}
</style>
</head>
<body>
	<div id="board-free" align="center">
		<table id="table1">
		<caption>자유게시판</caption>
			<thead>
				<tr class="title">
					<th class="no">번호</th>
					<th class="story">유형</th>
					<th class="subject">제목</th>
					<th class="writer">닉네임</th>
					<th class="reg">날짜</th>
					<th class="hit">조회수</th>
				</tr>
			</thead>
			<tbody> 
				<c:choose>
					<c:when test="${empty commBoard_list}">
						<tr><td colspan="6"><h3>게시물이 존재하지 않습니다.</h3></td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="k" items="${commBoard_list}" varStatus="vs">
							<tr>
							    <c:choose>
							       <c:when test="${k.admin_nickname == '관리자'}">
							        <td class="admin-write-color" style="background-color: lightyellow;">공지</td>
							            <td class="admin-write-color" style="background-color: lightyellow;">${k.b_type}</td>
							            <td class="admin-write-color" style="background-color: lightyellow;">
							                <c:choose>
							                    <c:when test="${k.b_active == 3}">
							                        <span style="color:lightgray">삭제된 게시물입니다</span>
							                    </c:when>
							                    <c:otherwise>
							                        <a href="commBoard_content.do?b_idx=${k.b_idx}&cPage=${paging.nowPage}" style="color: black;">${k.b_subject}</a>
							                    </c:otherwise>
							                </c:choose>
							            </td>
							            <td class="admin-write-color" style="background-color: lightyellow;">
							                <c:choose>
							                    <c:when test="${not empty adminInfo}">
							                        <a href="commBoard_detail.do?b_idx=${k.b_idx}&cPage=${paging.nowPage}" style="color: black;">${k.admin_nickname}</a> 
							                        <a href="commBoard_detail.do?b_idx=${k.b_idx}&cPage=${paging.nowPage}" style="color: black;">${k.member_nickname} ${k.member_name}</a>
							                    </c:when>
							                    <c:otherwise>
							                        <c:choose>
							                            <c:when test="${memberInfo.member_nickname == k.member_nickname}">
							                            	<a href="commBoard_detail.do?b_idx=${k.b_idx}&cPage=${paging.nowPage}" style="color: black;">${adminInfo.admin_nickname}</a>
							                                <a href="commBoard_detail.do?b_idx=${k.b_idx}&cPage=${paging.nowPage}" style="color: black;">${k.member_nickname}</a>             
							                            </c:when>
							                            <c:otherwise>
							                            	<span style="color: black;">${k.admin_nickname}</span> 
							                                <span style="color: black;">${k.member_nickname}</span>
							                            </c:otherwise>
							                        </c:choose>
							                    </c:otherwise>
							                </c:choose>
							            </td>
							            <td class="admin-write-color" style="background-color: lightyellow;">${k.b_regdate.substring(0,10)}</td>
							            <td class="admin-write-color" style="background-color: lightyellow;">${k.b_hit}</td>
							        </c:when>						        
							        <c:otherwise>
							            <td>${paging.totalRecord - ((paging.nowPage-1)*paging.numPerPage + vs.index)}</td>
							            <td>${k.b_type}</td>
							            <td>
							                <!-- <td style="text-align: left; " /> -->
							                <%-- <c:forEach begin="1" end="${k.step}">&nbsp;[Re]</c:forEach> --%>
							                <c:choose>
							                    <c:when test="${k.b_active == 3}">
							                        <span style="color:lightgray">삭제된 게시물입니다</span>
							                    </c:when>
							                    <c:otherwise>
							                        <a href="commBoard_content.do?b_idx=${k.b_idx}&cPage=${paging.nowPage}">${k.b_subject}</a>
							                    </c:otherwise>
							                </c:choose>
							            </td>
							            <td>
							                <c:choose>
							                    <c:when test="${not empty adminInfo}">
							                       <%-- <a href="commBoard_detail.do?b_idx=${k.b_idx}&cPage=${paging.nowPage}">${k.admin_nickname}</a>
							                       <a href="commBoard_detail.do?b_idx=${k.b_idx}&cPage=${paging.nowPage}">${k.member_nickname} ${k.member_name} ${k.kakao_nickname}</a> --%>
							                       <span class="profile_show" data-memberidx="${k.admin_idx}">${k.admin_nickname}</span>						                         						                         	  
							                       <span class="profile_show" data-memberidx="${k.member_idx}">${k.member_nickname}</span>
							                       <span class="profile_show" data-memberidx="${k.member_idx}"></span>
							                       
							                       <c:if test="${k.member_grade == 1}">
													    <img class="member-grade" alt="a" src="resources/images/grade1.png" style="width: 17px; height: 17px;">
												   </c:if>
												   <c:if test="${k.member_grade == 2}">
													    <img class="member-grade" alt="a" src="resources/images/grade2.png" style="width: 17px; height: 17px;">
												   </c:if>
												   <c:if test="${k.member_grade == 3}">
													    <img class="member-grade" alt="a" src="resources/images/grade3.png" style="width: 17px; height: 17px;">
												   </c:if>
												   <c:if test="${k.member_grade == 4}">
													    <img class="member-grade" alt="a" src="resources/images/grade4.png" style="width: 17px; height: 17px;">
												   </c:if>
												    <c:if test="${k.member_grade == 5}">
													    <img class="member-grade" alt="a" src="resources/images/grade5.png" style="width: 17px; height: 17px;">
												   </c:if>
							                    </c:when>
							                    <c:otherwise>
							                        <c:choose>
							                            <c:when test="${memberInfo.member_nickname == k.member_nickname}"> 							     						                         	  
							                         	  <span class="profile_show" data-memberidx="${k.admin_idx}">${k.admin_nickname}</span>						                         						                         	  
							                         	  <span class="profile_show" data-memberidx="${k.member_idx}">${k.member_nickname}</span>
							                         	  ${k.member_name}
							                         	  
							                         	  <c:if test="${k.member_grade == 1}">
															    <img class="member-grade" alt="a" src="resources/images/grade1.png" style="width: 17px; height: 17px;">
														  </c:if>
														  <c:if test="${k.member_grade == 2}">
															    <img class="member-grade" alt="a" src="resources/images/grade2.png" style="width: 17px; height: 17px;">
														  </c:if>
														  <c:if test="${k.member_grade == 3}">
															    <img class="member-grade" alt="a" src="resources/images/grade3.png" style="width: 17px; height: 17px;">
														  </c:if>
														  <c:if test="${k.member_grade == 4}">
															    <img class="member-grade" alt="a" src="resources/images/grade4.png" style="width: 17px; height: 17px;">
														  </c:if>
														   <c:if test="${k.member_grade == 5}">
															    <img class="member-grade" alt="a" src="resources/images/grade5.png" style="width: 17px; height: 17px;">
														  </c:if>
							                            </c:when>						                    
							                            <c:otherwise>
							                            	${k.admin_nickname}						     
								                            <span class="profile_show" data-memberidx="${k.member_idx}">${k.member_nickname}</span>
								                            <span class="profile_show" data-memberidx="${k.member_name}">${k.member_name}</span>
								                            <span class="profile_show" data-memberidx="${k.kakao_nickname}"></span>
							                            	<%-- ${k.member_nickname}
							                            		 ${k.member_name}
							                            	     ${k.kakao_nickname} --%>
							                            	<c:if test="${k.member_grade == 1}">
															    <img class="member-grade" alt="a" src="resources/images/grade1.png" style="width: 17px; height: 17px;">
														  	</c:if>
														 	<c:if test="${k.member_grade == 2}">
															    <img class="member-grade" alt="a" src="resources/images/grade2.png" style="width: 17px; height: 17px;">
														  	</c:if>
														  	<c:if test="${k.member_grade == 3}">
															    <img class="member-grade" alt="a" src="resources/images/grade3.png" style="width: 17px; height: 17px;">
														  	</c:if>
														  	<c:if test="${k.member_grade == 4}">
															    <img class="member-grade" alt="a" src="resources/images/grade4.png" style="width: 17px; height: 17px;">
														  	</c:if>
														    <c:if test="${k.member_grade == 5}">
															    <img class="member-grade" alt="a" src="resources/images/grade5.png" style="width: 17px; height: 17px;">
														  	</c:if>						                    
							                            </c:otherwise>
							                        </c:choose>
							                    </c:otherwise>
							                </c:choose>
							            </td>
							            <td>${k.b_regdate.substring(0,10)}</td>
							            <td>${k.b_hit}</td>
							        </c:otherwise>
							    </c:choose>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<table id="table2">
		<tfoot id="aaa">
			<tr id="foot-tr">
				<td id="select-option" colspan="6">
					<form method="post">
							<p><input type="hidden" onclick="board_free_list_go(this.form)"> </p>
							<p>
		   						<select name="b_idx">
		   							<option value="1">제목</option>
		   							<option value="2">내용</option>
		   							<option value="3">작성자</option>
		   							<option value="4">날짜</option>
		  						 </select>
		   					<input type="text" name="keyword">
		   					<input type="button" value="검색" onclick="board_free_search(this.form)">
							</p>
					</form>
			     </td>
				<!-- <td colspan="2"> --> <!-- 원래는 4 -->
				<td id="paging-pre-next">
					<ol class="paging">
						<!-- 이전 버튼 -->
						<c:choose>
							<c:when test="${paging.beginBlock <= paging.pagePerBlock}">
								<li class="disable">이전</li>
							</c:when>
							<c:otherwise>
								<li><a href="community_board.do?cPage=${paging.beginBlock - paging.pagePerBlock}">이전으로</a></li>
							</c:otherwise>
						</c:choose>
						<!-- 페이지번호들 -->
						<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock}" step="1" var="k">
							<c:choose>
								<c:when test="${k == paging.nowPage }">
									<li class="now">${k}</li>
								</c:when>
								<c:otherwise>
									<li><a href="community_board.do?cPage=${k}">${k}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<!-- 이후 버튼 -->
						<c:choose>
							<c:when test="${paging.endBlock >= paging.totalPage }">
								<li class="disable">다음</li>
							</c:when>
							<c:otherwise>
								<li><a href="community_board.do?cPage=${paging.beginBlock + paging.pagePerBlock }">다음으로</a></li>
							</c:otherwise>
						</c:choose>
					</ol>	
				</td>
				<td>
					<c:choose>
						<c:when test="${memberInfo != null || adminInfo != null || kakaoMemberInfo != null || naverMemberInfo != null}">
							<input type="button" id="btnWrite" value="글쓰기" onclick="commBoard_write()">
						</c:when>
						<c:otherwise>
							<input type="button" id="btnWrite" value="글쓰기" onclick="commBoard_write_alert()">
						</c:otherwise>
					</c:choose>
				</td>
				</tr>
			</tfoot>	
		</table>
	</div>
<%@ include file="../../hs/footer.jsp" %>
<%@ include file="../../hs/profile_small_info.jsp" %>
</body>
</html>