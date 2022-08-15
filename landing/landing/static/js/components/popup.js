const popups = document.querySelectorAll('.popup')

popups.forEach(popup => {
    let closeBtn = popup.querySelector('.popup__close')
    popup.addEventListener('click', (e) => {
        if(e.target != popup && e.target != closeBtn) return;
        popup.classList.remove('open');
    })
})