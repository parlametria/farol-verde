const propositionsList = document.querySelector('.propositions__list');
const propositionItemTpl = document.querySelector('#proposition__item--tpl');

const propositionEmptyTpl = document.querySelector('#proposition__empty--tpl');

const propositionsSearch = document.querySelector('.propositions__search');

function getPropositions(search) {
    let url = './api/propositions';
    if (search) url += '/' + search;
    $.ajax({url})
        .done((propositions) => {
            if (search && propositions.length == 0) {
                let clone = propositionEmptyTpl.content.cloneNode(true);
                propositionsList.innerHTML = '';
                propositionsList.appendChild(clone);
                return;
            }
            propositions = propositions.map(proposition => {
                let { data, ementa, sigla_tipo, numero, ano } = proposition;
                let title = `${sigla_tipo} ${numero}/${ano}`;
                data = formatDate(data);
                data = data.split(' ').slice(1).join(' ');
                var clone = propositionItemTpl.content.cloneNode(true);
                clone.querySelector('.proposition__number').innerText = title;
                clone.querySelector('.proposition__summary').innerText = ementa;
                clone.querySelector('.proposition__date').innerText = data;
                return clone;
            } )
            propositionsList.innerHTML = '';
            propositionsList.append(...propositions);
        })
}

propositionsSearch.addEventListener('keyup', (e) => getPropositions(propositionsSearch.value))

getPropositions();