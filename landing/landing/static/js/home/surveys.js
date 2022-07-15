document.querySelector('.modal').addEventListener('modal-open', () => {
  setQuestionsModal();
});
setFormValidations();

function setQuestionsModal() {
  const questions = Array.from(document.querySelectorAll('.question'));
  
  function makeQuestion(elm) {
    var elm = elm.cloneNode(true)
    elm.classList.remove('question')
    let inputs = Array.from(elm.querySelectorAll('input, select'));
    inputs = inputs.filter(input => input.type !== 'hidden' && (input.type !== 'radio' || input.checked || input.tagName == 'select'));
    var value = inputs.map(input => input.value)[0];
    if (inputs.length == 1 && inputs[0].tagName == 'SELECT') {
      value = inputs[0].options[inputs[0].selectedIndex].text;
    }
    elm.innerHTML += value ? `<b>${value}</b><br>` : '<i>Sem resposta</i><br>';
    elm.querySelectorAll('input, ul, select').forEach(item => item.remove())
    
    return elm
  }
  
  document.querySelector('.modal-body').textContent = ''
  questions.map(makeQuestion).forEach(elm => {
    document.querySelector('.modal-body').appendChild(elm);
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
       cpf.value = cpf.value.slice(0,14);
    }
    if ([3,7].includes(cpf.value.length)) {
      cpf.value = cpf.value+'.';
    }
    if (cpf.value.length == 11) {
      cpf.value = cpf.value+'-';
    }
  }
}

function setFormSubmit() {
  const form = document.querySelector('form.survey-form');
  const submit = document.querySelector('.modal-close.submit').addEventListener('click',(e) => {
    function removeCPFmask() {
      const cpf = document.querySelector('input[name="cpf"]');
      if(!cpf) return;
      const value = cpf.value.replace(/\.|-/g,'');
      cpf.value = value;
      cpf.type="number";
    }
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
}
function setFormValidations() {
  setCPFmask();
  setEmailConfirmation();
  setFormSubmit();
}
