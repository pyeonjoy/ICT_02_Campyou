"use strict";

let response;
const btnCheck = document.querySelector(".btn-check");
const passwordError = document.getElementById("passwordError");
function formatPhoneNumber(phoneNumber) {
  if (phoneNumber.length < 10) alert("번호를 다시 확인해주세요");
  phoneNumber = phoneNumber.replace(/[^\d]/g, "");
  phoneNumber = phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3");

  return phoneNumber;
}

document.getElementById("phone").addEventListener("blur", function () {
  this.value = formatPhoneNumber(this.value);
});

function inValidEmail(email) {
  const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

  if (!emailPattern.test(email)) {
    alert("올바른 이메일 형식이 아닙니다.");
    return true;
  }
  return false;
}

function checkPassword(e) {
  e.preventDefault();

  const passwordInput = document.getElementById("password");
  const password = passwordInput.value.trim();
  const memberId = document.getElementById("id").value;
  if (!password) {
    alert("비밀번호를 입력해주세요.");
    passwordInput.focus();
    return;
  }

  const xhr = new XMLHttpRequest();
  const requestData = {
    password: password,
   memberId: memberId,
  };
  const jsonData = JSON.stringify(requestData);

  xhr.open("POST", "my_pwdCheck.do", true);
  xhr.setRequestHeader("Content-type", "application/json");
  xhr.send(jsonData);


  xhr.onreadystatechange = function () {
    console.log(xhr.readyState);

    if (xhr.readyState === XMLHttpRequest.DONE) {
      if (xhr.status === 200) {
        response = xhr.responseText;
        if (response === "success") {
     passwordInput.style.border = "2px solid green";
            btnCheck.innerHTML = "확인";
             btnCheck.style.color = "green";
            btnCheck.style.border = "none";
            passwordError.innerText = "";
          btnCheck.removeEventListener("click", checkPassword);
        } else {
          passwordInput.focus();
          passwordInput.style.border = "2px solid red"; 

        }
      } else {
        // 서버 오류
        alert("서버 오류가 발생했습니다.");
      }
    }
  };
}

function handleChangeInfo(f, e) {
	 e.preventDefault();
  const passwordInput = document.getElementById("password");
  const password = passwordInput.value.trim();

  if (!password) {
    passwordInput.focus();
    passwordInput.style.border = "2px solid red"; 
    return;
  }

  if (password && response === "success") {
  console.log("form submitted")
  f.action = "changeInfo.do";
  f.submit();
  }
}

function handle_pwd(memberIdx, f, e) {
	 e.preventDefault();
  const passwordInput = document.getElementById("password");
  const password = passwordInput.value.trim();

  if (!password) {
	  passwordInput.focus();
	    passwordInput.style.border = "2px solid red"; 
	    passwordError.innerText = "비밀번호를 입력해주세요.";
    return;
  }
    if (password && response === "success") {
    	f.action = "my_change_pw.do?member_idx="+memberIdx;
        f.submit();
    }  
}


function handle_delete(memberIdx,form, e) {
	 e.preventDefault();
	 const passwordInput = document.getElementById('password');
    const password = passwordInput.value.trim();
    
    if (!password) {
    	  passwordInput.focus();
    	    passwordInput.style.border = "2px solid red"; 
        return;
    }  
     if (password && response === "success") {

    form.action = "deleteUser.do?member_idx="+memberIdx; 
	form.submit()
    }   
}

document.querySelector('.btn_change').addEventListener('click', handleChangeInfo);
btnCheck.addEventListener('click', checkPassword);
document.querySelector('.btn_pwdreset').addEventListener('click', handle_pwd);
