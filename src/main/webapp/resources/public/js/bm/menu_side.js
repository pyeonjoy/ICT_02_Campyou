 window.onload = function() {
  
        const memberIdxInput = document.getElementById("memberIdx");

  
        const memberIdxValue = memberIdxInput.value;


        console.log("memberIdxValue:", memberIdxValue);

  
        const myInfoLink = document.getElementById("myInfoLink");
        myInfoLink.href = "my_info.do?member_idx=" + memberIdxValue;

  
        const inquiryLink = document.getElementById("inquiryLink");
        inquiryLink.href = "my_inquiry.do?member_idx=" + memberIdxValue;
    };