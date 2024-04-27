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
<style>
    * {
        margin: 0px;
        padding: 0px;
        box-sizing: border-box;
    }
    .towContainer {
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .togetherh2 {
        width: 100%;
        text-align: right;
        margin: 5rem auto;
    }
    .togetherWriteForm{
        width: 80%;
        display: flex;
        justify-content: center;
    }
   .togetherWriteInput{
       width: 50%;
       display: flex;
       flex-direction: column;
       padding-right: 8rem;
       align-items: center;
   }
   .togetherWriteInputSubmit{
        width: 10rem;
        height: 1.7rem;
        border: none;
        background-color: #032805;
        color: white;
        margin: 2rem 0;
   }
   .togetherWriteInput1{
        border: none;
        border-bottom: 1px solid black;
        padding-bottom: 0.7rem;
        width: 100%;
   }
   .togetherWriteInput2{
        border: none;
        height: 60vh;
        margin-top: 1rem;
        width: 100%;
   }
   .togetherWriteSelect{
        border: 1px solid black;
        border-radius: 5%;
        padding: 3rem;
        width: 26%;
        margin-top: 5rem;
   }
   .togetherWriteSelect > *:not(:last-child){
        margin-bottom: 1rem;
    }
    .togetherSub1{
        margin-top: 1rem;
        display: flex;
    }
    .togetherSub1Img{
        max-width: 100%;
     max-height: 100%;
    }
    .togetherSub1Button{
        border: none;
        border-radius: 50%;
        background-color: #FFFDDE;
        padding: 0.4rem 1.2rem;
        cursor: pointer;
        margin-right: 1rem;
    }
    .togetherSub1Button:hover{
        background-color: #032805;
        color: white;
    }
    .togetherSub1Div{
        margin-left: 1rem;
        align-items: center;
    }
    .togetherSub1DivInput{
        height: 1.5rem;
        margin-bottom: 0.5rem;
    }
    .togetherSub1DivButton{
        height: 1.5rem;;
        border: none;
        background-color: #032805;
        color: white;
        width: 2.7rem;
    }
</style>
</head>
<body>
	<div class="towContainer">
	    <form class="togetherWriteForm">
	        <div class="togetherWriteInput">
	            <div class="togetherh2">
	                <h2>동 행 작성하기</h2>
	            </div>
	            <input type="text" value="" id="" onclick="" class="togetherWriteInput1" placeholder="제목을 입력하세요" required>
	            <textarea class="togetherWriteInput2" id="" placeholder="내용을 입력하세요" required></textarea>
	            <input type="submit" value="작성하기" id="" class="togetherWriteInputSubmit">
	        </div>
	        <div class="togetherWriteSelect">
	            <strong>캠핑타입</strong>
	            <div class="togetherSub1">
	                <input type="button" value="카라반" id="" class="togetherSub1Button">
	                <input type="button" value="글램핑" id="" class="togetherSub1Button">
	                <input type="button" value="야영지" id="" class="togetherSub1Button">
	            </div>
	            <div class="togetherSub1">
	                <strong>캠핑장</strong>
	                <div class="togetherSub1Div">
	                    <input type="text" value="" id="" placeholder="캠핑장 이름" class="togetherSub1DivInput">
	                    <input type="button" value="검색" id="" class="togetherSub1DivButton">
	                    <p>서울특별시 강서구 화곡동</p>
	                    <p>426-85</p>
	                </div>
	            </div>
	            <div>
	                <img src="${path}/resources/images/tree-4.jpg" class="togetherSub1Img">
	            </div>
	            <div class="togetherSub1">
	                <strong>캠핑인원</strong>
	                <span>&nbsp;&nbsp;4명</span>
	            </div>
	            <div class="togetherSub1">
	                <strong>캠핑기간</strong>
	                <span>&nbsp;&nbsp;2024/04/23 - 2024/04/26</span>
	            </div>
	            <div>
	                <p>2024년 4월 23일 - 2024년 4월 26일</p>
	                <img src="${path}/resources/images/tree-4.jpg" class="togetherSub1Img">
	            </div>
	        </div>
	    </form>
	</div>
</body>
</html>