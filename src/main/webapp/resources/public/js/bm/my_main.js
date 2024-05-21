'use strict'

	  const emojiElement = document.querySelector('.emoji');
	  const grade = emojiElement.id;
	  let emoji;

	  if (grade === '0') emoji = '🥉';
	  else if (grade === '1') emoji = '🥈';
	  else if (grade === '2') emoji = '🥇';
	  else if (grade === '3') emoji = '🎖️';
	  else if (grade === '4') emoji = '🏆';

	  if (emoji) {
	    emojiElement.innerHTML = emoji;
	  }
	  
	  const gradeEl = document.querySelector('.grade');
	  const gradeInNum = +gradeEl.id +1
	  gradeEl.innerHTML = '등급 : LV.'+gradeInNum + emoji;
	  
	  const hiddenText = document.querySelector('.hidden-text');
	  const count = document.querySelector('.count');
	  const showText = function(){
		  hiddenText.style.visibility = 'visible';
	  }
	  const hideText = function(){
		  hiddenText.style.visibility = 'hidden';
	  }
	  count.addEventListener("mouseover", showText)
	  count.addEventListener("mouseout", hideText)

	