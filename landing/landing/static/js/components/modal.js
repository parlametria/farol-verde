function setToggle() {
  const modal = document.querySelector('.modal');
  if (!modal) return;
  document.querySelector('.modal__toggle').addEventListener('click',() => {
    modal.classList.add('open');
    const openEvent = new Event('modal__open', {
        bubbles: true,
        cancelable: true,
        composed: false
    });
    modal.dispatchEvent(openEvent);
  });

  
  document.querySelectorAll('.modal__backdrop, .modal__close').forEach(
    (elm) => elm.addEventListener('click',() => {
      modal.classList.remove('open');
    }));
}

setToggle()
