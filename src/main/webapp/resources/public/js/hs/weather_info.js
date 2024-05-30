$(document).ready(function () {
	let daydate = "";
	let dayweek = "";
	let timeonly = 0;
	let tmFc = "";
	let daylabel = "";
    const regions = [
        { city: "서울", taRegId: "11B10101", wfRegId: "11B00000" },
        { city: "춘천", taRegId: "11D10301", wfRegId: "11D10000" },
        { city: "강릉", taRegId: "11D20501", wfRegId: "11D20000" },
        { city: "대전", taRegId: "11C20401", wfRegId: "11C20000" },
        { city: "청주", taRegId: "11C10301", wfRegId: "11C10000" },
        { city: "광주", taRegId: "11F20501", wfRegId: "11F20000" },
        { city: "전주", taRegId: "11F10201", wfRegId: "11F10000" },
        { city: "대구", taRegId: "11H10701", wfRegId: "11H10000" },
        { city: "부산", taRegId: "11H20201", wfRegId: "11H20000" },
        { city: "제주", taRegId: "11G00201", wfRegId: "11H20000" }
    ];

    regions.forEach(region => {
        let taRegId = region.taRegId;
        let city = region.city;
        let wfRegId = region.wfRegId;
        getWeather(city, taRegId, wfRegId);
    });


    function getDate(announceTime, numEf) {
    	let uDate = new Date();
        let c_year = Math.floor(announceTime / 100000000);
        let c_month = Math.floor(announceTime % 100000000 / 1000000)
        let c_day = Math.floor(announceTime % 1000000 / 10000)

        let c_date = new Date(c_year, c_month, c_day);
        timeonly = announceTime % 10000;

        if (500 <= timeonly && timeonly < 1100) {
            numEf % 2 == 0 ? daytime = "오전" : daytime = "오후";
            switch (numEf) {
                case 0:
                case 1: daylabel = "오늘"; break;
                case 2:
                case 3: daylabel = "내일"; break;
                case 4:
                case 5: daylabel = "모레"; break;
                case 6:
                case 7: daylabel = "글피"; break;
            }
        } else if ((1100 <= timeonly && timeonly < 1700) || (1700 <= timeonly || timeonly < 500)) {
            numEf % 2 == 0 ? daytime = "오후" : daytime = "오전";
            switch (numEf) {
                case 0: daylabel = "오늘"; break;
                case 1:
                case 2: daylabel = "내일"; break;
                case 3:
                case 4: daylabel = "모레"; break;
                case 5:
                case 6: daylabel = "글피"; break;
                case 7:
                case 8: daylabel = "그글피"; break;
            }
        }

        switch (daylabel) {
            case "오늘": uDate.setDate(c_date.getDate()); break;
            case "내일": uDate.setDate(c_date.getDate() + 1); break;
            case "모레": uDate.setDate(c_date.getDate() + 2); break;
            case "글피": uDate.setDate(c_date.getDate() + 3); break;
            case "그글피": uDate.setDate(c_date.getDate() + 4); break;
        }
        daydate = uDate.toLocaleDateString().slice(5, 11);

        switch (uDate.getDay()) {
            case 0: dayweek = "일"; break;
            case 1: dayweek = "월"; break;
            case 2: dayweek = "화"; break;
            case 3: dayweek = "수"; break;
            case 4: dayweek = "목"; break;
            case 5: dayweek = "금"; break;
            case 6: dayweek = "토"; break;
        }
    }

    function getWeather(city, taRegId, wfRegId) {
        let olddate = "";
        let announceTime = 0;
        $.ajax({
            url: 'get_weather_3.do',
            method: 'post',
            dataType: 'json',
            data: {
                regId: taRegId
            },
            success: function (data) {
                let items = data.response.body.items;
                let weatherItem = "<div class='weather_info_items " + taRegId + "'>";
                weatherItem += "<h5>" + city + "</h5>";

                weatherItem += "<div class='week_one_line'>";
                weatherItem += "<ul class='week_items'>";
                $.each(items, function (index, item) {
                    for (let i = 0; i < item.length; i++) {
                        announceTime = item[i].announceTime;
                        let numEf = item[i].numEf;
                        getDate(announceTime, numEf);
                        if (daylabel == "오늘") { continue; }

                        if (daydate != olddate) {
                            weatherItem += "<li class='day_item'>";

                            weatherItem += "<div class='day_date_week'>";
                            weatherItem += "<b>" + daylabel + "</b>";
                            weatherItem += "<span class='daydate'>" + daydate + "</span><span class='dayweek'>(" + dayweek + ")</span>";
                            weatherItem += "</div>";

                            weatherItem += "<div class='temperatures'>";
                            weatherItem += "<span class='lowest_ta'>" + item[i].ta + "°</span>";
                            weatherItem += "<span class='slash'>/</span>";
                            weatherItem += "<span class='highest_ta'>" + item[i + 1].ta + "°</span>";
                            weatherItem += "</div>";

                            weatherItem += "<div class='weather_f'>";
                            weatherItem += "<span class='morning_f'>" + item[i].wf + "</span>";
                            weatherItem += "<span class='slash'>/</span>";
                            weatherItem += "<span class='afternoon_f'>" + item[i + 1].wf + "</span>";
                            weatherItem += "</div>";

                            weatherItem += "<div class='weather_f'>";
                            weatherItem += "<span class='morning_f'>" + item[i].rnSt + "%</span>";
                            weatherItem += "<span class='slash'>/</span>";
                            weatherItem += "<span class='afternoon_f'>" + item[i + 1].rnSt + "%</span>";
                            weatherItem += "</div>";

                            weatherItem += "</li>";
                        }
                        olddate = daydate;
                    }
                });
                weatherItem += "</ul>";
                weatherItem += "</div>";
                weatherItem += "</div>";
                $("#weather_info_list").append(weatherItem);
                getWeather3after(announceTime, taRegId, wfRegId);

            },
            error: function () {
            	getWeather(city, taRegId, wfRegId);
            }
        });
    }

    function getWeather3after(announceTime, taRegId, wfRegId) {
    	let wfArry = [];
        let rnStArry = [];
        let tempArr = [];
        let weatherItem = "";
        let tempDataReady = false;
        let wfDataReady = false;
        
        let today = Math.floor(announceTime / 10000);
        if (timeonly > 1800) {
            tmFc = String(today) + "1800"
        } else if (timeonly > 600) {
            tmFc = String(today) + "0600"
        } else {
            tmFc = String(today - 1) + "1800"
        }

        let c_year = Math.floor(announceTime / 100000000);
        let c_month = Math.floor(announceTime % 100000000 / 1000000 - 1) 
        let c_day = Math.floor(announceTime % 1000000 / 10000)

        let c_date = new Date(c_year, c_month, c_day);
        
        $.ajax({
            url: 'get_weather_10tem.do',
            method: 'post',
            dataType: 'json',
            data: {
                regId: taRegId,
                tmFc: tmFc
            },
            success: function (data) {
                let items = data.response.body.items.item;
                let { regId, taMin3, taMax3, taMin4, taMax4, taMin5, taMax5, taMin6, taMax6, taMin7, taMax7, taMin8, taMax8, taMin9, taMax9, taMin10, taMax10 } = items[0];
                tempArr = [taMin3, taMax3, taMin4, taMax4, taMin5, taMax5, taMin6, taMax6, taMin7, taMax7, taMin8, taMax8, taMin9, taMax9, taMin10, taMax10];
                
                tempDataReady = true;
                creatItemReady(c_date, taRegId);
            },
            error: function () {
            	getWeather3after(announceTime, taRegId, wfRegId);
            }
        });

        $.ajax({
            url: 'get_weather_10wf.do',
            method: 'post',
            dataType: 'json',
            data: {
                regId: wfRegId,
                tmFc: tmFc
            },
            success: function (data) {
                let items = data.response.body.items.item;
                let {
                    rnSt3Am, rnSt3Pm, rnSt4Am, rnSt4Pm, rnSt5Am, rnSt5Pm, rnSt6Am, rnSt6Pm,
                    rnSt7Am, rnSt7Pm, rnSt8, rnSt9, rnSt10, wf3Am, wf3Pm, wf4Am,
                    wf4Pm, wf5Am, wf5Pm, wf6Am, wf6Pm, wf7Am, wf7Pm, wf8, wf9, wf10
                } = items[0];

                rnStArry = [rnSt3Am, rnSt3Pm, rnSt4Am, rnSt4Pm, rnSt5Am, rnSt5Pm, rnSt6Am, rnSt6Pm,
                    rnSt7Am, rnSt7Pm, rnSt8, rnSt8, rnSt9, rnSt9, rnSt10, rnSt10];

                wfArry = [wf3Am, wf3Pm, wf4Am,
                    wf4Pm, wf5Am, wf5Pm, wf6Am, wf6Pm, wf7Am, wf7Pm, wf8, wf8, wf9, wf9, wf10, wf10];
                
                wfDataReady = true; 
                creatItemReady(c_date, taRegId);
            },
            error: function () {
            	getWeather3after(announceTime, taRegId, wfRegId);
            }
        });
        
        function creatItemReady(c_date, taRegId) {
            weatherItem = "";
            if (tempDataReady && wfDataReady) {
                for (let i = 0; i < tempArr.length; i += 2) {
                	let uDate = new Date();
                	let d7Date = new Date();
                	
                    uDate.setDate(c_date.getDate() + (i / 2) + 3);
                    daydate = uDate.toLocaleDateString().slice(5, 11);
                    
                    d7Date.setDate(c_date.getDate() + 7);
                    let d7after = d7Date.toLocaleDateString().slice(5, 11);
                    
                    /* 중복 처리 */
                    let dateExists = false;
                    $("." + taRegId + " .week_items .daydate").each(function() {
                        let beforeDateText = $(this).text();
                        if (beforeDateText === daydate) {
                            dateExists = true;
                            return false;
                        }
                    });
                    
                    if (dateExists) {
                    	continue;
                    }
                    
                    switch (uDate.getDay()) {
                        case 0: dayweek = "일"; break;
                        case 1: dayweek = "월"; break;
                        case 2: dayweek = "화"; break;
                        case 3: dayweek = "수"; break;
                        case 4: dayweek = "목"; break;
                        case 5: dayweek = "금"; break;
                        case 6: dayweek = "토"; break;
                    }
                    
                    
                    weatherItem += "<li class='day_item'>";
                    weatherItem += "<div class='day_date_week'>";
                    weatherItem += "<span class='daydate'>" + daydate + "</span><span class='dayweek'>(" + dayweek + ")</span>";
                    if (daydate == d7after){
                    	weatherItem += "<span class='dayweek'> 일주일 뒤 </span>";
                    }
                    weatherItem += "</div>";

                    weatherItem += "<div class='temperatures'>";
                    weatherItem += "<span class='lowest_ta'>" + tempArr[i] + "°</span>";
                    weatherItem += "<span class='slash'>/</span>";
                    weatherItem += "<span class='highest_ta'>" + tempArr[i + 1] + "°</span>";
                    weatherItem += "</div>";
                    
                    weatherItem += "<div class='weather_f'>";
                    weatherItem += "<span class='morning_f'>" + wfArry[i] + "</span>";
                    if (i < 10) {
    	                weatherItem += "<span class='slash'>/</span>";
    	                weatherItem += "<span class='afternoon_f'>" + wfArry[i + 1] + "</span>";
                    }
                    weatherItem += "</div>";
                    weatherItem += "<div class='weather_f'>";
                    weatherItem += "<span class='morning_f'>" + rnStArry[i] + "%</span>";
                    if (i < 10) {
    	                weatherItem += "<span class='slash'>/</span>";
    	                weatherItem += "<span class='afternoon_f'>" + rnStArry[i + 1] + "%</span>";
                    }
                    weatherItem += "</div>";
                    weatherItem += "</li>";
                }
            }
            
            $("." + taRegId + " .week_items").append(weatherItem);
        }
        
    }

    let isDown = false;
    let startX;
    let scrollLeft;

    $(document).on('mousedown wheel', '.week_one_line', function (e) {
        if (e.type === 'mousedown') {
            isDown = true;
            $(this).addClass('active');
            startX = e.pageX - $(this).offset().left;
            scrollLeft = $(this).scrollLeft();
        }
        //        else if (e.type === 'wheel') {
        //        	isDown = true;
        //            const delta = e.originalEvent.deltaY;
        //            const scrollSpeed = 2; 
        //            $(this).scrollLeft(scrollLeft + delta * scrollSpeed);
        //        }
    });

    $(document).on('mouseleave mouseup', '.week_one_line', function () {
        isDown = false;
        $(this).removeClass('active');
    });

    $(document).on('mousemove', '.week_one_line', function (e) {
        if (!isDown) return;
        e.preventDefault();
        const x = e.pageX - $(this).offset().left;
        const walk = x - startX;
        $(this).scrollLeft(scrollLeft - walk);
    });

    $(document).ready(function() {
        $('.weather-btn-box').click(function() {
            $('.weather_info_container').toggle();
        });
    });
    
    
    $(document).on('click', function(event) {
        if (!$(event.target).closest('.weather-btn-box').length && !$(event.target).closest('.weather_info_container').length) {
        	  $('.weather_info_container').hide();
        } else {
            return;
        }
    });
});
