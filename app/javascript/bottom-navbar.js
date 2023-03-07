const navbarItems = document.querySelectorAll('.nav-item-bottom');

navbarItems.forEach((item) => {
  item.addEventListener('submit', (event) => {
    // Remove the active class from all items
    navbarItems.forEach((item) => {
      item.classList.remove('active');
    });
    // Add the active class to the clicked item
    event.currentTarget.classList.add('active');
  });
});
