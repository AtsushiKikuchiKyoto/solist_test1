function toggleMenu (){
  const menuIcon = document.getElementById("menu-icon");
  const menu = document.getElementById("dropdownMenu");
  menuIcon.addEventListener("click",()=>{
    menu.style.display = menu.style.display === "block" ? "none" : "block";
  });
};
 window.addEventListener('turbo:load', toggleMenu);