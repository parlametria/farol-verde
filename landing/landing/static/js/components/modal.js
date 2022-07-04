function setToggle() {
  const modal = document.querySelector('.modal');
  document.querySelector('.modal-toggle').addEventListener('click',() => {
    modal.classList.add('open');
    const openEvent = new Event('modal-open', {
        bubbles: true,
        cancelable: true,
        composed: false
    });
    modal.dispatchEvent(openEvent);
  });

  
  document.querySelectorAll('.modal-backdrop, .modal-close').forEach(
    (elm) => elm.addEventListener('click',() => {
      modal.classList.remove('open');
    }));
}

setToggle()
