document.addEventListener('turbo:load', () => {
  const carousels = document.querySelectorAll('.carousel-container');

  carousels.forEach(carousel => {
    const items = carousel.querySelectorAll('.carousel-item');
    let currentItem = 0;

    console.log(carousel)
    console.log(items)

    const updateCarousel = () => {
      items.forEach((item, index) => {
        console.log(item)
        console.log(index)

        item.classList.toggle('is-active', index === currentItem);
      });
    };

    carousel.querySelector('#next').addEventListener('click', () => {
      currentItem = (currentItem + 1) % items.length;
      console.log(currentItem)
      updateCarousel();
    });

    carousel.querySelector('#prev').addEventListener('click', () => {
      currentItem = (currentItem - 1 + items.length) % items.length;
      console.log(currentItem)

      updateCarousel();
    });

    updateCarousel();
  });
});

document.addEventListener('DOMContentLoaded', function() {
  document.dispatchEvent(new Event('turbo:load'));
});