const candidatesList = document.getElementById('candidates__container');
const inputs = document.querySelectorAll('form :is(input, select)');
const nameInput = document.getElementById('query__input');
const subjects = document.querySelector('.query__subjects');
const pagination = document.querySelector('#page');
const ufBoard = document.querySelector('.uf__selector')
const ufButton = document.querySelector('#uf button');
const countriesModal = document.querySelector('.modal');
const showModal = document.querySelector('#show-modal');
const modalInput = showModal.querySelector('input');
const states = document.querySelectorAll('.estado');

const selectedStates = []

$('#form').ajaxForm( result => {
    candidatesList.innerHTML = result;
});

function getCandidatesList(page) {
    pagination.value = page ?? 1;

    $('#form').ajaxSubmit( result => {
        candidatesList.innerHTML = result;
    });
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

    var status = toggleIcon.classList.contains('closed');
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

if (localStorage.getItem('countriesModal') !== 'true') {
    toggleCountriesModal()
} else {getCandidatesList();}

if (localStorage.getItem('toggleStatus') == 'true') {
    toggleSubjects();
}

inputs.forEach(obj => obj.addEventListener('change', () => getCandidatesList()));
nameInput.addEventListener('keypress', () => getCandidatesList());

states.forEach(state => state.addEventListener('click', () => {
    state.classList.toggle('selected');
    var input = Array.from(inputs)
        .filter(input => input.value == state.id)
    if (state.classList.contains('selected')) {
        selectedStates.push(state.id);
    }
}));

function getSelectedStates() {
    selectedStates.forEach(state => {
        var input = Array.from(inputs)
            .filter(input => input.value == state)
        input[0].checked = true;
    })
    getCandidatesList();
    toggleCountriesModal();
}

showModal.addEventListener('click', () => {
    var { value } = modalInput;
    localStorage.setItem('countriesModal', !!value);
});

ufButton.addEventListener('click', toggleUfBoard);
ufBoard.addEventListener('focusout', toggleUfBoard);