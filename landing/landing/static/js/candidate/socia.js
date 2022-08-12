const facebookFrame = document.querySelector('.social__frame.facebook');
const twitterFrame = document.querySelector('.social__frame.twitter');
const instagramFrame = document.querySelector('.social__frame.instagram');

const socialBtns = document.querySelectorAll('.social__btn');
const socialContents = document.querySelectorAll('.social__frame');

const keywordsBtn = document.querySelector('.keywords__btn');
const keywordsBoard = document.querySelector('.keywords__board');
const keywordsInput = document.querySelector('.keywords__search input');
const keywordsOptionsList = document.querySelector('.keywords__options-list');

const keywordsList = document.querySelector('.keywords__list');

const keywordsNext = document.querySelector('.keywords__next');
const keywordsPrev = document.querySelector('.keywords__prev');

const keywordOptionTpl = document.querySelector("#keyword__option--tpl");
const emptyFrame = document.querySelector('#social__empty--tpl');

const postTpl = document.querySelector('#social__post--tpl');

const months = ['JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN', 'JUL', 'AGO', 'SET', 'OUT', 'NOV', 'DEZ'];

const keywordsPage = {
    page: 0,
    limit: 1000,
    next: () => {
        if (keywordsPage.page >= keywordsPage.limit) return;
        keywordsPage.page++;
        getKeywords();
    },
    prev: () => {
        if (keywordsPage == 0) return
        keywordsPage.page--;
        getKeywords();
    },
    setPage: (page) => {
        if(page < 0 || page >= keywordsPage.limit) return;
        keywordsPage.page = page;
        getKeywords();
    }
};

function openSocial(socialName) {
    const socialBtn = document.querySelector(`.social__btn.${socialName}`);
    const socialContent = document.querySelector(`.social__frame.${socialName}`);

    getSocialMedia(socialName);

    socialBtns.forEach(social => social.classList.remove('open'));
    socialContents.forEach(content => content.classList.add('hide'));
    
    socialBtn.classList.add('open');
    socialContent.classList.remove('hide');
}


let sectionRequest;
let searchValue = '';
let markedKeyword = '';

function setSearchValue(value) {
    searchValue = value == searchValue ? '' : value;
}

function getKeywords() {
    let sectionUrl = './api/keywords-sections';
    let url = './api/keywords/' + keywordsPage.page;
    if (searchValue.length) {
        url += '/' + searchValue;
        sectionUrl += '/' + searchValue;
    }

    if(sectionRequest) sectionRequest.abort();
    sectionRequest = $.ajax({url: sectionUrl})
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
            if(sections.length == 0) {
                let alert = document.createElement('h4')
                alert.innerText = "Nenhuma palavra-chave encontrada"
                sections.push(alert);
            };
            keywordsOptionsList.append(...sections);
        } )

    $.ajax({url})
        .done((keywords) => {
            keywords = keywords.map(word => {
                const item = document.createElement('div');
                if (word.length == 1) {
                    item.className = 'keyword__category overline'
                } else {
                    item.addEventListener('click', (e) => {
                        getSocialMedia(null, word)
                        getKeywords()
                    });
                    item.className = 'keyword__item button-text';
                }
                if (word == markedKeyword) {
                    item.classList.add('marked');
                }
                item.innerHTML = word;
                if (word.length > 30) item.classList.add('long');
                return item;
            })
            keywordsList.innerHTML = '';
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
    setSearchValue(e.target.value);
    keywordsPage.page = 0;
    getKeywords();
})

keywordsBtn.addEventListener('click', () => {
    keywordsBoard.classList.toggle('open');
    keywordsBtn.classList.toggle('open');
} );

getKeywords();

let socialMediaRequest;

function getSocialMedia(socialApp, keyword) {
    socialApp ??= 'twitter';
    socialApp = socialApp.toLowerCase();
    let url = './api/social-media/' + socialApp;
    if (keyword) {
        url += '/' + keyword.replaceAll(' ', '_');
        markedKeyword = keyword;
    }

    if(socialMediaRequest) socialMediaRequest.abort();

    const socialApps = {facebook: facebookFrame, twitter: twitterFrame, instagram: instagramFrame,}
    let socialFrame = socialApps[socialApp];

    const setEmpty = () => {
        let clone = emptyFrame.content.cloneNode(true);
        socialFrame.innerHTML = '';
        socialFrame.append(clone);
    }

    let children = socialFrame.childNodes
    if (children.length == 1 && children[0].classList.contains('empty')) return setEmpty();

    socialMediaRequest = $.ajax({url})
        .done((data) => {
            let {hits} = data;
            hits = hits.hits;

            if (hits.length == 0) return setEmpty();

            hits = hits.map(hit => hit._source['social-data'])
            Object.values(socialApps).forEach(app => app.innerHTML = '');
            hits = hits.map(post => {
                var clone = postTpl.content.cloneNode(true);
                if (post.tags) {
                    var keywords = post.tags.split('|');
                    keywords = keywords.map(keyword => {
                        var keywordItem = document.createElement('div');
                        if(keyword == markedKeyword) {
                            keywordItem.classList.add('marked');
                        }
                        keywordItem.classList.add('keyword__item', 'button-text');
                        keywordItem.addEventListener('click', () => getSocialMedia(keyword));
                        keywordItem.innerText = keyword;
                        return keywordItem;
                    })

                    keywords.forEach(keyword => {
                        clone.querySelector('.post__keywords').appendChild(keyword)
                    });
                }
                clone.querySelector('.post__content').innerText = post.texto;
                let postDate = formatDate(post['data criado']);
                clone.querySelector('.post__date').innerText = postDate;
                var postLink = clone.querySelector('.post__link a');
                postLink.href = post.link;
                postLink.innerText = `abrir no ${post.rede}`;
                return clone;
            });
            socialFrame.innerHTML = '';
            socialFrame.append(...hits);
        })
        .fail(setEmpty);
}

getSocialMedia();
