<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>Document</title>
<script>
$(document).ready(function() {
	 $('#star_form').submit(function(e) {
	        e.preventDefault();

	        /* let member_idx = "${member_idx}"; */
	        let member_idx = 2;
	        let new_rating = $("input[name='rating']:checked").val();
	        let requestData = {
	        	new_rating: new_rating,
	        	member_idx: 2
	        };

	        $.ajax({
	            url: 'addstarok.do', 
	            type: 'post',
	            contentType: 'application/json',
	            data: JSON.stringify(requestData),
	            success:function(data){
					if(data != "error") {
	                    alert("별점이 정상적으로 등록되었습니다.");
	                    $("input[name='rating']").prop('checked', false);
	                } else {
	                    alert("오류가 발생하였습니다.");
	                }
	            },
	            error: function() {
	                alert("로그인 후 이용 부탁드립니다.");
	                location.href='login_form.do';
	            }
	        });
	    });	
});
</script>
    <style>
/*모달 팝업 영역 스타일링*/
.modal {
	/*팝업 배경*/
	display: none;
            width: 100%;
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            background-color: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
}

.modal .modal_popup {
	/*팝업*/
	position: absolute;
	top: 70%;
    left: 42%;
    width: 300px;
	transform: translate(-50%, -50%);
	padding: 20px;
	background: #ffffff;
	border-radius: 20px;
	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
}
/*모달 팝업 영역 스타일링*/
.modal2 {
	/*팝업 배경*/
	display: none;
    width: 10px;
    height: 0px;
}

.modal2 .modal_popup2 {
	/*팝업*/
	position: absolute;
    top: 71%;
    left: 44%;
	transform: translate(-50%, -50%);
	padding: 20px;
	background: #ffffff;
	border-radius: 20px;
	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
}
.wrap {
/*     height: 100vh;
    min-height: 400px; */
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    gap: 32px;
}

h1 {
    font-size: 40px;
    font-weight: 600;
}

.rating {
    float: none;
    width: 240px;
    display: flex;
}

.rating__input {
    display: none;
}

.rating__label {
    width: 20px;
    overflow: hidden;
    cursor: pointer;
}

.rating__label .star-icon {
    width: 20px;
    height: 40px;
    display: block;
    position: relative;
    left: 0;
    background-image: url(${path}/resources/images/ico-star.png);
    background-repeat: no-repeat;
    background-size: 40px;
}

.rating__label .star-icon.filled {
    background-image: url(${path}/resources/images/ico-star-empty.png);
}

.rating__label--full .star-icon {
    background-position: right;
}

.rating__label--half .star-icon {
    background-position: left;
}

.rating.readonly .star-icon {
    opacity: 0.7;
    cursor: default;
}

}

    </style>
</head>
<body>
	<div class="modal">
		<div class="modal_popup">
			<div class="wrap">
				<h1>Star rating</h1>
				<div>
				<form id="star_form" class="rating">
					<label class="rating__label rating__label--half" for="starhalf">
						<input type="radio" id="starhalf" class="rating__input" name="rating" value="1"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--full" for="star1">
						<input type="radio" id="star1" class="rating__input" name="rating" value="2"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--half" for="star1half">
						<input type="radio" id="star1half" class="rating__input" name="rating" value="3"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--full" for="star2">
						<input type="radio" id="star2" class="rating__input" name="rating" value="4"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--half" for="star2half">
						<input type="radio" id="star2half" class="rating__input" name="rating" value="5"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--full" for="star3">
						<input type="radio" id="star3" class="rating__input" name="rating" value="6"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--half" for="star3half">
						<input type="radio" id="star3half" class="rating__input" name="rating" value="7" checked> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--full" for="star4">
						<input type="radio" id="star4" class="rating__input" name="rating" value="8"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--half" for="star4half">
						<input type="radio" id="star4half" class="rating__input" name="rating" value="9"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--full" for="star5">
						<input type="radio" id="star5" class="rating__input" name="rating" value="10"> <span class="star-icon"></span>
					</label>
					<input type="submit" value="선택"/>
				</form> 
				</div>
			</div>
		</div>
	</div>
	<button type="button" class="modal_btn">별점 주기</button>
 	<script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function() {
            const modalOpenButtons = document.querySelectorAll('.modal_btn');
            const modalCloseButtons = document.querySelectorAll('.close_btn');
            const modal = document.querySelector('.modal');
    
            // 열기 버튼을 눌렀을 때 모달팝업이 열림
            modalOpenButtons.forEach(function(button) {
                button.addEventListener('click', function() {
                    modal.style.display = 'block';
                });
            });
    
            // 닫기 버튼을 눌렀을 때 모달팝업이 닫힘
            modalCloseButtons.forEach(function(button) {
                button.addEventListener('click', function() {
                    modal.style.display = 'none';
                });
            });
        });
    </script>
	<script>
        const rateWrap = document.querySelectorAll('.rating'), // 모든 rating 요소
        label = document.querySelectorAll('.rating .rating__label'), // 모든 rating__label 요소
        input = document.querySelectorAll('.rating .rating__input'), // 모든 rating__input 요소
        labelLength = label.length, // label 요소의 개수
        opacityHover = '1'; // 호버 시 불투명도

let stars = document.querySelectorAll('.rating .star-icon'); // 모든 star-icon 요소

function checkedRate() {
    let checkedRadio = document.querySelectorAll('.rating input[type="radio"]:checked'); // 체크된 라디오 버튼

    initStars(); // 모든 별 초기화
    checkedRadio.forEach(radio => {
        let previousSiblings = prevAll(radio);

        for (let i = 0; i < previousSiblings.length; i++) {
            previousSiblings[i].querySelector('.star-icon').classList.add('filled'); // 체크된 라디오 버튼 이전 별들 채움
        }

        radio.nextElementSibling.classList.add('filled'); // 체크된 라디오 버튼의 별 채움

        function prevAll() {
            let radioSiblings = [],
                prevSibling = radio.parentElement.previousElementSibling; // 이전 형제 요소

            while (prevSibling) {
                radioSiblings.push(prevSibling); // 이전 형제 요소 추가
                prevSibling = prevSibling.previousElementSibling; // 다음 이전 형제 요소
            }
            return radioSiblings;
        }
    });
}

checkedRate(); // 초기 별점 설정

rateWrap.forEach(wrap => {
    wrap.addEventListener('mouseenter', () => {
        stars = wrap.querySelectorAll('.star-icon'); // 현재 rating의 star-icon 요소들

        stars.forEach((starIcon, idx) => {
            starIcon.addEventListener('mouseenter', () => {
                initStars(); 
                filledRate(idx, labelLength); 

                for (let i = 0; i < stars.length; i++) {
                    if (stars[i].classList.contains('filled')) {
                        stars[i].style.opacity = opacityHover; // 채워진 별의 불투명도 설정
                    }
                }
            });

            starIcon.addEventListener('mouseleave', () => {
                starIcon.style.opacity = '1'; // 별의 불투명도 원래대로 설정
                checkedRate(); 
            });

            wrap.addEventListener('mouseleave', () => {
                starIcon.style.opacity = '1'; // 별의 불투명도 원래대로 설정
            });
        });
    });
});

function filledRate(index, length) {
    if (index <= length) {
        for (let i = 0; i <= index; i++) {
            stars[i].classList.add('filled'); // index까지의 별을 채움
        }
    }
}



function initStars() {
    for (let i = 0; i < stars.length; i++) {
        stars[i].classList.remove('filled'); // 모든 별 초기화
    }
}
    </script>
</body>
</html>