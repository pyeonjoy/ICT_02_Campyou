<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="resources/public/css/hs/camp_search_box.css">
<script type="text/javascript">
$(document).ready(function() {
	$.ajax({
	    url: "camp_search_box_sido.do",
	    method: "post",
	    dataType: "xml",
	    success: function(data) {
	    	let option = "";
	        $(data).find("sido").each(function() {
		    	option += "<option value=\""+ $(this).text() +"\">"+ $(this).text() + "</option>";
	            
	        });
	        $("#sido_search").append(option);
	    },
	    error: function() {
	    	console.log("읽기 실패");
	    }
	});
	
	$("#sido_search").change(function(){
		let selectSido= $(this).val();
		$("#sigungu_search").empty();
		$.ajax({
		    url: "camp_search_box_sigungu.do",
		    method: "post",
		    dataType: "xml",
		    success: function(data) {
		    	let option = "<option>전체</option>";
		        $(data).find(selectSido).each(function() {
		        	$(this).find("sigungu").each(function() {
			        	let sigungu = $(this).text();
				    	option += "<option value=\""+ sigungu +"\">"+ sigungu + "</option>";
		            
			        });
		        });
		        $("#sigungu_search").append(option);
		    },
		    error: function() {
		    	console.log("읽기 실패");
		    }
		});		
	});
	
	$("#detail_search").click(function(){
		console.log("클릭")
      	$(".search_button_option").toggle();
    });
});
</script>
</head>
<body>
	<div>
		<div class="search_wrap">
			<select id="sido_search" name="sido_search">
				<option>전체</option>
			</select> 
			
			<select id="sigungu_search" name="sigungu_search">
				<option>전체</option>
			</select>
			
			<input type="text" id="keyword_input" placeholder="검색어를 입력하세요">
			<input type="button" value="상세조건+" id="detail_search">
			<button id="search_button" type="submit" onclick="list_search()">검색</button>
		</div>
		<div class="search_button_option">
			<div class="option">
				<div class="option_title">
					<h5>입지구분</h5>
				</div>
				<div class="option_checkbox lct">
					<ul>
						<li><input type="checkbox" name="lctCl" id="lctcl01"
							value="해변"><label for="lctcl01">해변</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl02"
							value="섬"><label for="lctcl02">섬</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl03"
							value="산"><label for="lctcl03">산</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl04"
							value="숲"><label for="lctcl04">숲</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl05"
							value="계곡"><label for="lctcl05">계곡</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl06"
							value="강"><label for="lctcl06">강</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl07"
							value="호수"><label for="lctcl07">호수</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl08"
							value="도심"><label for="lctcl08">도심</label></li>
					</ul>
				</div>
			</div>
			<div class="option">
				<div class="option_title">
					<h5>주요시설</h5>
				</div>
				<div class="option_checkbox induty">
					<ul>
						<li><input type="checkbox" name="induty" id="induty01"
							value="일반야영장"><label for="induty01">일반야영장</label></li>
						<li><input type="checkbox" name="induty" id="induty02"
							value="자동차야영장"><label for="induty02">자동차야영장</label></li>
						<li><input type="checkbox" name="induty" id="induty03"
							value="카라반"><label for="induty03">카라반</label></li>
						<li><input type="checkbox" name="induty" id="induty04"
							value="글램핑"><label for="induty04">글램핑</label></li>
					</ul>
				</div>
			</div>
			<div class="option">
				<div class="option_title">
					<h5>부대시설</h5>
				</div>
				<div class="option_checkbox sbrsd">
					<ul>
						<li><input type="checkbox" name="sbrscl" id="sbrsd01"
							value="놀이터"><label for="sbrsd01">놀이터</label></li>
						<li><input type="checkbox" name="sbrscl" id="sbrsd02"
							value="덤프스테이션"><label for="sbrsd02">덤프스테이션</label></li>
						<li><input type="checkbox" name="sbrscl" id="sbrsd03"
							value="마트.편의점"><label for="sbrsd03">마트.편의점</label></li>
						<li><input type="checkbox" name="sbrscl" id="sbrsd04"
							value="무선인터넷"><label for="sbrsd04">무선인터넷</label></li>
						<li><input type="checkbox" name="sbrscl" id="sbrsd05"
							value="물놀이장"><label for="sbrsd05">물놀이장</label></li>
						<li><input type="checkbox" name="sbrscl" id="sbrsd06"
							value="산책로"><label for="sbrsd06">산책로</label></li>
						<li><input type="checkbox" name="sbrscl" id="sbrsd07"
							value="온수"><label for="sbrsd07">온수</label></li>
						<li><input type="checkbox" name="sbrscl" id="sbrsd08"
							value="운동장"><label for="sbrsd08">운동장</label></li>
						<li><input type="checkbox" name="sbrscl" id="sbrsd09"
							value="운동시설"><label for="sbrsd09">운동시설</label></li>
						<li><input type="checkbox" name="sbrscl" id="sbrsd10"
							value="전기"><label for="sbrsd10">전기</label></li>
						<li><input type="checkbox" name="sbrscl" id="sbrsd11"
							value="장작판매"><label for="sbrsd11">장작판매</label></li>
						<li><input type="checkbox" name="sbrscl" id="sbrsd12"
							value="트렘폴린"><label for="sbrsd12">트렘폴린</label></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>