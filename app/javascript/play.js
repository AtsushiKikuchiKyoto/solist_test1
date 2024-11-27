function autoplay(){
  const background = document.querySelector(".play");
  const button = document.getElementById("play-button");
  const audios = document.querySelectorAll("audio");
  let currentIndex = 0;
  let onAir = false;
  
  if (!button) return null;
  
  // 順次再生(終わったら次のaudioへ)
  function playAudio() {
    const audioElement = document.getElementById(`audio_${currentIndex}`);
    audioElement.play();
    audioElement.addEventListener("ended", ()=> {
      currentIndex++;
      playAudio(currentIndex);
    });
  };

  // ボタンのカラー
  audios.forEach((audio) => {
    // 何か再生中
    audio.addEventListener("play", () => {
      background.classList.remove("grayscale");
      background.classList.add("colorful");
      onAir = true;
      currentIndex = audio.id.split("_")[1]; //再生中のID取得
    });
    // すべて停止中
    audio.addEventListener("pause", () => {
      const allPaused = Array.from(audios).every((audio) => audio.paused);
      if (allPaused) {
        background.classList.remove("colorful");
        background.classList.add("grayscale");
        onAir = false;
      }
    });
  });

  // クリックで発動
  button.addEventListener("click", ()=>{
    if(onAir){
      const audios = document.querySelectorAll("audio");
      audios.forEach((audio) => {
        audio.pause();
      });
    } else {
      playAudio(currentIndex);
    };
  });

  // Audio二重起動の防止
  const ary = [];
  audios.forEach((audio) => {
    audio.addEventListener("play", () => {
      if(ary.length>0){
        console.log(ary[0]);
        document.getElementById(ary[0]).pause();
        ary.pop();
      }
      ary.push(audio.id);
    });
  });

};
window.addEventListener('turbo:load', autoplay);