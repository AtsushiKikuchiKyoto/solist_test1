function autoplay(){
  const background = document.querySelector(".play");
  const button = document.getElementById("play-button");
  let currentIndex = 0;
  const audioPrefix = "audio_";

  if (!button) return null;

  function playAudio() {
    const audioElement = document.getElementById(`${audioPrefix}${currentIndex}`);
    audioElement.play();
    audioElement.addEventListener("ended", ()=> {
      currentIndex++;
      playAudio(currentIndex);
    });
  };

  button.addEventListener("click",()=>{
    const audios = document.querySelectorAll("audio");
    let isPlaying = true;

    audios.forEach((audio) => {
      if (!audio.paused) { 
        audio.pause(); 
        isPlaying = false;
        background.classList.remove("colorful");
        background.classList.add("grayscale");
      }
    });
    if(isPlaying){
      playAudio(currentIndex);
      background.classList.remove("grayscale");
      background.classList.add("colorful");
    };
  });

};
window.addEventListener('turbo:load', autoplay);