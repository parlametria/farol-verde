const headerLinks = document.querySelector('.header__links');

const url = window.location.pathname.split('/');

const options = {
    'enquete': document.querySelector('.header__item.enquete'),
    'candidatos': document.querySelector('.header__item.candidatos'),
}

options[url[1]].classList.add('active');

function openMenu() {
    headerLinks.classList.toggle('open')
} 