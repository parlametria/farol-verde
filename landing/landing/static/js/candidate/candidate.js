const tabs = document.querySelectorAll('.tab');
const frames = document.querySelectorAll('.tab__frame');

const adhesionProgressValue = document.querySelector('.adhesion__data h4');
const adhesionProgressBar = document.querySelector('.adhesion__data .progress__inner');
const votingPropositions = document.querySelector('.voting__propositions');
const votingPropositionTpl = document.querySelector('#voting__proposition--tpl');

const votingEmpty = document.querySelector('.voting__empty');

urlParams = new URLSearchParams(window.location.search);

function openTab(tabName) {
    const tabBtn = document.querySelector(`.tab.${tabName}`);
    const tabContent = document.querySelector(`.tab__frame.${tabName}`);

    tabs.forEach(tab => tab.classList.remove('open'));
    frames.forEach(content => content.classList.add('hide'));
    
    tabBtn.classList.add('open');
    tabContent.classList.remove('hide');
}

if (urlParams.has('tab')) {
    const tab = urlParams.get('tab');
    openTab(tab);
} else {
    document.querySelector(`.tab`).click();
}

$.ajax({url: './api/adesao',})
    .done((data) => {
        var {adhesion, propositions} = data;
        adhesion = Math.round(adhesion * 100)
        adhesionProgressValue.innerHTML = `${adhesion}%`;
        adhesionProgressBar.style.width = `${adhesion}%`;

        if(propositions.length == 0) return;

        votingPropositions.classList.remove('hide');
        propositions.forEach((proposition) => {
            var {adhesion, about} = proposition;
            adhesion = Math.round(adhesion * 100)
            const propositionEl = votingPropositionTpl.content.cloneNode(true);
            propositionEl.querySelector('.voting__proposition h4').innerHTML = about;
            // propositionEl.querySelector('.proposition__number').innerHTML = proposition.proposition_number;
            propositionEl.querySelector('.progress h4').innerHTML = `${adhesion}%`;
            propositionEl.querySelector('.progress__inner').style.width = `${adhesion}%`;
            votingPropositions.appendChild(propositionEl);
        })
    })
    .fail((err) => {
        votingEmpty.classList.remove('hide');
    });

function formatDate(date) {
    let d = new Date(date);
    let year = d.getFullYear();
    let month = d.getMonth();
    let day = d.getDate();
    let hour = `${d.getHours()}`;
    let minute = `${d.getMinutes()}`;
    hour = hour.length == 1 ? '0' + hour : hour;
    minute = minute.length == 1 ? '0' + minute : minute;
    return `${hour}:${minute} ${day} ${months[month]} ${year}`;
}