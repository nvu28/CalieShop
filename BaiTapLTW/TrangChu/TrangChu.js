const track = document.querySelector(".multi-carousel-track");
const images = document.querySelectorAll(".multi-carousel-track img");
let currentIndex = 0;

function slideCarousel() {
    currentIndex++;
    track.style.transform = `translateX(calc(-${currentIndex * 25}% - ${currentIndex * 10}px))`;
    if (currentIndex >= images.length - 4) {
        currentIndex = 0;
        track.style.transition = "none";
        track.style.transform = "translateX(0)";
        setTimeout(() => {
            track.style.transition = "transform 0.8s ease-in-out";
        }, 50);
    }
}

setInterval(slideCarousel, 5000);
