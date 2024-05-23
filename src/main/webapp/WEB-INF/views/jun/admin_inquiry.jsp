<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../hs/admin_menu.jsp"%>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script defer src="${path}/resources/public/js/bm/lang/summernote-ko-KR.js"></script>
<script defer src="${path}/resources/public/js/bm/summernote-lite.js"></script>
<style type="text/css">
body {
	background-color: #F6FFF1;
}

.inquiry_wrap {
	padding: 165px 200px 44px 223px;
}

#qna_list {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	width: 100%;
	padding: 20px;
}

#qna_list table {
	width: 1500px;
	margin: 20px;
	border-collapse: collapse;
	background-color: #F6FFF1;
	text-align: center;
}

#qna_list table th {
	background-color: #032805;
	padding: .8rem 1rem;
	color: white;
}

#qna_list table td {
	padding: .8rem 1rem;
}

.nowpagecolor {
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	text-decoration: none;
	color: #FFBA34;
	font-size: 1.4rem;
}

.page_button {
	display: flex;
	justify-content: center;
	padding: 20px;
	flex-direction: row;
	margin-top: 20px;
}

.search_nowpagecolor {
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	text-decoration: none;
	color: #FFBA34;
	font-size: 1.4rem;
}

.search_page_button {
	display: flex;
	justify-content: center;
	padding: 20px;
	flex-direction: row;
	margin-top: 20px;
}

.page_button ul {
	display: flex;
	margin-top: -84px;
}

.search_page_button {
	display: flex;
	justify-content: center;
	padding: 20px;
	flex-direction: row;
	margin-top: 20px;
}

.search_page_button ul {
	display: flex;
	margin-top: -84px;
}

.search {
	display: flex;
	margin-right: 70%;
}

.search select, .search input, .search button {
	margin-right: 5px;
}

.nowpage {
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	color: black;
	text-decoration: none;
	font-size: 1.4rem;
}

.th_disable {
	color: silver;
	margin: 0 1rem;
	text-decoration: none;
}

.th_able {
	color: black;
	margin: 0 1rem;
	text-decoration: none;
}

.nowpage:hover {
	color: #FFBA34;
}

.search_nowpage {
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	color: black;
	text-decoration: none;
	font-size: 1.4rem;
}

.search_th_disable {
	color: silver;
	margin: 0 1rem;
	text-decoration: none;
}

.search_th_able {
	color: black;
	margin: 0 1rem;
	text-decoration: none;
}

.search_nowpage:hover {
	color: #FFBA34;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/80123590ac.js"
	crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function() {
		load_inquiry();
	});

	function load_inquiry(page) {
		$.ajax({
					url : "load_inquiry.do",
					method : "get",
					dataType : "json",
					data : {
						cPage : page
					},
					success : function(data) {
						$("#qna_list").empty();
						let list = '<div class="table_inquiry"><table>';
						list += "<thead><tr><th>번호</th><th>닉네임</th><th>제목</th><th>내용</th><th>날짜</th><th>상태</th></tr></thead><tbody>";
						$.each(data.res, function(index, item) {
			                list += '<tr onclick="inquiry_detail('+item.qna_idx+')">';
							list += '<td>' + item.qna_idx + '</td>';
							list += '<td>' + item.member_nickname + '</td>';
							list += '<td>' + item.qna_title + '</td>';
							let onlycontext = item.qna_content.replace(
									/<img[^>]*>/g, '');
							list += '<td>' + onlycontext + '</td>';
							list += '<td>' + item.qna_date + '</td>';
							if (item.qna_status === 0) {
								list += '<td>처리중</td>';
							} else if (item.qna_status === 1) {
								list += '<td>처리완료</td>';
							} else {
								list += '<td>알 수 없음</td>';
							}
							list += '</tr>';
						});
						list += '</tbody></table></div>';
						$("#qna_list").html(list);
						let paging = data.paging;
						$('.th_paging').empty();
						$('.search_th_paging').empty();
						let pagingHtml = '';
						if (paging.beginBlock <= paging.pagePerBlock) {
							pagingHtml += '<li class="th_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
							pagingHtml += '<li class="th_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
						} else {
							pagingHtml += '<li><a href="javascript:load_inquiry('
									+ 1
									+ ')" class="th_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
							pagingHtml += '<li><a href="javascript:load_inquiry('
									+ (paging.beginBlock - paging.pagePerBlock)
									+ ')" class="th_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
						}
						for (let k = paging.beginBlock; k <= paging.endBlock
								&& k <= paging.totalPage; k++) {
							if (k === paging.nowPage) {
								pagingHtml += '<li class="nowpagecolor">' + k
										+ '</li>';
							} else {
								pagingHtml += '<li><a href="javascript:load_inquiry('
										+ k
										+ ')" class="nowpage">'
										+ k
										+ '</a></li>';
							}
						}
						if (paging.endBlock >= paging.totalPage) {
							pagingHtml += '<li class="th_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
							pagingHtml += '<li class="th_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
						} else {
							pagingHtml += '<li><a href="javascript:load_inquiry('
									+ (paging.beginBlock + paging.pagePerBlock)
									+ ')" class="th_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
							pagingHtml += '<li><a href="javascript:load_inquiry('
									+ paging.totalPage
									+ ')" class="th_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
						}
						$('.th_paging').append(pagingHtml);
					},
					error : function() {
						alert("불러오는데 오류가 발생하셨습니다.")
					}
				});
	}

	function search_go(page) {
		let searchType = $("select[name='searchType']").val();
		let keywordInput = $("#keyword_input").val();
		$.ajax({
					url : "inquiry_search.do",
					method : "get",
					dataType : "json",
					data : {
						cPage : page,
						keywordInput : keywordInput,
						searchType : searchType
					},
					success : function(data) {
						$("#qna_list").empty();
						let list = '<div class="table_inquiry"><table>';
						list += "<thead><tr><th>번호</th><th>닉네임</th><th>제목</th><th>내용</th><th>날짜</th><th>상태</th></tr></thead><tbody>";
						$.each(data.res, function(index, item) {
							list += '<tr>';
							list += '<td>' + item.qna_idx + '</td>';
							list += '<td>' + item.member_nickname + '</td>';
							list += '<td>' + item.qna_title + '</td>';
							let onlycontext = item.qna_content.replace(
									/<img[^>]*>/g, '');
							list += '<td>' + onlycontext + '</td>';
							list += '<td>' + item.qna_date + '</td>';
							if (item.qna_status === 0) {
								list += '<td>처리중</td>';
							} else if (item.qna_status === 1) {
								list += '<td>처리완료</td>';
							} else {
								list += '<td>알 수 없음</td>';
							}
							list += '</tr>';
						});
						list += '</tbody></table></div>';
						$("#qna_list").html(list);
						let paging = data.paging;
						$('.th_paging').empty(); // 일반 리스트의 페이징
						$('.search_th_paging').empty(); // 검색 결과의 페이징
						let pagingHtml = '';
						// 이전 버튼
						if (paging.beginBlock <= paging.pagePerBlock) {
							pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
							pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
						} else {
							pagingHtml += '<li><a href="javascript:search_go('
									+ 1
									+ ')" class="search_th_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
							pagingHtml += '<li><a href="javascript:search_go('
									+ (paging.beginBlock - paging.pagePerBlock)
									+ ')" class="search_th_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
						}
						// 페이지번호들
						// 검색 결과의 페이징 버튼 클릭 시 search_go 함수 호출
						for (let k = paging.beginBlock; k <= paging.endBlock
								&& k <= paging.totalPage; k++) {
							if (k === paging.nowPage) {
								pagingHtml += '<li class="search_nowpagecolor">'
										+ k + '</li>';
							} else {
								pagingHtml += '<li><a href="javascript:search_go('
										+ k
										+ ')" class="search_nowpage">'
										+ k
										+ '</a></li>';
							}
						}

						// 이후 버튼
						if (paging.endBlock >= paging.totalPage) {
							pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
							pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
						} else {
							pagingHtml += '<li><a href="javascript:search_go('
									+ (paging.beginBlock + paging.pagePerBlock)
									+ ')" class="search_th_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
							pagingHtml += '<li><a href="javascript:search_go('
									+ paging.totalPage
									+ ')" class="search_th_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
						}
						console.log(paging.nowPage);
						$('.th_paging').append(pagingHtml);
					},
					error : function() {
						alert("불러오는데 오류가 발생하셨습니다.")
					}
				});
	}
	
	 function inquiry_detail(qna_idx) {
	        $.ajax({
	            url: "inquiry_detail.do",
	            method: "get",
	            data: { qna_idx: qna_idx },
	            dataType: "json",
	            success: function(data) {
	                $("#qna_list").empty();
	                $('.th_paging').empty();
	                $('.search_th_paging').empty();
	                $('.search').empty();
	                console.log(data);
	                let list = '';
	                list += '<div class="detail_info">';
	                list += '<p><strong>번호:</strong> ' + data.qna_idx + '</p>';
	                list += '<p><strong>닉네임:</strong> ' + data.member_nickname + '</p>';
	                list += '<p><strong>제목:</strong> ' + data.qna_title + '</p>';
	                list += '<p><strong>내용:</strong> ' + data.qna_content + '</p>';
	                list += '<p><strong>날짜:</strong> ' + data.qna_date + '</p>';
					if (data.qna_status === '0') {
						list += '<p>처리중</p>';
					} else if (data.qna_status === '1') {
						list += '<p>처리완료</p>';
					} else {
						list += '<p>알 수 없음</p>';
					}
					list += '</div>';
					list += 
	                $("#qna_list").html(list);
	            },
	            error: function() {
	                console.log("실패");
	            }
	        });
	    }

	
</script>



<title>관리자 - 1:1 문의</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico"
	type="image/x-icon">
<link rel="icon" href="${path}/resources/images/favicon.ico"
	type="image/x-icon">
</head>
<body>
	<div class="inquiry_wrap">
		<h3 style="text-align: center;">문의 내역</h3>
		<div id="qna_list">
			<!-- 리스트 -->
		</div>
		<div class="search">
			<select name="searchType">
				<option value="nickname">닉네임</option>
				<option value="content">내용</option>
			</select> <input type="text" id="keyword_input">
			<button onclick="search_go()">검색</button>
		</div>
		<div class="page_button">
			<ul class="th_paging">
				<!-- 기본 페이징 -->
			</ul>
		</div>
		<div class="search_page_button">
			<ul class="search_th_paging">
				<!-- 검색 페이징 -->
			</ul>
		</div>
	</div>
</body>
</html>