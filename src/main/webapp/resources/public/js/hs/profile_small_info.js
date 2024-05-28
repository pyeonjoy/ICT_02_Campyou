$(document).ready(function() {
	let ageGroup = "";
	let member_idx;
	
	
    $(document).on('click', '.profile_show', function(event) {
    	member_idx = $(this).data('memberidx');
    	$.ajax({
		    url: 'getProfile.do',
		    method: 'post',
		    dataType: 'json',
		    data: { member_idx:member_idx },
		    success: function(data) {
		    	 $('#member_nickname').text(data.member_nickname);
		    	 $('#member_grade').attr('src', '/resources/images/grade' + data.member_grade + '.png');
		    	 $('#member_grade').attr('alt',	data.member_grade);
		    	 $('#member_img').attr('src', '/resources/images/' + data.member_img);
		    	 $('#member_age').text(data.member_age);
		    	 $('#member_gender').text(data.member_gender);
		    	 let member_rating_f1 = Math.floor(data.member_rating / 2 * 10) / 10
		    	 $('#member_rating').text(member_rating_f1);
		    	 
	    	     const member_rating = data.member_rating; 
	    	     const full_rating = 10;
	    	     const starWidth = member_rating / full_rating * 100;
	    	     
	    	     getAgeGroup(data.member_dob);
	    	     
	    	     $(".rating").css("width", starWidth + "%");
		    },
		    error: function(dob) {
		    	console.log("읽기 실패");
		    }
		});
    	
    	
    	function getAgeGroup(member_dob) {
    		 // 만나이 계산
    	     let dob =  new Date(member_dob);
    	     let now = new Date();
    	     let age = now.getFullYear() - dob.getFullYear();
    	     let ageM = now.getMonth() - dob.getMonth();
    	     if (ageM < 0 || (ageM === 0 && now.getDate() < member_dob.getDate())) {
    	         age--;
    	     }
    	     
			 if (age >= 70) {
				 ageGroup = "70대 이상";
			 } else if (age >= 60) {
				 ageGroup = "60대";
			 } else if (age >= 50) {
				 ageGroup = "50대";
			 } else if (age >= 40) {
				 ageGroup = "40대";
			 } else if (age >= 30) {
				 ageGroup = "30대";
			 } else if (age >= 20) {
				 ageGroup = "20대";
			 } else if (age >= 10) {
				 ageGroup = "10대";
			 } 
			 
			 $('#member_age').text(ageGroup);
		}
    	
        $('.profile_small_info_container').css('display', 'block');
    });
	

	$(document).on('click', function(event) {
        const target = $(event.target).offset(); 
        const location = 2;

        const targetWidth = $(event.target).outerWidth();
        const targetHeight = $(event.target).outerHeight();
        
        const click_position_top = target.top + (targetHeight / location);
        const click_position_left = target.left + (targetWidth / location);

        $('.profile_small_info_container').css('top', click_position_top+'px');
        $('.profile_small_info_container').css('left', click_position_left+'px');
        
        if (!$('.profile_small_info_container').is(event.target) && !$('.profile_show').is(event.target)) {
            $('.profile_small_info_container').css('display', 'none');
        } else {
            return;
        }
    });
	
	
function report_go(member_idx) {
    window.open('report_write.do?member_idx=' + member_idx, '_blank','location=no, menubar=no, width=580,height=600,scrollbars=no,resizable=no,status=yes,menubar=no,toolbar=no,top=50%,left=50%').focus();
    }
		
	$(document).on('click', '#report_go', function() {
		report_go(member_idx);
    });

});
