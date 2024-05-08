<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠핑추천검색정보</title>
<%-- <%@ include file="../../hs/header.jsp" %>  --%>
<link rel="stylesheet" href="${path}/resources/public/css/hu/campingGear/campingGearSearchList.css">
<script type="text/javascript">
    // 전체 페이지를 계산하는 함수
    function calculateTotalPages(totalItems, pageSize) {
        return Math.ceil(totalItems / pageSize);
    }

    // 페이지 버튼 생성 함수
    function generatePaginationButtons(totalPages) {
        const paginationDiv = document.querySelector(".pagination");
        paginationDiv.innerHTML = ''; // Clear existing buttons
        
        for (let i = 1; i <= totalPages; i++) {
            const button = document.createElement("button");
            button.classList.add("pagination-button");
            button.setAttribute("id", "page" + i);
            button.setAttribute("data-page", i);
            button.textContent = i;
            paginationDiv.appendChild(button);
        }
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

    // 5개글당 한 페이지
    const pageSize = 5; 
    window.onload = function() {
        let rows = document.querySelectorAll("tbody tr");
        let totalItems = rows.length;
        let totalPages = calculateTotalPages(totalItems, pageSize);

        // 페이지 버튼 생성
        generatePaginationButtons(totalPages);

        // 첫번째 페이지 구현
        goToPage(1, pageSize);

        //페이지 버튼에 클릭이벤트 추가하기!
        const paginationButtons = document.querySelectorAll(".pagination-button");
        paginationButtons.forEach(function(button) {
            button.addEventListener("click", function() {
                let pageNumber = parseInt(this.getAttribute("data-page"));
                goToPage(pageNumber, pageSize);
            });
        });
    };
</script>
<script type="text/javascript">
	function camping_gear_board(f) {
		f.action="camping_gear_board.do";
		f.submit()
	}
</script>
</head>
<body>
	<!-- 여기서부터 해더 푸터 만들어보기  -->
	<div id="aa"> <!-- aa는 이건 내가 만든것 -->
        <h2><a href="camping_gear_board.do">게시판 돌아가기</a></h2>
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
        <form action="post">
       <!--  <span id="btn-position">
            <input id="btn" type="button" value="목록" onclick="camping_gear_board(this.form)" />
        </span> -->
        </form>
	    <!-- Pagination -->
	    <div class="pagination">
	    </div>
    </div>
 <%-- <%@ include file="../../hs/footer.jsp" %>  --%>
</body>
</html>
