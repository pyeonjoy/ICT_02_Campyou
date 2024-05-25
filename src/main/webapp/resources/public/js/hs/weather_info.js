$(document).ready(function() {
	const locationMap = {
		    "서울": "11B10101",
		    "인천": "11B20201",
		    "부산": "11H20201",
		    "대구": "11H10701",
		    "대전": "11C20401",
		    "광주": "11F20501",
		    "울산": "11H20101",
		    "울릉도/독도": "11E00101",
		    "제주도": "11G00201"
		};
	
	for (const k in locationMap) {
	    let regId = locationMap[k];
	    let city = k;
	    getWeather(regId, city);
	}
	
	
	// 날짜 
	let lows_ta;
	let hight_ta;
	let dayLabel;
	let daydate;
	function numEfcheck(announceTime, numEf) {
		let uDate = new Date();
		
		let c_year = Math.floor(announceTime / 100000000);
		let c_month = Math.floor(announceTime % 100000000 / 1000000)
		let c_day = Math.floor(announceTime % 1000000 / 10000)
		
		let c_date = new Date(c_year, c_month, c_day);
		
		let timeonly = announceTime % 10000;
		
		if (500 <= timeonly && timeonly < 1100) {
			numEf % 2 == 0 ? daytime = "오전" :  daytime = "오후";
			switch (numEf) {
			case 0: 
			case 1: dayLabel = "오늘"; break;
			case 2: 
			case 3: dayLabel = "내일"; break;
			case 4: 
			case 5: dayLabel = "모레"; break;
			case 6: 
			case 7: dayLabel = "글피"; break;
			}
			
			
		} else if ((1100 <= timeonly && timeonly < 1700)  || (1700 <= timeonly || timeonly < 500)) {
			numEf % 2 == 0 ? daytime = "오후" :  daytime = "오전";
			switch (numEf) {
			case 0: dayLabel = "오늘"; break;
			case 1: 
			case 2: dayLabel = "내일"; break;
			case 3: 
			case 4: dayLabel = "모레"; break;
			case 5: 
			case 6: dayLabel = "글피"; break;
			case 7: 
			case 8: dayLabel = "그글피"; break;
			}
		} 
		
		switch (dayLabel) {
		case "오늘": uDate.setDate(c_date.getDate()); break;
		case "내일": uDate.setDate(c_date.getDate() + 1); break;
		case "모레": uDate.setDate(c_date.getDate() + 2); break;
		case "글피": uDate.setDate(c_date.getDate() + 3); break;
		case "그글피": uDate.setDate(c_date.getDate() + 4); break;
		}
		
		daydate = uDate.toLocaleDateString().slice(5,11);
	}
	
	
	function getWeather(regId, city) {
    	$.ajax({
		    url: 'get_weather.do',
		    method: 'post',
		    dataType: 'json',
		    data: { 
		    	regId: regId
		    },
		    success: function(data) {
		    	let items = data.response.body.items;
		        let weatherItem = "<div class='weather_info_container'>";
		        weatherItem += "<p>도시: " + city + "</p>";
		        $.each(items, function(index, item) {
		        	for (let i=0; i < item.length; i++) {
		        		let announceTime = item[i].announceTime;
			        	let numEf = item[i].numEf;
			        	 numEfcheck(announceTime, numEf);
			        	 weatherItem += "<p>날짜: " + daydate + "</p>";
			        	weatherItem += "<p>daytime: " + daytime + "</p>";
			        	weatherItem += "<p>dayLabel: " + dayLabel + "</p>";
			             weatherItem += "<p>온도: " + item[i].ta + "</p>";
			             weatherItem += "<p>날씨: " + item[i].wf + "</p>";
			             weatherItem += "<p>강수확률: " + item[i].rnSt + "%</p>";
			             weatherItem += "<hr>";
		        	}
		         });
		    	 weatherItem += "</div>";
		    	
		    	$("#weather_info").append(weatherItem);
		    },
		    error: function() {
		    	console.log("읽기 실패" + city);
		    }
    	});
   	}

	/*$(document).on('click', function(event) {
        if (!$('.profile_small_info_container').is(event.target) && !$('.profile_show').is(event.target)) {
            $('.profile_small_info_container').css('display', 'none');
        } else {
            return;
        }
    });*/
});
