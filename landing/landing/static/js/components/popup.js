const popups = document.querySelectorAll('.popup')

popups.forEach(popup => {
    let closeBtn = popup.querySelector('.popup__close')
    closeBtn.addEventListener('click', () => {
        popup.classList.remove('open')
    })
})