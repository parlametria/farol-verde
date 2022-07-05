function setImg() {
  const current = Number(localStorage.getItem('curr_img'));
  const next = (current < 11) ? current + 1 : 0;
  
  localStorage.setItem('curr_img',next);
  document.querySelectorAll('.side-images img').forEach((img, i) => {
    if(i === current) {
      img.style.opacity = '1';
    } else {
      img.style.opacity = '0';
    }
  })
  document.querySelector('.side-images').style.opacity='1';
}
setImg();
setInterval(setImg, 20000);
