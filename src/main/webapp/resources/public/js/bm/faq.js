'use strict'
const questions = document.querySelectorAll('.question');
const answers = document.querySelectorAll('.answer');
const question_containers = document.querySelectorAll('.question_container');
const lists = document.querySelectorAll('.question-list')

window.addEventListener('DOMContentLoaded', (event) => {
    const defaultQuestionContainer = document.querySelector('.question_container--1');
    defaultQuestionContainer.classList.add('active');
});


const openAnswer = function(e){
    const clicked = e.target.closest('.question');
console.log(clicked);

  if (!clicked) return; 
  document.querySelector(`.answer--${clicked.dataset.question}`).classList.remove('answer-active');
  
  if (clicked.classList.contains('question-active')) {
    clicked.classList.remove('question-active');
    document.querySelector(`.answer--${clicked.dataset.question}`).classList.remove('answer-active');
  }   
  else { 
    questions.forEach(q => q.classList.remove("question-active"));
    answers.forEach(a => a.classList.remove('answer-active'));
    clicked.classList.add("question-active");
    document.querySelector(`.answer--${clicked.dataset.question}`).classList.add('answer-active');
  }
  }


questions.forEach(q => q.addEventListener('click', openAnswer));

const listClicked = function (e) {
  const checked = e.target.closest('.question-list');
  
  if (!checked) return;

  lists.forEach(list => {
    if (list === checked) {
      list.classList.add('list_active');
      document.querySelector(`.question_container--${list.dataset.list}`).classList.add("active");
    } else {
      list.classList.remove('list_active');
      document.querySelector(`.question_container--${list.dataset.list}`).classList.remove("active");
    }
  })
}

lists.forEach(b=> b.addEventListener('click', listClicked));