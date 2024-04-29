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
<%@ include file="../hs/header.jsp" %>
<style>
        * {
            margin: 0px;
            padding: 0px;
            box-sizing: border-box;
        }
        .toDetailContainer{
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        .togetherUpImg{
            width: 100%;
        }
        .togetherUpImg2{
            max-width: 100%;
            max-height: 30vh;
            object-fit: cover;
            width: 100%;
        }
        .toDetailContent{
            width: 50%;
            
        }
        .toDetailContent1{
            width: 100%;
            display: flex;
            border-bottom: 1px solid black;
            padding: 0.8rem 0;
            margin-bottom: 2.5rem;
        }
        .toDetailContent1 > * {
            margin-right: 2rem;
        }
        .userImage{
            border: 1px solid black;
            border-radius: 50%;
            width: 10rem;
            height: 10rem;
            margin-right: 1rem;
            position:absolute;
            /* top: 11.5rem;
            left: 23rem; */
            top: 9.9vw;
            left: 42vh;
        }
        .userImage2{
            max-width: 100%;
	        max-height: 100%;
            width: 10rem;
            height: 10rem;
            border-radius: 50%;
            position: relative;
        }
        .toDetailContent1Button{
            min-width: 7rem;
            border: none;
            cursor: pointer;
        }
        .toDetailContent1Button1{
            background-color: #FAAB12;
            color: white;
        }
        .toDetailContent1Button2{
            background-color: #032805;
            color: white;
        }
        .toContentOne1span{
            display: flex;
            flex-direction: column;
            margin-left: 5.5rem;
        }
        .toDetailContent2{
            display: grid;
            grid-template-columns: 6fr 4fr;
        }
        .toDetailInput{
            width: 100%;
            display: grid;
            grid-template-columns: 3rem 20fr 1fr;
            gap: 1rem;
            padding-bottom: 2rem;
            border-bottom: 1px solid black;
            align-items: center;
        }
        .toDetailInputBox{
            height: 2rem;
        }
        .toDetailInputSubmit{
            background-color: #FAAB12;
            border: none;
            font-weight: bold;
            cursor: pointer;
        }
        .toDetailContent2Sub1{
            padding-right: 2rem;
        }
        .toDetailContent2Sub1Div{
            line-height: 2.3rem;
            margin-bottom: 1rem;
        }
        .toDetailContent2Sub2{
            border: 1px solid black;
            border-radius: 5%;
            padding: 1.2rem;
        }
        .toDetailContent2Sub2 > *:not(:last-child){
            margin-bottom: 1rem;
        }
        .toDetailContent2Sub2Img{
            max-width: 100%;
            max-height: 30vh;
        }
        .toDetailContent3{
            padding: 2rem 0;
            display: flex;
            justify-content: flex-end;
            border-bottom: 10px solid rgb(240, 240, 240);
        }
        .toDetailContent3Button{
            min-width: 7rem;
            height: 1.7rem;
            border: none;
            background-color: #032805;
            color: white;
            cursor: pointer;
        }
        .toDetailContent4{
            margin: 3rem 0;
        }
        .toDetailContent4Sub1{
            padding: 1rem;
            padding-left: 0.5rem;
        }
        .userImageDiv{
            border: 1px solid black;
            border-radius: 50%;
            width: 3rem;
            height: 3rem;
            margin-right: 1rem;
        }
        .userImage3{
            max-width: 100%;
	        max-height: 100%;
            width: 3rem;
            height: 3rem;
            border-radius: 50%;
        }
        .userImageDiv2{
            border: 1px solid black;
            border-radius: 50%;
            width: 2.3rem;
            height: 2.3rem;
            margin: 0 0.3rem;
        }
        .userImage32{
            max-width: 100%;
	        max-height: 100%;
            width: 2.3rem;
            height: 2.3rem;
            border-radius: 50%;
        }
        .toDetailContent4Sub2Sub1{
            display: flex;
            justify-content: space-between;
        }
        .toDetailContent4Sub2Sub1Div{
            display: flex;
            align-items: center;
        }
        .toDetailContent2Sub1Div2{
            display: flex;
            margin-top: 0.7rem;
            align-items: center;
        }
        .toDetailContent4Sub3{
            padding: 1rem 0;
            border-bottom: 1px solid lightgray;
        }
        .toDetailContent4Sub2Sub2{
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .toDetailContent2Sub1Div2Span{
            padding-right: 1rem;
        }
        .toDetailContent4Sub2Sub3{
            display: flex;
            width: 100%;
            justify-content: space-between;
            align-items: center;
        }
        .toDetailContent4Sub2Sub2Button{
            border: none;
            background-color: white;
            width: 75px;
            height: 1.2rem;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="toDetailContainer">
        <div class="togetherUpImg">
            <img src="${path}/resources/images/tree-4.jpg" class="togetherUpImg2">
        </div>
        <form class="toDetailContent">
            <div class="toDetailContent1">
                <div class="userImage"><img src="${path}/resources/images/tree-4.jpg" class="userImage2"></div>
                <div class="toContentOne1span">
                    <strong>호야</strong>
                    <p>3일전</p>
                </div>
                <input type="button" value="1:1 채팅하기" id="" onclick="" class="toDetailContent1Button toDetailContent1Button1">
                <input type="button" value="참가 신청하기" id="" onclick="" class="toDetailContent1Button toDetailContent1Button2">
                <!-- <input type="button" value="참가 취소하기" id="" onclick=""> -->
            </div>
            <div class="toDetailContent2">
                <div class="toDetailContent2Sub1">
                    <div class="toDetailContent2Sub1Div">
                        <h2>같이 캠핑 가실분</h2>
                        <span>조회수&nbsp;55</span>
                        <span>참여자&nbsp;5/20명</span>
                    </div>
                    <p>
                        같이 캠핑 가실분 구합니다 편하게 연락주세요 장소에 모여 차타고 같이 출발해요 같이 캠핑 가실분 구합니다 편하게 연락주세요 장소에 모여 차타고 같이 출발해요
                        같이 캠핑 가실분 구합니다 편하게 연락주세요 장소에 모여 차타고 같이 출발해요 같이 캠핑 가실분 구합니다 편하게 연락주세요 장소에 모여 차타고 같이 출발해요 
                        같이 캠핑 가실분 구합니다 편하게 연락주세요 장소에 모여 차타고 같이 출발해요 같이 캠핑 가실분 구합니다 편하게 연락주세요 장소에 모여 차타고 같이 출발해요
                        같이 캠핑 가실분 구합니다 편하게 연락주세요 장소에 모여 차타고 같이 출발해요 같이 캠핑 가실분 구합니다 편하게 연락주세요 장소에 모여 차타고 같이 출발해요
                    </p>
                </div>
                <div class="toDetailContent2Sub2">
                    <h2>캠핑 일정</h2>
                    <p>캠핑장소&nbsp;난지중앙캠핑장</p>
                    <p>캠핑날짜&nbsp;2024/04/25 - 2024/04/27</p>
                    <p>캠핑타입&nbsp;카라반</p>
                    <div class="toDetailContent2Sub2ImgDiv"><img src="${path}/resources/images/tree-4.jpg" class="toDetailContent2Sub2Img"></div>
                </div>
            </div>
            <div class="toDetailContent3">
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