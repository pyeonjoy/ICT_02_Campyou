'use strict'


function formatPhoneNumber(phoneNumber) { 
  if (phoneNumber.length < 10) alert("번호를 다시 확인해주세요") 
    phoneNumber = phoneNumber.replace(/[^\d]/g, '');
    phoneNumber = phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');

    return phoneNumber;
}

document.getElementById('phone').addEventListener('blur', function() {
    this.value = formatPhoneNumber(this.value);
});

function inValidEmail(email) {
  const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    if (!emailPattern.test(email)) {
        alert('올바른 이메일 형식이 아닙니다.');
        return true; 
    }

    return false;
}

  function checkPassword(e) { 
  e.preventDefault();
	    const password = document.getElementById('password').value.trim();
	    const memberId = document.getElementById('id').value;
	    console.log(memberId, password);
	    
	    if (!password) {
	        alert('비밀번호를 입력해주세요.');
	        return;
	    }
	    
	    const xhr = new XMLHttpRequest();	 
	    const requestData = {
        "password": password,
        "memberId": memberId
    };
    const jsonData = JSON.stringify(requestData);

	    xhr.open('POST', 'pwdCheck.do', true);
	    xhr.setRequestHeader('Content-type', 'application/json');
        xhr.send(jsonData)
	    xhr.onreadystatechange = function () {
	    console.log(xhr.readyState);
	    
	        if (xhr.readyState === XMLHttpRequest.DONE) {
	            if (xhr.status === 200) {
	                const response = xhr.responseText;
	                if (response==="success") {
	                    // 비밀번호 일치
	                    // 여기서 처리할 작업을 추가하세요
	                    alert('비밀번호가 확인되었습니다.');
	                } else {
	                    // 비밀번호 불일치
	                    alert('비밀번호가 일치하지 않습니다.');
	                }
	            } else {
	                // 서버 오류
	                alert('서버 오류가 발생했습니다.');
	            }
	        }
	    };
	}
    
 
function handleChangeInfo(f){
	 const passwordInput = document.getElementById('password');
	    const password = passwordInput.value.trim();
	    if (!password) {
	        alert('비밀번호를 입력해주세요.');
	        passwordInput.focus(); 
	        return;
	    }
}


document.querySelector('.btn_change').addEventListener('click', handleChangeInfo);
document.querySelector('.btn-check').addEventListener('click', checkPassword);
  
  