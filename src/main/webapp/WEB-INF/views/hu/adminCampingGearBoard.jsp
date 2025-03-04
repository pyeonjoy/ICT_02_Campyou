<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />	
<!DOCTYPE HTML>
<html>
<head>
<meta charset=UTF-8>
<title>Insert title here</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${path}/resources/public/css/hu/adminCampingGearBoard.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%@ include file="../hs/header.jsp" %>
<script type="text/javascript">
	function camping_gear_write() {
		location.href = "admin_camping_gear_write.do";
	}
	function camping_gear_write_alert(){
		alert("회원님만 글쓰기 하실수 있습니다.\n회원가입이나 로그인 해주세요");
	}
	
	function camping_gear_list_go(f) {
		f.action="admin_camping_gear_list_go.do";
		f.submit();
	}
	function camping_gear_search(f) {
		f.action="admin_camping_gear_search.do";
		f.submit();
	}
</script>
<script type="text/javascript">
function controlMemberContent1(f) {
    var button = f.hideMemberContent;
    
    if (button.value === "글숨김") {
        button.value = "글보임";       
        f.action = "camping_gear_board_content_hide_update.do";
    } else {
        button.value = "글숨김";           
        f.action = "camping_gear_board_content_show_update.do";
    }
    f.submit();
}
</script>
<style type="text/css">
body{
  background-color: #F6FFF1;
}
.member-grade {
	vertical-align: middle; 
}
</style>
</head>
<body>
<jsp:include page="../hs/admin_menu.jsp" />
	<div id="board-free" align="center">
	<form method="post">
		<table id="table1">
		<caption>관리자 캠핑추천게시판 관리</caption>
			<thead>
				<tr class="title">
					<th class="no">글관리</th>
					<th class="no">번호</th>
					<th class="subject">제목</th>
					<th class="writer">닉네임</th>
					<th class="reg">날짜</th>
					<th class="hit">조회수</th>
				</tr>
			</thead>
			<tbody> 
				<c:choose>
					<c:when test="${empty camping_gear_list}">
						<tr><td colspan="6"><h3>게시물이 존재하지 않습니다.</h3></td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="k" items="${camping_gear_list}" varStatus="vs">
							<tr>
							    <c:choose>
							        <c:when test="${k.admin_nickname == '관리자'}">
							        
							        
							        <td class="admin-write-color" style="background-color: lightyellow;">			     
									    <form method="post">
										    <c:choose>
										        <c:when test="${k.cp_active == 0}">
										            <input type="button" id="hideMemberContent" name="hideMemberContent" value="글숨김" onclick="controlMemberContent1(this.form)">
										            <input type="hidden" value="${k.cp_idx}" name="cp_idx">
										            <input type="hidden" name="cPage" value="${paging.nowPage}">
										        </c:when>
										        <c:otherwise>
										            <input type="button" id="hideMemberContent" name="hideMemberContent" value="글보임" onclick="controlMemberContent1(this.form)">
										            <input type="hidden" value="${k.cp_idx}" name="cp_idx">
										            <input type="hidden" name="cPage" value="${paging.nowPage}">
										        </c:otherwise>
										    </c:choose>
										 </form>					
						      		  </td>
						      		  
						      		  
							        <td class="admin-write-color" style="background-color: lightyellow;">공지</td>
							            <td class="admin-write-color" style="background-color: lightyellow;">
							                <c:choose>
							                    <c:when test="${k.cp_active == 3}">
							                        <span style="color:lightgray">삭제된 게시물입니다</span>
							                    </c:when>
							                    <c:otherwise>
							                        <a href="admin_camping_gear_content.do?cp_idx=${k.cp_idx}&cPage=${paging.nowPage}">${k.cp_subject}</a>
							                    </c:otherwise>
							                </c:choose>
							            </td>
							            <td class="admin-write-color" style="background-color: lightyellow;">
							            	<c:choose>
											    <c:when test="${not empty adminInfo}">
											            <%-- <a href="camping_gear_detail.do?cp_idx=${k.cp_idx}&cPage=${paging.nowPage}">${k.admin_nickname}</a>  --%>										            
											            ${k.admin_nickname}    
											    </c:when>
											    <c:otherwise>
											   	 	${k.admin_nickname}
											    </c:otherwise>
											</c:choose>
							            </td>
							            <td class="admin-write-color" style="background-color: lightyellow;">${k.cp_regdate.substring(0,10)}</td>
							            <td class="admin-write-color" style="background-color: lightyellow;">${k.cp_hit}</td>
							        </c:when>						        
							        <c:otherwise>
							        
							        
							        
							        <td>			     
									    <form method="post">
										    <c:choose>
										        <c:when test="${k.cp_active == 0}">
										            <input type="button" id="hideMemberContent" name="hideMemberContent" value="글숨김" onclick="controlMemberContent1(this.form)">
										            <input type="hidden" value="${k.cp_idx}" name="cp_idx">
										            <input type="hidden" name="cPage" value="${paging.nowPage}">
										        </c:when>
										        <c:otherwise>
										            <input type="button" id="hideMemberContent" name="hideMemberContent" value="글보임" onclick="controlMemberContent1(this.form)">
										            <input type="hidden" value="${k.cp_idx}" name="cp_idx">
										            <input type="hidden" name="cPage" value="${paging.nowPage}">
										        </c:otherwise>
										    </c:choose>
										 </form>					
						      		  </td>
							            <td>${paging.totalRecord - ((paging.nowPage-1)*paging.numPerPage + vs.index)}</td>
							            <td>
							                <!-- <td style="text-align: left; " /> -->
							                <%-- <c:forEach begin="1" end="${k.step}">&nbsp;[Re]</c:forEach> --%>
							                <c:choose>
							                    <c:when test="${k.cp_active == 3}">
							                        <span style="color:lightgray">삭제된 게시물입니다</span>
							                    </c:when>
							                    <c:otherwise>
							                        <a href="admin_camping_gear_content.do?cp_idx=${k.cp_idx}&cPage=${paging.nowPage}">${k.cp_subject}</a>
							                    </c:otherwise>
							                </c:choose>
							            </td>
							            <td>
							                <c:choose>
							                    <c:when test="${not empty adminInfo}">
							                    	<%-- <a href="camping_gear_detail.do?cp_idx=${k.cp_idx}&cPage=${paging.nowPage}">${k.admin_nickname}</a>
							                        <a href="camping_gear_detail.do?cp_idx=${k.cp_idx}&cPage=${paging.nowPage}">${k.member_nickname} ${k.member_name} ${k.kakao_nickname}</a> --%>
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
							                            	<%-- <a href="camping_gear_detail.do?cp_idx=${k.cp_idx}&cPage=${paging.nowPage}">${k.admin_nickname}</a>
							                                <a href="camping_gear_detail.do?cp_idx=${k.cp_idx}&cPage=${paging.nowPage}">${k.member_nickname}</a> --%>
							                                
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
							            <td>${k.cp_regdate.substring(0,10)}</td>
							            <td>${k.cp_hit}</td>
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
							<p><input type="hidden" onclick="camping_gear_list_go(this.form)"> </p>
							<p>
		   						<select name="cp_idx">
		   							<option value="1">제목</option>
		   							<option value="2">내용</option>
		   							<option value="3">작성자</option>
		   							<option value="4">날짜</option>
		  						 </select>
		   					<input type="text" name="keyword">
		   					<input type="button" value="검색" onclick="camping_gear_search(this.form)">
							</p>
					</form>
			     </td>
				<td id="paging-pre-next">
					<ol class="paging">
						<!-- 이전 버튼 -->
						<c:choose>
							<c:when test="${paging.beginBlock <= paging.pagePerBlock}">
								<li class="disable">이전</li>
							</c:when>
							<c:otherwise>
								<li><a href="admin_camping_gear_board.do?cPage=${paging.beginBlock - paging.pagePerBlock}">이전으로</a></li>
							</c:otherwise>
						</c:choose>
						<!-- 페이지번호들 -->
						<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock}" step="1" var="k">
							<c:choose>
								<c:when test="${k == paging.nowPage }">
									<li class="now">${k}</li>
								</c:when>
								<c:otherwise>
									<li><a href="admin_camping_gear_board.do?cPage=${k}">${k}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<!-- 이후 버튼 -->
						<c:choose>
							<c:when test="${paging.endBlock >= paging.totalPage }">
								<li class="disable">다음</li>
							</c:when>
							<c:otherwise>
								<li><a href="admin_camping_gear_board.do?cPage=${paging.beginBlock + paging.pagePerBlock }">다음으로</a></li>
							</c:otherwise>
						</c:choose>
					</ol>	
				</td>
				<td>
					<c:choose>
						<c:when test="${memberInfo != null || adminInfo != null || kakaoMemberInfo != null || naverMemberInfo != null}">
							<input type="button" id="btnWrite" value="글쓰기" onclick="camping_gear_write()">
						</c:when>
						<c:otherwise>
							<input type="button" id="btnWrite" value="글쓰기" onclick="camping_gear_write_alert()">
						</c:otherwise>
					</c:choose>
				</td>
				</tr>
			</tfoot>	
		</table>
		 </form>
	</div>
<%@ include file="../hs/profile_small_info.jsp" %>
</body>
</html>