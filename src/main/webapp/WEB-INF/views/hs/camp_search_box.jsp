<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
#detail_search, #search_button {
	padding: 10px;
	width: 100px;
}

.search_wrap {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin: 20px;
}

.search_button_option {
	display: flex;
	text-align: center;
	flex-direction: column;
	max-width: 800px;
}

.search_wrap select {
	width: 100px;
}

#keyword_input {
	width: 300px;
}

.search_button_option .option {
	height: auto;
	text-align: center;
	float: left;
	border-top: 10px;
	border-radius: 10px;
	box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23);
	margin-bottom: 20px;
}

.search_button_option .option_title {
	width: 100%;
	height: 36px;
	background-color: #FFBA34;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	text-align: center;
	padding: 10px;
}

.option_title h5 {
	font-size: 16px;
}


.option_checkbox{
    list-style: none;
    margin: 10px;
    display: flex;
}

.option li {
    padding: 10px;
    overflow: hidden;
    float: left;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	$("#sido_search").empty();
	$.ajax({
	    url: "camp_search_box_SiDo_json.do",
	    method: "post",
	    dataType: "json",
	    success: function(data) {
		    let option = "<option>전체</option>";
	        $.each(data.response.result.featureCollection.features, function(index, feature) {
	            let ctp_kor_nm =  feature.properties.ctp_kor_nm;
	            
		    	option += "<option value=\""+ ctp_kor_nm +"\">"+ ctp_kor_nm + "</option>";
	            
	        });
	        $("#sido_search").append(option);
	    },
	    error: function() {
	    	console.log("읽기 실패");
	    }
	});
	/*  */
	$("#sigungu_search").on("click", function() {
		let sido_selected = $("#sido_search option:selected").val();
		console.log(sido_selected)
		$("#sigungu_search").empty();
		$.ajax({
		    url: "camp_search_box_SiGunGu_json.do",
		    method: "post",
		    dataType: "json",
		    data: { sido_selected: sido_selected },
		    success: function(data) {
			    let option = "<option>전체</option>";
		        $.each(data.response.result.featureCollection.features, function(index, feature) {
		            let sig_kor_nm = feature.properties.sig_kor_nm;
		            console.log("sss" + sig_kor_nm)
			    	option += "<option value=\""+ sig_kor_nm +"\">"+ sig_kor_nm + "</option>";
		            
		        });
		        $("#sigungu_search").append(option);
		    },
		    error: function() {
		    	console.log("읽기 실패");
		    }
		});
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
			<button id="search_button">검색</button>
		</div>
		<div class="search_button_option">
			<div class="option">
				<div class="option_title">
					<h5>입지구분</h5>
				</div>
				<div class="option_checkbox lct">
					<ul>
						<li><input type="checkbox" name="lctCl" id="lctcl01"
							value="lctcl01"><label for="lctcl01">해변</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl02"
							value="lctcl02"><label for="lctcl02">섬</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl03"
							value="lctcl03"><label for="lctcl03">산</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl04"
							value="lctcl04"><label for="lctcl04">숲</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl05"
							value="lctcl05"><label for="lctcl05">계곡</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl06"
							value="lctcl06"><label for="lctcl06">강</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl07"
							value="lctcl07"><label for="lctcl07">호수</label></li>
						<li><input type="checkbox" name="lctCl" id="lctcl08"
							value="lctcl08"><label for="lctcl08">도심</label></li>
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
							value="induty01"><label for="induty01">일반야영장</label></li>
						<li><input type="checkbox" name="induty" id="induty02"
							value="induty02"><label for="induty02">자동차야영장</label></li>
						<li><input type="checkbox" name="induty" id="induty03"
							value="induty03"><label for="induty03">카라반</label></li>
						<li><input type="checkbox" name="induty" id="induty04"
							value="induty04"><label for="induty04">글램핑</label></li>
					</ul>
				</div>
			</div>
			<div class="option">
				<div class="option_title">
					<h5>부대시설</h5>
				</div>
				<div class="option_checkbox sbrsd">
					<ul>
						<li><input type="checkbox" name="sbrsd" id="sbrsd01"
							value="sbrsd01"><label for="sbrsd01">놀이터</label></li>
						<li><input type="checkbox" name="sbrsd" id="sbrsd02"
							value="sbrsd02"><label for="sbrsd02">덤프스테이션</label></li>
						<li><input type="checkbox" name="sbrsd" id="sbrsd03"
							value="sbrsd03"><label for="sbrsd03">마트, 편의점</label></li>
						<li><input type="checkbox" name="sbrsd" id="sbrsd04"
							value="sbrsd04"><label for="sbrsd04">무선인터넷</label></li>
						<li><input type="checkbox" name="sbrsd" id="sbrsd05"
							value="sbrsd05"><label for="sbrsd05">물놀이장</label></li>
						<li><input type="checkbox" name="sbrsd" id="sbrsd06"
							value="sbrsd06"><label for="sbrsd06">산책로</label></li>
						<li><input type="checkbox" name="sbrsd" id="sbrsd07"
							value="sbrsd07"><label for="sbrsd07">온수</label></li>
						<li><input type="checkbox" name="sbrsd" id="sbrsd08"
							value="sbrsd08"><label for="sbrsd08">운동장</label></li>
						<li><input type="checkbox" name="sbrsd" id="sbrsd09"
							value="sbrsd09"><label for="sbrsd09">운동시설</label></li>
						<li><input type="checkbox" name="sbrsd" id="sbrsd10"
							value="sbrsd10"><label for="sbrsd10">전기</label></li>
						<li><input type="checkbox" name="sbrsd" id="sbrsd11"
							value="sbrsd11"><label for="sbrsd11">장작판매</label></li>
						<li><input type="checkbox" name="sbrsd" id="sbrsd12"
							value="sbrsd12"><label for="sbrsd12">트렘폴린</label></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>