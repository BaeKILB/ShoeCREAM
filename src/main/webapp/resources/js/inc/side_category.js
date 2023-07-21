/**
 *
 */

// 카테고리 확장 테스트
// dom 로드시 자동 동작
document.addEventListener("DOMContentLoaded", function () {
  let nums = [1, 2, 3, 4, 5];
  for (let num of nums) {
    let ctLc = document.querySelector("#ct_lc_" + num);
    ctLc.addEventListener("mouseenter", (e) => {
      let ct = document.querySelector(".ct_lc_" + num);
      ct.style.display = "block";
      ctLc.style.display = "block";
    });
    ctLc.addEventListener("mouseleave", (e) => {
      let ct = document.querySelector(".ct_lc_" + num);
      ct.style.display = "none";
    });
  }
});
