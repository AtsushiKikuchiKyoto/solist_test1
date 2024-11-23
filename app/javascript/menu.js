function toggleMenu (){

  function open(button, target){
    if (!button.hasAttribute('no-dubble')) { //二重起動対策
      button.addEventListener("click",()=>{
        target.style.display = target.style.display === "block" ? "none" : "block";
      });
      button.setAttribute('no-dubble', 'true'); //二重起動対策
    };
    document.addEventListener('click', (e) => { //閉じる
      if (!button.contains(e.target)) {
        target.style.display = "none";
      };
    });
  };
  // 右上メニューアイコン開閉
  const menuIcon = document.getElementById("menu-icon");
  const menu = document.getElementById("dropdownMenu");
  open(menuIcon,menu);
  // 左上アバターアイコン開閉
  const avatarIcon = document.getElementById("avatar-icon");
  const avatar = document.getElementById("dropdownAvatar");
  open(avatarIcon,avatar);
};
document.addEventListener('turbo:load', toggleMenu);
document.addEventListener('turbo:render', toggleMenu);