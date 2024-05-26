<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 게시판 검색</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${path}/resources/public/css/hu/searchLists.css">
<script type="text/javascript">
    // 전체 페이지를 계산하는 함수
    function calculateTotalPages(totalItems, pageSize) {
        return Math.ceil(totalItems / pageSize);
    }
    // 페이지 버튼 생성 함수
    function generatePaginationButtons(totalPages, currentPage) {
        const paginationDiv = document.querySelector(".pagination");
        paginationDiv.innerHTML = ''; 

        //이전버튼
        const prevButton = document.createElement("button");
        prevButton.classList.add("prev");
        prevButton.textContent = "이전";
        prevButton.onclick = prevPage;
        paginationDiv.appendChild(prevButton);
        //현재버튼
        let startPage = Math.max(1, currentPage - 1);
        let endPage = Math.min(totalPages, startPage + 2);
        for (let i = startPage; i <= endPage; i++) {
            const button = document.createElement("button");
            button.classList.add("pagination-button");
            button.setAttribute("id", "page" + i);
            button.setAttribute("data-page", i);
            button.textContent = i;
            button.onclick = function() {
                goToPage(i, pageSize);
            };
            paginationDiv.appendChild(button);
        }
        //다음버튼
        const nextButton = document.createElement("button");
        nextButton.classList.add("next");
        nextButton.textContent = "다음";
        nextButton.onclick = nextPage;
        paginationDiv.appendChild(nextButton);
    }

    // 페이지버튼 클릭할때 조정하는 함수
    function goToPage(pageNumber, pageSize) {
        let startIdx = (pageNumber - 1) * pageSize;
        let endIdx = startIdx + pageSize;
        let rows = document.querySelectorAll("tbody tr");

        rows.forEach(function(row, index) {
            if (index >= startIdx && index < endIdx) {
                row.style.display = "table-row";
            } else {
                row.style.display = "none";
            }
        });
        // 페이지 버튼 업데이트
        let paginationButtons = document.querySelectorAll(".pagination-button");
        paginationButtons.forEach(function(button) {
            button.classList.remove("active");
        });
        document.getElementById("page" + pageNumber).classList.add("active");
    }

    // 3개글당 한 페이지
    const pageSize = 5; 
    let currentPage = 1;
    let totalPages;
    window.onload = function() {
        let rows = document.querySelectorAll("tbody tr");
        let totalItems = rows.length;
        totalPages = calculateTotalPages(totalItems, pageSize);

        // 페이지 버튼 생성
        generatePaginationButtons(totalPages, currentPage);

        // 첫번째 페이지 구현
        goToPage(currentPage, pageSize);
    };
    function nextPage() {
        let paginationDiv = document.querySelector(".pagination");
        if (currentPage + 3 <= totalPages) {
            currentPage += 3;
            paginationDiv.innerHTML = '';
            generatePaginationButtons(totalPages, currentPage);
            goToPage(currentPage, pageSize);
        }
    }
    function prevPage() {
        let paginationDiv = document.querySelector(".pagination");
        if (currentPage - 3 > 0) {
            currentPage -= 3;
            paginationDiv.innerHTML = '';
            generatePaginationButtons(totalPages, currentPage);
            goToPage(currentPage, pageSize);
        }
    }
</script>
<style>
	body{
		  background-color: #F6FFF1;
		}
</style>
</head>
<body>
	<div id="aa">
        <h2><a href="admin_camping_gear_board.do">관리자 캠핑추천 게시판 돌아가기</a></h2>
        <article>
            <table>
                <thead>
                    <tr><td>닉네임</td><td>제목</td><td>내용</td><td>날짜</td></tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty searchlist}">
                            <tr><td colspan="5"><h3>원하시는 자료는 존재하지 않습니다</h3></td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${searchlist}" var="k">
                                <tr>
                                    <td>${k.member_nickname}</td>
                                    <td>${k.cp_subject}</td>
                                    <td>${k.cp_content}</td>
                                    <td>${k.cp_regdate.substring(0,10)}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </article>
	    <div class="pagination">
	    </div>
    </div>
 <%-- <%@ include file="../../hs/footer.jsp" %>  --%>
</body>
</html>
