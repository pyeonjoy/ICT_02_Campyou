'use strict'

    let indutyElement = document.querySelector(".list_type");
    let induty = indutyElement.innerHTML;
    console.log(induty.length)
    let listType = document.createElement("div");
    listType.className = "list_type";


    function goToHomepage(url) {
        window.location.href = url;
    }

    if (induty.length === 3) {
          switch (induty) {
    case "카라반":
    	listType.classList.add("type_yellow");
    break;
    case "글램핑":
    	listType.classList.add("type_green");
    break;
          }
    }
