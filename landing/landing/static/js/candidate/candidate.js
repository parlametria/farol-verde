const resultTab = document.querySelector('.tab.result');
const activityTab = document.querySelector('.tab.activity');
const votingPropositionTpl = document.querySelector('#voting__proposition--tpl');

const activityContent = document.querySelector('.activity__content');
const resultContent = document.querySelector('.result__content');

const adhesionProgressValue = document.querySelector('.adhesion .progress h4');
const adhesionProgressBar = document.querySelector('.adhesion .progress__inner');

const votingPropositions = document.querySelector('.voting__propositions');
const votingEmpty = document.querySelector('.voting__empty');

function openTab(tabName) {
    const tab = tabName === 'result' ? resultTab : activityTab;
    const content = tabName === 'result' ? resultContent : activityContent;
    const otherTab = tabName === 'result' ? activityTab : resultTab;
    const otherContent = tabName === 'result' ? activityContent : resultContent;

    tab.classList.add('open');
    otherTab.classList.remove('open');

    content.classList.remove('hide');
    otherContent.classList.add('hide');
}

$.ajax({url: './api/adesao',})
    .done((data) => {
        const {adhesion, propositions} = data;
        adhesionProgressValue.innerHTML = `${adhesion}%`;
        adhesionProgressBar.style.width = `${adhesion}%`;

        if(propositions.length == 0) return;

        votingEmpty.classList.add('hide');
        votingPropositions.classList.remove('hide');
        propositions.forEach((proposition) => {
            const propositionEl = votingPropositionTpl.content.cloneNode(true);
            propositionEl.querySelector('.voting__proposition h4').innerHTML = proposition.proposition_name;
            propositionEl.querySelector('.proposition__number').innerHTML = proposition.proposition_number;
            propositionEl.querySelector('.progress h4').innerHTML = `${proposition.adhesion}%`;
            propositionEl.querySelector('.progress__inner').style.width = `${proposition.adhesion}%`;
            votingPropositions.appendChild(propositionEl);
        })
    });
