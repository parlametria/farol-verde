const tabs = document.querySelectorAll('.tab');
const frames = document.querySelectorAll('.tab__frame');

const socialBtns = document.querySelectorAll('.social__btn');
const socialContents = document.querySelectorAll('.social__frame');

const keywordsList = document.querySelector('.keywords__list');

const keywordsNext = document.querySelector('.keywords__next');
const keywordsPrev = document.querySelector('.keywords__prev');

const keywordsBtn = document.querySelector('.keywords__btn');
const keywordsBoard = document.querySelector('.keywords__board');
const keywordsInput = document.querySelector('.keywords__search input');
const keywordsOptionsList = document.querySelector('.keywords__options-list');

const facebookFrame = document.querySelector('.social__frame.facebook');
const twitterFrame = document.querySelector('.social__frame.twitter');
const instagramFrame = document.querySelector('.social__frame.instagram');

const postTpl = document.querySelector('#social__post--tpl');
const keywordOptionTpl = document.querySelector("#keyword__option--tpl");

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

var keywordsPage = {
    page: 0,
    limit: 1000,
    next: () => {
        if (keywordsPage.page >= keywordsPage.limit) return;
        keywordsPage.page++;
        get_keywords();
    },
    prev: () => {
        if (keywordsPage == 0) return
        keywordsPage.page--;
        get_keywords();
    },
    setPage: (page) => {
        if(page < 0 || page >= keywordsPage.limit) return;
        keywordsPage.page = page;
        get_keywords();
    }
};

function get_keywords() {
    let sectionUrl = './api/keywords-sections';
    let url = './api/keywords/' + keywordsPage.page;
    if (searchValue.length) {
        url += '/' + searchValue;
        sectionUrl += '/' + searchValue;
    }

    $.ajax({url: sectionUrl})
        .done((data) => {
            var {sections, total} = data;
            keywordsPage.limit = total;
            sections = sections.map( (section, index) => {
                var clone = keywordOptionTpl.content.cloneNode(true);
                clone.querySelector('span').innerText = section;
                if (index == keywordsPage.page)
                    clone.querySelector('input').checked = true;
                clone.querySelector('span').onclick = () => {
                    keywordsPage.setPage(index);
                }
                return clone
            } )
            keywordsOptionsList.innerHTML = '';
            keywordsOptionsList.append(...sections);
        } )

    $.ajax({url})
        .done((keywords) => {
            keywordsList.innerHTML = '';
            keywords = keywords.map(word => {
                const item = document.createElement('div');
                if (word.length == 1) {
                    item.className = 'keyword__category overline'
                } else {
                    item.addEventListener('click', () => get_social_media(word));
                    item.className = 'keyword__item button-text';
                }
                item.innerHTML = word;
                if (word.length > 30) item.classList.add('long');
                return item;
            })
            keywordsList.append(...keywords);
        });

    if (keywordsPage.page == 0) keywordsPrev.classList.add('hidden');
    else keywordsPrev.classList.remove('hidden');
    if (keywordsPage.page == keywordsPage.limit) keywordsNext.classList.add('hidden');
    else keywordsNext.classList.remove('hidden');
}

keywordsNext.addEventListener('click', keywordsPage.next);
keywordsPrev.addEventListener('click', keywordsPage.prev);

keywordsInput.addEventListener('keyup', (e) => {
    searchValue = e.target.value;
    keywordsPage = 0;
    get_keywords();
})

keywordsBtn.addEventListener('click', () => {
    keywordsBoard.classList.toggle('open');
    keywordsBtn.classList.toggle('open');
} );

get_keywords();

function get_social_media(keyword) {
    console.log("runs")
    let url = './api/social-media';
    if (keyword) url += '/' + keyword;
    $.ajax({url})
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
                var postLink = clone.querySelector('.post__link a');
                postLink.href = post.link;
                postLink.innerText = `abrir no ${post.rede}`;
                socialApps[post.rede].innerHTML = '';
                socialApps[post.rede].appendChild(clone);
            })
        });
}

get_social_media();
