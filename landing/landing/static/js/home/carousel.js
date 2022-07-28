const carouselSlides = document.querySelectorAll('.carousel__slide');
const carouselDots = document.querySelectorAll('.carousel__dot');
var currentSlide = 0;
var slideTransition = true;
const maxState = carouselSlides.length - 1;

function render() {
    carouselSlides.forEach((slide, key) => {
        if(key === this.currentState) return
        carouselDots[key].classList.remove('active');
        slide.classList.remove('active');
    });

    carouselSlides[currentSlide].classList.add('active');
    carouselDots[currentSlide].classList.add('active');
}

function nextStage() {
    if (currentSlide == maxState) {
        currentSlide = -1;
    }
    currentSlide += 1;
    render()
}


render();
setInterval( () => {
    console.log(slideTransition);
    if(slideTransition) {
        nextStage();
    }
}, 3000 );

carouselDots.forEach( (dot, key) => {
    dot.addEventListener('click', () => {
        currentSlide = key;
        render();

        slideTransition = false;
    }
    );
})