document.addEventListener('turbo:load', () => {
  const confirmHandler = (event) => {
    const message = event.target.getAttribute('data-confirm');
    if (!confirm(message)) {
      event.preventDefault();
    }
  };

  document.querySelectorAll('[data-confirm]').forEach((element) => {
    element.addEventListener('click', confirmHandler);
  });
});
