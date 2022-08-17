const phoneInputs = document.querySelectorAll('input[type="tel"], .phone input');

document.querySelector('.modal').addEventListener('modal__open', setQuestionsModal)

setFormValidations();
setDateInputs();

function setQuestionsModal() {
  const questions = Array.from(document.querySelectorAll('.question'));

  var questionsData = questions.map(question => {
    let classes = question.classList.toString().replace('question','');
    let label = question.querySelector('label').innerText;
    let input = question.querySelector('label + *');
    var value = null;
    if (input.tagName == 'UL') {
      let inputChecked = input.querySelector('input:checked');
      value = inputChecked?.value
    } 
    value ??= input.value
    return {label, value, classes};
  })

  function makeQuestion({label, value, classes}) {
    value = value ? `<b>${value}</b><br>` : '<i>Sem resposta</i><br>';
    return `<div class="${classes}">
      <label>${label}</label>
      ${value}
    </div>`;
  }
  
  document.querySelector('.modal__body').textContent = ''
  questionsData.map(makeQuestion).forEach(elm => {
    document.querySelector('.modal__body').innerHTML += elm;
  })
}

function setCPFmask() {
  const cpf = document.querySelector('input[name="cpf"]');
  if (!cpf) return;
  cpf.type="text";
  cpf.oninput = function (e) {
    if (!e.data) return;
    if (isNaN(Number(e.data))) {
      cpf.value = cpf.value.replace(e.data,'');
    }
    if (cpf.value.length > 14) {
      cpf.value = cpf.value.slice(0, 14);
    }
    if ([3,7].includes(cpf.value.length)) {
      cpf.value = cpf.value+'.';
    }
    if (cpf.value.length == 11) {
      cpf.value = cpf.value+'-';
    }
  }
}

function setPhoneMask() {
  const phoneInputs = document.querySelectorAll('input[type="tel"], .phone input');
  phoneInputs.forEach(input => {
    input.type = 'text'
    input.oninput = function (e) {
      if (!e.data) return;
      if (isNaN(Number(e.data))) {
        input.value = input.value.replace(e.data,'');
      }
      if (input.value.length == 1 && input.value != '(') {
        input.value = '('+input.value;
      }
      if (input.value.length == 3) {
        input.value = input.value+') ';
      }
      if (input.value.length == 9) {
        input.value = input.value+'-';
      }
      if (input.value.length == 15) {
        input.value = input.value.replace('-','');
        input.value = input.value.slice(0, 10) + '-' + input.value.slice(10,15);
      }
    }
  })
}

function setFormSubmit() {
  const form = document.querySelector('form.survey-form');
  document.querySelector('.modal__close.submit').addEventListener('click',(e) => {
    function removeCPFmask() {
      const cpf = document.querySelector('input[name="cpf"]');
      if(!cpf) return;
      const value = cpf.value.replace(/\.|-/g,'');
      cpf.value = value;
      cpf.type="number";
    }
    phoneInputs.forEach( input => {
      input.value = input.value.replace(/\D/g, '');
    } )
    removeCPFmask();
    form.submit();
  });
}

function setEmailConfirmation() {

  document.querySelectorAll('input[type="email"]').forEach((input,i)=> {
    if (i%2==0) {
      input.classList.add(`email-${i}`);
      input.addEventListener('input',(e) => {
        if(!input.checkValidity()) {
          addError(input.parentElement,'E-mail inválido');
        } else {
          removeError(input.parentElement);
        }
      })
    } else {
      const mainInput = document.querySelector(`.email-${i-1}`);
      input.addEventListener('input',(e) => {
        if(input.value !== mainInput.value) {
          addError(input.parentElement,'E-mail de confirmação não confere.');
        }
        else if(!input.checkValidity()) {
          addError(input.parentElement,'E-mail inválido');
        } else {
          removeError(input.parentElement);
        }
      })
    }
  });
}

function setFormValidations() {
  setCPFmask();
  setPhoneMask();
  setEmailConfirmation();
  setFormSubmit();
  setDateValidations()
}

function setDateValidations() {
  const birthdayInputs = document.querySelectorAll('.birthday-field input');
  birthdayInputs.forEach(input => {
    input.max = new Date().toISOString().split('T')[0]; // set max date to today
    input.addEventListener('input',(e) => {
      removeError(input.parentElement);
      if(!input.checkValidity()) {
        addError(input.parentElement,'Data inválida');
      }
    })
  });
}

function setDateInputs() {
  const dateInputs = document.querySelectorAll('.date_field input');
  dateInputs.forEach(input => input.type = 'date');
}

function addError(element, text) {
  if(element.classList.contains('error')) return;
  label = `<label class="error">${text}</label>`;
  errorDiv = document.createElement('div');
  errorDiv.classList.add('requided_error');
  errorDiv.innerHTML = label;
  element.classList.add('error');
  element.appendChild(errorDiv);
}

function removeError(element) {
  if(!element.classList.contains('error')) return;
  errorDiv = element.querySelector('.requided_error');
  element.classList.remove('error');
  element.removeChild(errorDiv);
}

