const candidatesList = document.getElementById('candidates__container');
const inputs = document.querySelectorAll('form :is(input, select):not(.subject__input)');
const subjectsInputs = document.querySelectorAll('form .subject__input');
const nameInput = document.getElementById('query__input');
const subjects = document.querySelector('.query__subjects');
const pagination = document.querySelector('#page');
const partyBoard = document.querySelector('#party .input-board__selector')
const partyButton = document.querySelector('#party button');

const ufBoard = document.querySelector('#uf .input-board__selector')
const ufButton = document.querySelector('#uf button');
const countriesModal = document.querySelector('.modal');
const showModal = document.querySelector('#show-modal');
const modalInput = showModal.querySelector('input');
const states = document.querySelectorAll('#svg-map .estado');

let params = {};
let pages = [];

$('#form').ajaxForm( result => {
    candidatesList.innerHTML = result;
});

function getCandidatesList(page) {
    if (page) {
        window.history.pushState('', 'Candidatos - Farol Verde', `/candidatos/?page=${page}`);
    }
    pagination.value = page ?? 1;

    $('#form').ajaxSubmit( result => candidatesList.innerHTML = result);
}

function toggleCountriesModal() {
    countriesModal.classList.toggle('open');
    getCandidatesList();
}

function toggleSubjects() {
    const toggleIcon = document.getElementById('toggle-icon');
    const subjectsInputs = document.querySelectorAll('.query__subjects input');

    subjects.classList.toggle('closed');
    toggleIcon.classList.toggle('closed');

    let status = toggleIcon.classList.contains('closed');
    localStorage.setItem('toggleStatus', status);

    if (status) {
        subjectsInputs.forEach(obj => obj.checked = false);
        getCandidatesList();
    }
}

function toggleSubjectDescription() {
    const description = document.querySelector('.subject');
    description.classList.toggle('closed');
}

function toggleUfBoard() {
    ufBoard.classList.toggle('open');
}

function togglePartyBoard() {
    partyBoard.classList.toggle('open');
}

if (localStorage.getItem('countriesModal') !== 'true') {
    toggleCountriesModal()
} else {getCandidatesList();}

if (localStorage.getItem('toggleStatus') == 'true') {
    toggleSubjects();
}

subjectsInputs.forEach(obj => obj.addEventListener('click', (e) => {
    if (e.target.checked) {
        subjectsInputs.forEach(input => input.checked = false);
        e.target.checked = true;
    }
    getCandidatesList();
}))

inputs.forEach(obj => obj.addEventListener('change', (e) => {
    getCandidatesList();
}));

nameInput.addEventListener('keypress', () => getCandidatesList());

states.forEach(state => state.addEventListener('click', () => {
    let input = Array.from(inputs)
        .filter(input => input.value == state.id)

    input[0].checked = true;
    getCandidatesList();
    toggleCountriesModal();
}));

showModal.addEventListener('click', () => {
    let { value } = modalInput;
    localStorage.setItem('countriesModal', !!value);
});

ufButton.addEventListener('click', toggleUfBoard);
partyButton.addEventListener('click', togglePartyBoard);

document.addEventListener('click', e => {
    let comp = e.target;
    if (comp != partyBoard && comp != partyButton) partyBoard.classList.remove('open');
    if (comp != ufBoard && comp != ufButton) ufBoard.classList.remove('open');
})
