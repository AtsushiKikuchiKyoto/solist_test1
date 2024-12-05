const background = document.querySelector(".play");
const button = document.getElementById("play-button");
const audios = document.querySelectorAll("audio");
let currentIndex = 0;
let onAir = false;
let array = []

// 補助関数
function colorful(){
  background.classList.remove("grayscale");
  background.classList.add("colorful");
};
function grayscale(){
  background.classList.remove("colorful");
  background.classList.add("grayscale");
};
function getAudioIndex(audio){
  return audio.id.split("_")[1]
}
function resetArray(array){
  array.splice(0)
  Array.from(audios).map((a)=> array.push(a.id))
}
function stopByIndex(index){
  document.getElementById(`audio_${index}`).pause()
}
function playByIndex(index){
  document.getElementById(`audio_${index}`).play()
}
function pauseReset(array){
  array.forEach((ele,index) => {
    if(ele == "pause"){
      array.splice(index, 1, `audio_${index}`)
    };
  })
}
function stopOther(array){
  array.forEach((ele,index) => {
    ele === true && stopByIndex(index)
  })
}
function nextPlay(a){
  let nextIndex = Number(getAudioIndex(a))+1
  playByIndex(nextIndex)
}

// マイボタン関数
function myButton(array){
  console.log(`myButton:${array}`)
  if ( array.includes(true) ) {
    let index = array.indexOf(true)
    stopByIndex(index)
  } else if ( array.includes("pause") ) {
    let index = array.indexOf("pause")
    playByIndex(index)
  } else {
    playByIndex(0)
  }
};

// オートカラー関数
function autoColor(array){
  array.includes(true) ? colorful() : grayscale()
}

// ----------- メイン関数 ----------- 
function main(){
  if (!button) return null;

  resetArray(array)
  console.log(`start:${array}`)

  Array.from(audios).map((a)=> {
    // 再生開始時のアクション
    a.addEventListener("play",()=>{
      stopOther(array)
      array[getAudioIndex(a)] = true;
      autoColor(array)
      console.log(`play:${array}`)
    })
    // 再生停止時のアクション
    a.addEventListener("pause",()=>{
      pauseReset(array)
      array[getAudioIndex(a)] = "pause";
      autoColor(array)
      console.log(`pause:${array}`)
    })
    // 再生終了時のアクション
    a.addEventListener("ended",()=>{
      console.log(`ended:${array}`)
      nextPlay(a)
    })
  })
  // マイボタンクリック時
  button.addEventListener("click", ()=>{
    myButton(array)
  })
}

window.addEventListener('turbo:load', main());