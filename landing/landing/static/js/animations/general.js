const frontpage = document.querySelector('#frontpage')

const testimonial = document.querySelector('#testimonial')
const testimonial_list = document.querySelectorAll('.testimonial-brand')


var winPos = window.scrollY

const inScreen = position =>{
    if(isNaN(position)) position = position.offsetTop
    return winPos + window.innerHeight > position && winPos < position
}

function showElements(){
    winPos = window.scrollY

    if(inScreen(testimonial?.offsetTop + 200)){
        testimonial_list.forEach( (elem, index) => 
            setTimeout(() => {
                elem.classList.add('fade-right')
            }, index * 125))
    }
}

showElements()

document.addEventListener('scroll', showElements)
