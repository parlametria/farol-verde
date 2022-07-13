const candidatesList = document.getElementById('candidates__container');
const inputs = document.querySelectorAll('input, select');
const nameInput = document.getElementById('query__input');
const subjects = document.querySelector('.query__subjects');
const pagination = document.querySelector('#page');
const ufBoard = document.querySelector('.uf__selector')
const ufButton = document.querySelector('#uf button');

$('#form').ajaxForm( result => {
    candidatesList.innerHTML = result;
});

function getCandidatesList(page) {
    pagination.value = page ?? 1;

    $('#form').ajaxSubmit( result => {
        candidatesList.innerHTML = result;
    });
}

inputs.forEach(obj => obj.addEventListener('change', () => getCandidatesList()));
nameInput.addEventListener('keypress', () => getCandidatesList());

getCandidatesList();

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

if (localStorage.getItem('toggleStatus') == 'true') {
    toggleSubjects();
}

function toggleSubjectDescription() {
    const description = document.querySelector('.subject');
    description.classList.toggle('closed');
}

function toggleUfBoard() {
    ufBoard.classList.toggle('open');
    console.log("rodou")
}

ufButton.addEventListener('click', toggleUfBoard);
ufButton.addEventListener('focusout', toggleUfBoard);