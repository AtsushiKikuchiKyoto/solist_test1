function autoplay(){
  const background = document.querySelector(".play");
  const button = document.getElementById("play-button");
  const audios = document.querySelectorAll("audio");
  let currentIndex = 0;
  let onAir = false;
  
  if (!button) return null;
  
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
  
  // 順次再生機能
  function playAudio() {
    const audioElement = document.getElementById(`audio_${currentIndex}`);
    // audioElement.play();
    let next = currentIndex
    audioElement.addEventListener("ended", ()=> {
      next++;
      console.log(next);
      document.getElementById(`audio_${next}`).play();
      },
      { once: true } //重複阻止
    );
  };
  
  // クリックで発動
  let flag = true;
  button.addEventListener("click", ()=>{
    if(onAir){
      const audios = document.querySelectorAll("audio");
      audios.forEach((audio) => {
        audio.pause();
        flag = true;
      });
    } else if(flag) {
      document.getElementById(`audio_${currentIndex}`).play();
      playAudio(currentIndex);
      flag = false;
    };
  });

  // クリックなしで順次再生
  audios.forEach((audio) => {
    audio.addEventListener("play", () => {
      playAudio(currentIndex);
    },
    { once: true }
    );
  });

  // Audio二重起動の防止
  const ary = [];
  audios.forEach((audio) => {
    audio.addEventListener("play", () => {
      ary.push(audio.id);
      for (let i = 0; i < ary.length-1; i++){
        document.getElementById(ary[i]).pause();
      };
    });
    audio.addEventListener("pause", () => {
      ary.shift();
    });
  });

};
window.addEventListener('turbo:load', autoplay);