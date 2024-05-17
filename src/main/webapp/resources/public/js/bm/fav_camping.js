'use strict'
let induty, induty2;
const hearts = document.querySelector(".camping_container");

function goToHomepage(url) {
  window.location.href = url;
}

//function delHeart(contentid) {
//const xhttp = new XMLHttpRequest();
//xhttp.open("POST", "delHeart.do", true);
//xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
//xhttp.send("contentid=" + contentid);
//window.location.reload();
//}
function delHeart(contentid) {

window.location.href="delHeart.do?contentid="+contentid
window.location.reload();
}

if(data.length===0) {
	const html = `<h4 class="nolist">관심 캠핑장이 없습니다. </h4>`;
	hearts.insertAdjacentHTML("afterbegin", html)
}

data.forEach(c => {
  if (c.induty.length === 3) {
    induty = c.induty
  }
  if (c.induty.length > 5) {
    const indutyList = c.induty.split(',');
    induty = indutyList[0]; 
    induty2 = indutyList[1];
  }

 const html = `
    <div class="fav_list">
      <div class="list_summery">
        <button class="btn-heart" onclick="delHeart('${c.contentid}')">❤️</button>
        <p class="list_addr1">${c.donm} ${c.sigungunm}</p>
        <p class="list_rest_addr">${c.addr1.split(" ")[2]} ${c.addr1.split(" ")[3]} ${c.addr1.split(" ")[4]}</p>
      </div>
      <div class="list_item">
      <div class="list_image_container">
        <img src="${c.firstimageurl}" alt="camping_img" class="camping_img">
      </div>
        <div class="types">
          <div class="list_type ${induty === "카라반" ? "type_yellow" : induty === "글램핑" ? "type_green" : "type_light"}">${induty}</div>
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
  document.querySelector(".fav_list").addEventListener("click", function(){
	  window.href.location=`campDetail.do?contentid=${c.contentid}`
  })
});
