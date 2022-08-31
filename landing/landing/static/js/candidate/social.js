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

const socialPagination = document.querySelector('.pagination#pages');
const socialPageBtn = document.querySelector('.pagination#pages .page-item');
const socialPagePrev = document.querySelector('.pagination#pages .page-prev');
const socialPageNext = document.querySelector('.pagination#pages .page-next');
const socialPageTotal = document.querySelector('.pagination#pages .total');

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

const socialSearch = {
    size: 20,
    page: 0,
    media: 'twitter',
    medias: [],
    keyword: '',
    total: 0,
    maxPage: 0,
    next: () => {
        socialSearch.page = socialSearch.page < socialSearch.maxPage ? socialSearch.page+1 : socialSearch.maxPage;
        getSocialData(socialSearch.media, socialSearch.keyword, socialSearch.page);
    },
    prev: () => {
        socialSearch.page = socialSearch.page > 0 ? socialSearch.page-1 : 0;
        getSocialData(socialSearch.media, socialSearch.keyword, socialSearch.page);
    },
    setPage: (page) => {
        socialSearch.page = Number(page);
        getSocialData(socialSearch.media, socialSearch.keyword, socialSearch.page);
    },
    setEmpty: () => {
        let clone = emptyFrame.content.cloneNode(true);
        let frame = socialSearch.getMediaFrame();
        frame.innerHTML = '';
        frame.append(clone);
    },
    getMediaFrame: () => {
        return socialSearch.medias[socialSearch.media];
    },
    getUrl: () => {
        let url = './api/social-media/' + socialSearch.media + '/';
        if (socialSearch.keyword) {
            url += socialSearch.keyword + '/';
        } else {
            url += '-/';
        }
        url += socialSearch.page;
        return url;
    },
    renderResults: (hits, frame) => {
        if (hits.length == 0) return socialSearch.setEmpty();

        hits = hits.map(hit => hit._source['social-data'])
        hits = hits.map(post => {
            var clone = postTpl.content.cloneNode(true);
            post.texto = post.texto.replaceAll(/\&#\d*;/g, emojiCode => {
                emojiCode = parseInt(emojiCode.slice(2,-1))
                return String.fromCodePoint(emojiCode)
            })
            if (post.termo_filtro) {
                var keywords = post.termo_filtro.split('|');
                keywords = keywords.map(keyword => {
                    var keywordItem = document.createElement('div');
                    if(keyword == socialSearch.keyword) {
                        keywordItem.classList.add('marked');
                    }
                    keywordItem.classList.add('keyword__item', 'button-text');
                    keywordItem.addEventListener('click', () => {
                        let _keyword = '';
                        if(!keywordItem.classList.contains('marked')) {
                            keywordItem.classList.add('marked');
                            _keyword = keyword;
                        }
                        getSocialData(null, _keyword);
                        getKeywords();
                    });
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
        frame.innerHTML = '';
        frame.append(...hits);
    },
    renderPagination: (total) => {
        socialSearch.total = total;
        socialSearch.maxPage = Math.ceil(total/socialSearch.size)-1;
        socialPagination.querySelectorAll('.page-item.paginate').forEach(b => b.remove());
        for (i=0; i<=socialSearch.maxPage; i++) {
          if (i < socialSearch.page - 2 || i > socialSearch.page + 2) continue;
          const pageBtn = socialPageBtn.cloneNode(true);
          pageBtn.innerHTML = i+1;
          pageBtn.classList.add('paginate');
          if (i == socialSearch.page) {
              pageBtn.classList.add('active');
          }
          if (socialSearch.page == 0) {
              socialPagePrev.disabled = true;
          } else {
              socialPagePrev.disabled = false;
          }
          if (socialSearch.page == socialSearch.maxPage) {
              socialPageNext.disabled = true;
          } else {
              socialPageNext.disabled = false;
          }
          socialPagination.insertBefore(pageBtn,socialPageBtn);
          pageBtn.addEventListener('click', () => socialSearch.setPage(Number(pageBtn.innerHTML)-1));
        }
        const begin = socialSearch.page * socialSearch.size;
        const end = begin + socialSearch.size < socialSearch.total ? begin + socialSearch.size : socialSearch.total;
        socialPageTotal.innerHTML = `Mostrando ${ begin } a ${ end } de ${socialSearch.total}.`;
        socialPagination.style.visibility = 'visible';
    }
}

function openSocialTab(socialName) {
    const socialBtn = document.querySelector(`.social__btn.${socialName}`);
    const socialContent = document.querySelector(`.social__frame.${socialName}`);

    getSocialData(socialName);

    document.querySelectorAll('.keyword__item.marked').forEach(keywordItem => {
        keywordItem.classList.remove('marked')
    })

    socialBtns.forEach(social => social.classList.remove('open'));
    socialContents.forEach(content => content.classList.add('hide'));
    
    socialBtn.classList.add('open');
    socialContent.classList.remove('hide');
}

let sectionRequest;
let searchValue = '';

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
                if (word.length === 1) item.className = 'keyword__item button-text';
                else item.className = 'keyword__category overline'

                item.addEventListener('click', (e) => {
                    let keyword = '';
                    if(!item.classList.contains('marked')) {
                        item.classList.add('marked');
                        keyword = word;
                    }
                    getSocialData(null, keyword);
                    getKeywords();
                });
                item.className = 'keyword__item button-text';
                if (word == socialSearch.keyword) {
                    item.classList.add('marked');
                } else {
                    item.classList.remove('marked');
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

function getSocialData(socialApp, keyword, page) {
    if(socialMediaRequest) socialMediaRequest.abort();


    let { frame, url } = getSocialSearch(socialApp, keyword, page);

    const setLoading = () => {
        frame.innerHTML = '<div class="spinning-load"><i class="spin fa fa-2x fa-spinner"></i></div>';
    }

    setLoading();
    socialMediaRequest = $.ajax({url})
        .done((data) => {
            let { hits, total } = data.hits;
            socialSearch.renderResults(hits, frame);
            socialSearch.renderPagination(total.value);
        })
        .fail(socialSearch.setEmpty);
}

function getSocialSearch(media, keyword, page) {
    socialSearch.media = media ? media.toLowerCase() : socialSearch.media;
    socialSearch.keyword = keyword == undefined ? socialSearch.keyword : keyword;
    socialSearch.page = page || 0;
    socialSearch.medias = { facebook: facebookFrame, twitter: twitterFrame, instagram: instagramFrame };
    return {frame: socialSearch.getMediaFrame(), url: socialSearch.getUrl(), ...socialSearch };
}

getSocialData();
