function comment(){
  const soundElements = document.querySelectorAll("[id^='sound_']");
  
  soundElements.forEach(sound => {
    sound.addEventListener("click", () => {
      const soundId = sound.id.split("_")[1];
      const commentId = `comment_${soundId}`;
      const comment = document.getElementById(commentId);
      if (comment) {
        console.log("C")
        if (comment.getAttribute("style") == "display:flex;") {
          comment.setAttribute("style", "display:none;")
        } else {
          comment.setAttribute("style", "display:flex;")
        }
      };
    });
  });


};
 window.addEventListener('turbo:load', comment);