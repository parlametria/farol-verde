
const posts = document.querySelector('#posts-container .posts');
const spinner = document.querySelector('.spinning-load');

const contentEl = document.querySelector('.content');
const contentPos = contentEl.getBoundingClientRect();

const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
const parameters = ["search", "category", "tag"];

const institucionalFilter = document.querySelector('#category-filters button.institucional');
const tutoriaisFilter = document.querySelector('#category-filters button.tutoriais');
const comunidadeFilter = document.querySelector('#category-filters button.comunidade');

const searchInput = document.querySelector('#search-container input');

var mobileCategory = document.querySelector('#recent-posts-category');

var refreshPage = true;

if(queryString)
    window.scrollBy(0, contentPos.y - 60);

const Filters = {
    category: urlParams.get('category'),
    tag: urlParams.get('tag'),
    search: urlParams.get('search'),

    clear: () => {
        Filters.category = null;
        Filters.tag = null;
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

const updatePostsFilters = () => {
    let filtersElement = document.querySelector('#posts-filters');
    let filtersText = "Exibindo posts com "

    const filtersTexts = {
        category: `a categoria <u>${Filters['category']}</u> `,
        tag: `a tag <u>${Filters['tag']}</u> `,
        search: `o termo <u>${Filters['search']}</u> `
    }

    parameters.forEach(key => {
        if(!Filters[key]) return
        
        if(filtersText.length > 19) filtersText += ' e ';
        filtersElement.classList.remove('hide');
        filtersElement.querySelector('.clear-filters')
            .addEventListener('click', Filters.clear)

        filtersText += filtersTexts[key];
    })

    if(filtersText.length > 19){
        filtersElement.querySelector('.filters-text').innerHTML = filtersText;
        return
    }
    
    filtersElement.classList.add('hide');
    document.querySelectorAll('#category-filters button')
        .forEach( item => item.classList.remove('active') );
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
            updatePostsFilters()
            
            spinner.classList.add('hidden');
            setTimeout(() => {
                spinner.classList.add('hide');
                spinner.classList.remove('hidden');
                refreshPage = data.length !== 0;
            }, 200);
        });
}

getPosts();

function changeCategory(category){
    document.querySelectorAll('#category-filters button')
        .forEach( item => item.classList.remove('active') );
    let filterEl = document.querySelector('#category-filters button.' + category);

    Filters.set('category', category);
    if(Filters['category'] === category)
        filterEl.classList.add('active');
}

function changeCategoryMobile(categoryElement, category) {
    Filters.set('category', category);
    if(Filters['category'] === category)
        mobileCategory.classList.remove("category-list__item--selected");
        categoryElement.classList.add("category-list__item--selected");
        mobileCategory = categoryElement;
    
}

institucionalFilter.addEventListener('click', () => changeCategory('institucional'))
tutoriaisFilter.addEventListener('click', () => changeCategory('tutoriais'))
comunidadeFilter.addEventListener('click', () => changeCategory('comunidade'))

searchInput.addEventListener('keyup', (e) => {
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