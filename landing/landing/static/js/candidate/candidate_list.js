const candidatesList = document.getElementById('candidates__container');
const inputs = document.querySelectorAll('input, select');
const nameInput = document.getElementById('query__input');
const subjects = document.querySelector('.query__subjects');

$('#form').ajaxForm( result => {
    candidatesList.innerHTML = result;
});

function get_candidates_list() {
    $('#form').ajaxSubmit( result => {
        candidatesList.innerHTML = result;
    });
}

inputs.forEach(obj => obj.addEventListener('change', () => get_candidates_list()));
nameInput.addEventListener('keypress', () => get_candidates_list());

get_candidates_list();

function toggleSubjects() {
    const toggleIcon = document.getElementById('toggle-icon');
    const subjectsInputs = document.querySelectorAll('.query__subjects input');

    subjects.classList.toggle('closed');
    toggleIcon.classList.toggle('closed');

    var status = toggleIcon.classList.contains('closed');
    localStorage.setItem('toggleStatus', status);

    if (status) {
        subjectsInputs.forEach(obj => obj.checked = false);
        get_candidates_list();
    }
}

if (localStorage.getItem('toggleStatus') == 'true') {
    toggleSubjects();
}

function toggleSubjectDescription() {
    const description = document.querySelector('.subject');
    description.classList.toggle('closed');
}