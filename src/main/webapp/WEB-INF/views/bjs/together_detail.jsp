<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_detail.css">
<%@ include file="../hs/header.jsp" %>
</head>
<body>
<div class="toDetailContainer">
        <div class="togetherUpImg">
            <img src="${tvo.tf_name }" class="togetherUpImg2">
        </div>
        <form class="toDetailContent">
            <div class="toDetailContent1">
                <div class="userImage"><img src="${path}/resources/images/${tvo.member_img }" class="userImage2"></div>
                <div class="toContentOne1span">
                    <span class="to_member_nickname">${tvo.member_nickname }</span>
					<span class="to_member_age">(${tvo.member_dob })</span>
                </div>
                <input type="button" value="1:1 채팅하기" id="" onclick="" class="toDetailContent1Button toDetailContent1Button1">
                <input type="button" value="참가 신청하기" id="" onclick="" class="toDetailContent1Button toDetailContent1Button2">
                <span>${tvo.t_regdate }</span>
                <!-- <input type="button" value="참가 취소하기" id="" onclick=""> -->
            </div>
            <div class="toDetailContent2">
                <div class="toDetailContent2Sub1">
                	<img src="${tvo.tf_name }" class="togetherUpImg2">
                    <div class="toDetailContent2Sub1Div">
                        <h3>${tvo.t_subject }</h3>
                        <span>조회수&nbsp;${tvo.t_hit }</span>
                        <span>참여자&nbsp;1/${tvo.t_numpeople }명</span>
                    </div>
                    <pre class="toDetailTContent">${tvo.t_content }</pre>
                </div>
                <div class="toDetailContent2Sub2">
                    <h3>캠핑 일정</h3>
                    <p>캠핑장소&nbsp;${tvo.t_campname }</p>
                    <p>캠핑날짜&nbsp;${tvo.t_startdate } - ${tvo.t_enddate }</p>
                    <p>캠핑타입&nbsp;${tvo.t_camptype }</p>
                    <div class="toDetailContent2Sub2ImgDiv"><div id="map" class="toDetailContent2Sub2Img"></div></div>
                </div>
            </div>
            <div class="toDetailContent3">
            	<c:choose>
            		<c:when test="${memberUser.member_idx eq tvo.member_idx }">
		                <input type="button" value="수정하기" id="" onclick="" class="toDetailContent3Button">
            		</c:when>
            		<c:otherwise>
						            		
            		</c:otherwise>
            	</c:choose>
                <input type="button" value="목록보기" id="" onclick="" class="toDetailContent3Button">
            </div>
            <div class="toDetailContent4">
                <p class="toDetailContent4Sub1">댓글</p>
                <form >
                    <div class="toDetailInput">
                        <div class="userImageDiv2"><img src="${path}/resources/images/tree-4.jpg" class="userImage32"></div>
                        <input type="text" value="" id="" class="toDetailInputBox">
                        <input type="submit" value="입력" id="" class="toDetailInputBox toDetailInputSubmit">
                    </div>
                    <div class="toDetailContent4Sub2">
                        <div class="toDetailContent4Sub3">
                            <div class="toDetailContent4Sub2Sub1">
                                <div class="toDetailContent4Sub2Sub1Div">
                                    <div class="userImageDiv"><img src="${path}/resources/images/tree-4.jpg" class="userImage3"></div>
                                    <div>
                                        <strong>짱구</strong>
                                        <p>2024-04-23 16:53</p>
                                    </div>
                                </div>
                                <div class="toDetailContent4Sub2Sub2">
                                    <input type="button" value="답글 달기" id="" onclick=""
                                        class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                            <div class="toDetailContent4Sub2Sub3">
                                <div class="toDetailContent2Sub1Div2">
                                    <span class="toDetailContent2Sub1Div2Span">언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요?</span>
                                </div>
                                <div>
                                    <input type="button" value="X" id="" onclick="" class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                        </div>
                        <div class="toDetailContent4Sub3">
                            <div class="toDetailContent4Sub2Sub1">
                                <div class="toDetailContent4Sub2Sub1Div">
                                    <div class="userImageDiv"><img src="${path}/resources/images/tree-4.jpg" class="userImage3"></div>
                                    <div>
                                        <strong>짱구</strong>
                                        <p>2024-04-23 16:53</p>
                                    </div>
                                </div>
                                <div class="toDetailContent4Sub2Sub2">
                                    <input type="button" value="답글 달기" id="" onclick=""
                                        class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                            <div class="toDetailContent4Sub2Sub3">
                                <div class="toDetailContent2Sub1Div2">
                                    <span class="toDetailContent2Sub1Div2Span">언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요?</span>
                                </div>
                                <div>
                                    <input type="button" value="X" id="" onclick="" class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                        </div>
                        <div class="toDetailContent4Sub3">
                            <div class="toDetailContent4Sub2Sub1">
                                <div class="toDetailContent4Sub2Sub1Div">
                                    <div class="userImageDiv"><img src="${path}/resources/images/tree-4.jpg" class="userImage3"></div>
                                    <div>
                                        <strong>짱구</strong>
                                        <p>2024-04-23 16:53</p>
                                    </div>
                                </div>
                                <div class="toDetailContent4Sub2Sub2">
                                    <input type="button" value="답글 달기" id="" onclick=""
                                        class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                            <div class="toDetailContent4Sub2Sub3">
                                <div class="toDetailContent2Sub1Div2">
                                    <span class="toDetailContent2Sub1Div2Span">언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요?</span>
                                </div>
                                <div>
                                    <input type="button" value="X" id="" onclick="" class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </form>
    </div>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>