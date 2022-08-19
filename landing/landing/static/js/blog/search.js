
const posts = document.querySelector('#posts-container .posts');
const spinner = document.querySelector('.spinning-load');

const contentEl = document.querySelector('.content');
const contentPos = contentEl.getBoundingClientRect();

const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
const parameters = ["search"];

const searchInput = document.querySelector('#search-container input');

var refreshPage = true;

if(queryString)
    window.scrollBy(0, contentPos.y - 60);

const Filters = {
    search: urlParams.get('search'),

    clear: () => {
        Filters.search = null;

        searchInput.value = '';
        searchInput.focus();
        
        getPosts();
    },

    set: (filter, value) => {
        Filters[filter] = Filters[filter] == value ? null : value;
        getPosts();
    }
}

const getPosts = (startCount) => {
    startCount ??= 0;
    let path = '/blog/' + '?start=' + startCount;

    parameters.forEach(key => {
        if(Filters[key]) path += `&${key}=${Filters[key]}`;
    });

    $.ajax({
        url: path,
        beforeSend: () => {
            if(!startCount) spinner.classList.remove('hide')
        }})
        .done((data) => {
            if(startCount === 0) posts.innerHTML = '';
            
            posts.innerHTML += data;
            
            spinner.classList.add('hidden');
            setTimeout(() => {
                spinner.classList.add('hide');
                spinner.classList.remove('hidden');
                refreshPage = data.length !== 0;
            }, 200);
        });
}

getPosts();

if (searchInput) searchInput.addEventListener('keyup', (e) => {
    var {value} = e.target;
    value = value.length >= 2 ? value : null;
    
    setTimeout(Filters.set('search', value), 2000);
})

document.addEventListener('scroll', () => {
    if(!refreshPage) return;
    const windowY = window.scrollY;
    const {verticalPoint} = document.querySelector('footer').getBoundingClientRect();
    
    if(windowY > verticalPoint - 100) {
        refreshPage = false;
        getPosts(posts.childElementCount);
    }
})
