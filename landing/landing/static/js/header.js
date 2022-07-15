const headerLinks = document.querySelector('.header__links');
const headerCloseBtn = document.querySelector('.header__close button')

function openMenu() {
    headerLinks.classList.toggle('open')
} 

headerCloseBtn.addEventListener('click', openMenu)