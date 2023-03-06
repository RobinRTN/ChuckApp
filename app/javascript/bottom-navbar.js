const bottomNavbarElem = document.getElementById("bottom-navbar-custom");
const links = bottomNavbarElem.querySelectorAll("a");
const activeIndex = parseInt(localStorage.getItem("activeIndex"));

for (let i = 0; i < links.length; i++) {
  if (i === activeIndex) {
    links[i].classList.add("active");
  }

  links[i].addEventListener("click", function() {
    const current = document.querySelector(".active");
    if (current) {
      current.classList.remove("active");
    }
    this.classList.add("active");
    localStorage.setItem("activeIndex", i.toString());
  });
}
