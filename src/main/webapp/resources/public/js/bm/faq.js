'use strict'
const questions = document.querySelectorAll('.question');
const questions2 = document.querySelectorAll('.question2');
const answers = document.querySelectorAll('.answer');
const question_containers = document.querySelectorAll('.question_container');
const lists = document.querySelectorAll('.question-list')

window.addEventListener('DOMContentLoaded', (event) => {
    const defaultQuestionContainer = document.querySelector('.question_container--1');
    defaultQuestionContainer.classList.add('active');
});


const openAnswer = function(e, containerClass){
    const clicked = e.target.closest('.question');
    if (!clicked) return;

    const container = clicked.closest(`.${containerClass}`);

    if (container) {

        const answer = container.querySelector(`.answer--${clicked.dataset.question}`);
        if (answer) {
  
            answer.classList.toggle('answer-active');
        }
    }
}

questions.forEach(q => q.addEventListener('click', (e) => openAnswer(e, 'question_container')));
questions2.forEach(q => q.addEventListener('click', (e) => openAnswer(e, 'question_container--2')));

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