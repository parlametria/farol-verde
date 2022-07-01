function setImg() {
  const current = Number(localStorage.getItem('curr_img'));
  const next = (current < 5) ? current + 1 : 0;
  localStorage.setItem('curr_img',next);
  document.querySelectorAll('.side-images img').forEach((img, i) => {
    if (i === current) {
      img.style.display = 'block';
    } else {
      img.style.display = 'none';
    }
  })
}
setImg();
setInterval(setImg,25000);
