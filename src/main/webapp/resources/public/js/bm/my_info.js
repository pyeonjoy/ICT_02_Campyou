'use strict'

document.querySelector('.btn_change').addEventListener('click', function () {

    const passwordInput = document.getElementById('pw');
    const password = passwordInput.value.trim();

    if (!password) {
        alert('비밀번호를 입력해주세요.');
        passwordInput.focus(); 
        return;
    }

    if (!isValidPassword(password)) {
        alert('올바른 비밀번호를 입력해주세요.');
        passwordInput.focus(); 
        return;
    }
;
});

function isValidPassword(password) {
    return password.length >= 8; 
}

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