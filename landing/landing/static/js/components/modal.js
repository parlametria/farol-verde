function setToggle() {
  document.querySelector('.modal-toggle').addEventListener('click',(e) => {
    document.querySelector('.modal').classList.add('open');
  });
  document.querySelectorAll('.modal-backdrop, .modal-close').forEach((elm) => elm.addEventListener('click',(e) => {
    document.querySelector('.modal').classList.remove('open');
  }));
}
setToggle()
