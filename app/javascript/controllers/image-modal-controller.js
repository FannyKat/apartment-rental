document.addEventListener('turbo:load', function() {

  const baseUrl = "http://localhost:3000"

  // Retrieve source image to open it in the modal
  function openModal(imageSrc) {
    var modalImage = document.getElementById('modal-image-src')

    modalImage.src = baseUrl + imageSrc

    document.getElementById('modal-image').classList.add('is-active');
  }

  // Close modal
  function closeModal(modalImage) {
    modalImage.classList.remove('is-active');
  }

  // Open Image Modal on click
  (document.querySelectorAll('[data-target="modal-image-trigger"]') || []).forEach((trigger) => {

    trigger.addEventListener('click', () => {
      var imageSrc = trigger.getAttribute('data-src');

      openModal(imageSrc);
    });

  });

  // Close Image Modal on click
  (document.querySelectorAll('.modal-background, .modal-close, .modal-card-head .delete, .modal-card-foot .button') || []).forEach((close) => {
    
    const modalClosest = close.closest('.modal');

    close.addEventListener('click', () => {
      closeModal(modalClosest)
    });

  });

  // Close Image Modal on ESC key
  document.addEventListener('keydown', (event) => {

    if(event.key === "Escape") {
      closeAllModals();
    }

  });

});

document.addEventListener('DOMContentLoaded', function() {
  document.dispatchEvent(new Event('turbo:load'));
});