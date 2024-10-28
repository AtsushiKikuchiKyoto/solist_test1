function avatar (){
  
  const avatarIcon = document.getElementById("avatar-icon");
  const avatar = document.getElementById("dropdownAvatar");
  
  avatarIcon.addEventListener("click",()=>{

    if (avatar.getAttribute("style") == "display:block;") {
      avatar.setAttribute("style", "display:none;")
    } else {
      avatar.setAttribute("style", "display:block;")
    }

  });

};
 window.addEventListener('turbo:load', avatar);
//  window.addEventListener('turbo:render', avatar);