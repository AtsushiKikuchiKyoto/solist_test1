function toggleMenu (){
  const menuIcon = document.getElementById("menu-icon");
  const menu = document.getElementById("dropdownMenu");

  // load,render二重起動の阻止
  if (!menuIcon.hasAttribute('data-listener-added')) {

    menuIcon.addEventListener("click",()=>{
      menu.style.display = menu.style.display === "block" ? "none" : "block";
    });

  // load,render二重起動の阻止
  menuIcon.setAttribute('data-listener-added', 'true');
  };

};
window.addEventListener('turbo:load', toggleMenu);
window.addEventListener('turbo:render', toggleMenu);