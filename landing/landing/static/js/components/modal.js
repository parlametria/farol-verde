const modal = document.querySelector('.modal');

function setToggle() {
  document.querySelector('.modal-toggle').addEventListener('click',() => {
    modal.classList.add('open');
    setQuestionsModal()
  });

  
  document.querySelectorAll('.modal-backdrop, .modal-close').forEach(
    (elm) => elm.addEventListener('click',() => {
      modal.classList.remove('open');
    }));
}

function setQuestionsModal() {
  const questions = Array.from(document.querySelectorAll('*:not(.modal) .question:not(.question-modal)'));
  
  function makeQuestion(elm) {
    var elm = elm.cloneNode(true)
    elm.classList.add('question-modal')
    let inputs = Array.from(elm.querySelectorAll('input'));
    inputs = inputs.filter(input => input.type !== 'hidden' && (input.type !== 'radio' || input.checked));
    const value = inputs.map(input => input.value)[0];
    elm.innerHTML += value ? `<b>${value}</b><br>` : '<i>Sem resposta</i><br>';
    elm.querySelectorAll('input, ul').forEach(item => item.remove())
    
    return elm
  }
  
  document.querySelector('.modal-body').textContent = ''
  questions.map(makeQuestion).forEach(elm => {
    document.querySelector('.modal-body').appendChild(elm);
  })
}

setToggle()
