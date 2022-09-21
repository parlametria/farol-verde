const popups = document.querySelectorAll('.popup');
const knowMore = document.querySelector('.know-more');

popups.forEach(popup => {
    let closeBtn = popup.querySelector('.popup__close');
    popup.addEventListener('click', (e) => {
        if(e.target != popup && e.target != closeBtn) return;
        popup.classList.remove('open');
    })
})

function openKnowMore(){
    console.log(knowMore);
    knowMore.classList.toggle('open');
}