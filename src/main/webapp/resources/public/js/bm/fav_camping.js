'use strict';

const hearts = document.querySelector(".camping_container");

function goToHomepage(url) {
  window.location.href = url;
}

function delHeart(contentid) {
    const xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {
            window.location.href = 'my_fav_list.do';
        }
    };
    xhttp.open("POST", "delHeart.do", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send("contentid=" + contentid);
}

if (data.length === 0) {
  const html = `<h4 class="nolist">관심 캠핑장이 없습니다. </h4>`;
  hearts.insertAdjacentHTML("afterbegin", html);
} else {
  data.forEach(c => {
    let induty = "", induty2 = "";
    if(c.induty.length < 2) { induty= ""}
    if (c.induty.length === 3) {
      induty = c.induty;
    }
    if (c.induty.length > 5) {
      const indutyList = c.induty.split(',');
      induty = indutyList[0]; 
      induty2 = indutyList[1];
    }
    
    const html = `
      <div class="fav_list">
        <button class="btn-heart" data-contentid="${c.contentid}">❤️</button>
        <div class="list_summery">
          <p class="list_addr1">${c.donm} ${c.sigungunm}</p>
          <p class="list_rest_addr">${c.addr1.split(" ")[2]} ${c.addr1.split(" ")[3]} ${c.addr1.split(" ")[4]}</p>
        </div>
        <div class="list_item">
          <div class="list_image_container">
            <img src="${c.firstimageurl}" alt="camping_img" class="camping_img">
          </div>
          <div class="types">
            <div class="list_type ${induty === "카라반" ? "type_yellow" : induty === "글램핑" ? "type_green" : "type_light"}">${induty || ""}</div>
            ${induty2 ? `<div class="list_type ${induty2 === "카라반" ? "type_yellow" : induty2 === "글램핑" ? "type_green" : "type_light"}">${induty2}</div>` : ''}
          </div>
          <div class="list_text_overlay">
            <h4 class="list_name">${c.facltnm}</h4>
            <p class="list_content">${c.tel}</p>
          </div>
        </div>
        <button class="btn" onclick="goToHomepage('${c.homepage}')">홈페이지</button>
      </div>`;
    hearts.insertAdjacentHTML("afterbegin", html);
  });

  // 이벤트 위임을 통해 한 번에 처리
  hearts.addEventListener("click", function(event) {
    const target = event.target;
    if (target.classList.contains("list_summery") || target.classList.contains("list_item") || target.classList.contains("types") || target.classList.contains("list_text_overlay")) {
      const contentid = target.closest(".fav_list").querySelector(".btn-heart").getAttribute("data-contentid");
      window.location.href = `campDetail.do?contentid=${contentid}`;
    } else if (target.classList.contains("btn-heart")) {
      const contentid = target.getAttribute("data-contentid");
      delHeart(contentid);
      window.location.reload();
    }
  });
}

