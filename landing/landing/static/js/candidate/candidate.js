const tabs = document.querySelectorAll('.tab');
const frames = document.querySelectorAll('.tab__frame');

const socialBtns = document.querySelectorAll('.social__btn');
const socialContents = document.querySelectorAll('.social__frame');

const keywordsList = document.querySelector('.keywords__list');
const keywordItemTpl = document.querySelector('#keyword__item--tpl');
const keywordContinueBtn = document.querySelector('.keywords__continue-btn');

const keywordsBtn = document.querySelector('.keywords__btn');
const keywordsBoard = document.querySelector('.keywords__board');
const keywordsInput = document.querySelector('.keywords__search input');

const facebookFrame = document.querySelector('.social__frame.facebook');
const twitterFrame = document.querySelector('.social__frame.twitter');
const instagramFrame = document.querySelector('.social__frame.instagram');

const postTpl = document.querySelector('#social__post--tpl');

var searchValue = '';

function openTab(tabName) {
    const tabBtn = document.querySelector(`.tab.${tabName}`);
    const tabContent = document.querySelector(`.tab__frame.${tabName}`);

    tabs.forEach(tab => tab.classList.remove('open'));
    frames.forEach(content => content.classList.add('hide'));
    
    tabBtn.classList.add('open');
    tabContent.classList.remove('hide');
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
function openSocial(socialName) {
    const socialBtn = document.querySelector(`.social__btn.${socialName}`);
    const socialContent = document.querySelector(`.social__frame.${socialName}`);

    socialBtns.forEach(social => social.classList.remove('open'));
    socialContents.forEach(content => content.classList.add('hide'));
    
    socialBtn.classList.add('open');
    socialContent.classList.remove('hide');
}

var startLetter = 'a';

function get_keywords() {
    let url = './api/keywords/' + startLetter
    if (searchValue.length) url += '/' + searchValue;
    $.ajax({url})
        .done((keywords) => {
            keywordsList.innerHTML = '';
            startLetter = keywords['next'];
            delete keywords['next'];

            for (let keyword in keywords) {
                var clone = keywordItemTpl.content.cloneNode(true);
                clone.querySelector('.keyword__category').innerText = keyword;
                startLetter = keyword;

                const words = keywords[keyword];
                words.forEach(word => {
                    var keywordItem = document.createElement('div');
                    keywordItem.classList.add('keyword__item', 'button-text');
                    keywordItem.innerText = word;
                    clone.appendChild(keywordItem);
                })
                keywordsList.appendChild(clone);
            }

            keywordContinueBtn.innerText = `continua (${startLetter})`;
        });
}

$.ajax({url: './api/social-media',})
    .done((data) => {
        let {hits} = data;
        hits = hits.hits;
        const socialApps = {Facebook: facebookFrame, Twitter: twitterFrame, Instagram: instagramFrame,}
        hits = hits.map(hit => hit._source['social-data'])
        hits = hits.forEach(post => {
            var clone = postTpl.content.cloneNode(true);
            if (post.tags) {
                var keywords = post.tags.split('|');
                keywords = keywords.map(keyword => {
                    var keywordItem = document.createElement('div');
                    keywordItem.classList.add('keyword__item', 'button-text');
                    keywordItem.innerText = keyword;
                    return keywordItem;
                })

                keywords.forEach(keyword => {
                    clone.querySelector('.post__keywords').appendChild(keyword)
                });
            }
            clone.querySelector('.post__content').innerText = post.texto;
            clone.querySelector('.post__date').innerText = post['data criado'];
            var postLink = clone.querySelector('.post__link');
            postLink.href = post.link;
            postLink.innerText = postLink.innerText.replace('rede', post.rede);
            socialApps[post.rede].appendChild(clone);
        })
    });

keywordContinueBtn.addEventListener('click', get_keywords)
keywordsBtn.addEventListener('click', () => {
    keywordsBoard.classList.toggle('open');
    keywordsBtn.classList.toggle('open');
})

keywordsInput.addEventListener('keyup', (e) => {
    searchValue = e.target.value;
    startLetter = 'a';
    console.log(searchValue)
    get_keywords();
})

get_keywords();
