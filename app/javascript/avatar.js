function avatar (){
  
  const avatarIcon = document.getElementById("avatar-icon");
  const avatar = document.getElementById("dropdownAvatar");
  
  // load,render二重起動の阻止
  if (!avatarIcon.hasAttribute('data-listener-added')) {

    avatarIcon.addEventListener("click",()=>{
      avatar.style.display = avatar.style.display === "block" ? "none" : "block";
    });

  // load,render二重起動の阻止
  avatarIcon.setAttribute('data-listener-added', 'true');
  };

};
 window.addEventListener('turbo:load', avatar);
 window.addEventListener('turbo:render', avatar);