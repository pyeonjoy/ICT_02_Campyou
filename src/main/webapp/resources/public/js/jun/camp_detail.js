$(document).ready(function () {
  let pageNo = 1;

  function camp_all_list() {
    $.ajax({
      url: "camp_list.do",
      method: "post",
      data: { pageNo: pageNo },
      dataType: "xml",
      success: function (data) {
        $("#camp_list_show").empty();
        $(data)
          .find("item")
          .each(function () {
            let firstImageUrl = $(this).find("firstImageUrl").text();
            let doNm = $(this).find("doNm").text();
            let sigunguNm = $(this).find("sigunguNm").text();
            let facltNm = $(this).find("facltNm").text();
            let induty = $(this).find("induty").text();
            let addr1 = $(this).find("addr1").text();
            let tel = $(this).find("tel").text();
            let homepage = $(this).find("homepage").text();
            let contentid = $(this).find("contentId").text();

            let campItem =
              "<div class='camp_item' onclick='location.href=\"camp_detail.do?contentid=" +
              contentid +
              "\"'>";
            if (firstImageUrl != null && firstImageUrl !== "") {
              campItem += "<img src='" + firstImageUrl + "' alt='이미지'>";
            } else {
              campItem +=
                "<img src='/resources/images/2.jpg' alt='대체 이미지'>";
            }
            campItem += "<div class='camp_info'>";
            campItem += "<p> [" + doNm + sigunguNm + "] </p>";
            campItem += "<h4>" + facltNm + "</h4><span>" + induty + "</span>";
            campItem += "<p>" + addr1 + "</p>";
            campItem += "<p>" + tel + "</p>";
            campItem += "</div>";
            campItem +=
              "<div class='button_container'><button onclick=\"window.open('" +
              homepage +
              "')\">홈페이지</button></div>";
            campItem += "<div class='Heart_button'><button>🤍</button></div>";
            campItem += "</div>";
            $("#camp_list_show").append(campItem);
          });
      },
      error: function () {
        alert("읽기 실패");
      },
    });
  }

  function nextPage() {
    pageNo++;
    camp_all_list();
  }
  function beforePage() {
    pageNo--;
    camp_all_list();
  }
  function loadHeart() {
    $.ajax({
      url: "checkHeart.do",
      type: "get",
      data: { contentid: contentId },
      dataType: "json",
      success: function (data) {
        $("#detail_button").empty();
        if (data === true) {
          let detailButton = "<div>";
          detailButton +=
            "<input type='button' name='page' value='홈페이지' onclick=\"window.open('${info.homepage}')\">";
          detailButton +=
            "<input type='button' name='page' value='예약페이지' onclick='resvego()'>";
          detailButton +=
            "<input type='button' name='page' value='🤍관심등록' onclick='Heart()'>";
          detailButton += "</div>";
          $("#detail_button").append(detailButton);
        } else if (data === false) {
          let detailButton = "<div>";
          detailButton +=
            "<input type='button' name='page' value='홈페이지' onclick=\"window.open('${info.homepage}')\">";
          detailButton +=
            "<input type='button' name='page' value='예약페이지' onclick='resvego()'>";
          detailButton +=
            "<input type='button' id='Heart' name='page' value='❤️관심해제' onclick='delHeart()'>";
          detailButton += "</div>";
          $("#detail_button").append(detailButton);
        } else {
          alert("찜 여부를 확인하는 중 오류가 발생했습니다.");
        }
      },
      error: function () {
        let detailButton = "<div>";
        detailButton +=
          "<input type='button' name='page' value='홈페이지' onclick=\"window.open('${info.homepage}')\">";
        detailButton +=
          "<input type='button' name='page' value='예약페이지' onclick='resvego()'>";
        detailButton +=
          "<input type='button' id='Heart' name='page' value='🤍관심등록' onclick='Heart()'>";
        detailButton += "</div>";
        $("#detail_button").append(detailButton);
      },
    });
  }
  function searchByKeywords() {
    let keywordInput = $("#keyword_input").val();

    $.ajax({
      url: "camp_list_search.do",
      method: "post",
      data: {
        pageNo: pageNo,
        keyword: keywordInput,
      },
      dataType: "xml",
      success: function (data) {
        $("#camp_list_show").empty();
        $(data)
          .find("item")
          .each(function () {
            let firstImageUrl = $(this).find("firstImageUrl").text();
            let doNm = $(this).find("doNm").text();
            let sigunguNm = $(this).find("sigunguNm").text();
            let facltNm = $(this).find("facltNm").text();
            let induty = $(this).find("induty").text();
            let addr1 = $(this).find("addr1").text();
            let tel = $(this).find("tel").text();
            let homepage = $(this).find("homepage").text();
            let contentid = $(this).find("contentId").text();

            let campItem =
              "<div class='camp_item' onclick='location.href=\"camp_detail.do?contentid=" +
              contentid +
              "\"'>";
            campItem += "<img src='" + firstImageUrl + "' alt='이미지'>";
            campItem += "<div class='camp_info'>";
            campItem += "<p> [" + doNm + sigunguNm + "] </p>";
            campItem += "<p><b>" + facltNm + "</b><br>" + induty + "</p>";
            campItem += "<p>" + addr1 + "</p>";
            campItem += "<p>" + tel + "</p>";
            campItem += "</div>";
            campItem +=
              "<div class='button_container'><button onclick=\"window.open('" +
              homepage +
              "')\">홈페이지</button></div>";
            campItem += "</div>";

            $("#camp_list_show").append(campItem);
          });
      },
      error: function () {
        alert("검색 실패");
      },
    });
  }

  camp_all_list();
  loadHeart();
  $(".camp_list_next").on("click", function () {
    nextPage();
  });
  $(".camp_list_before").on("click", function () {
    beforePage();
  });
  $("#search_button").on("click", function () {
    searchByKeywords();
  });
  $("#keyword_input").keypress(function (event) {
    if (event.which === 13) {
      searchByKeywords();
    }
  });
});
