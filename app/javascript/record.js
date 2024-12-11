let mediaRecorder;
let localStream;
const chunks = [];
let audioUrl;
const background = document.querySelector(".play");

function uploadToForm(blob) {
  const fileField = document.querySelector('.sound-form-file');
  const file = new File([blob], 'recording.webm', { type: 'audio/webm' });
  const dataTransfer = new DataTransfer();
  dataTransfer.items.add(file);
  fileField.files = dataTransfer.files;
}

function createController(audioUrl){
  const audioElement = document.createElement('audio');
  audioElement.id = 'record-audio';
  audioElement.controls = true;
  document.getElementById('record-audio-space').appendChild(audioElement);
  document.getElementById("record-audio").src = audioUrl
}

function JStest(){
  let jsTest = document.querySelector(".record-confirm");
  jsTest.style.display = "block";
}

function micPermit(){
  navigator.mediaDevices.getUserMedia({audio: true })
  .then(function (stream) {
  localStream = stream;
  mediaRecorder = new MediaRecorder(stream);
  });
};

function startRecordind(){
    mediaRecorder.start();
}

function stopRecording(){
  mediaRecorder.stop();
  mediaRecorder.ondataavailable = function (event) {
    // 録音データ生成
    chunks.push(event.data);
    const audioBlob = new Blob(chunks, { type: "audio/webm" });
    audioUrl = URL.createObjectURL(audioBlob);
    createController(audioUrl)
    uploadToForm(audioBlob);
  }
}

function changeInnerText(string){
  document.getElementById("record-inner-text").innerHTML = string;
}

function colorful(){
  background.classList.remove("grayscale");
  background.classList.add("colorful");
};

function grayscale(){
  background.classList.remove("colorful");
  background.classList.add("grayscale");
};

function countDown(countdownTime){
  changeInnerText(countdownTime);
  const countdownInterval = setInterval(() => {
    countdownTime -= 1;
    changeInnerText(countdownTime);
    if (countdownTime <= 0) {
      clearInterval(countdownInterval);
    }
  }, 1000);
};

function fillinForm(){
  const name = document.querySelector(".avatar-name").innerHTML;
  const today = new Date();
  const month = today.getMonth() + 1;
  const date = today.getDate();
  const text = `演奏：${name}  ${month}月${date}日`; 
  const textArea = document.getElementById("text");
  textArea.value = text;
};

// -------メイン関数-------
function main(){
  if (!document.querySelector(".sound-new")) return null;
  JStest();
  micPermit();
  
  let stage = "ready";
  let recordButton = document.getElementById("record-inner");

  recordButton.onclick = ()=>{

    if(stage == "ready"){
      stage = "recording"
      colorful();
      let countdownTime = 5; // カウントダウンの秒数
      countDown(countdownTime);
      setTimeout(()=>{
        changeInnerText("Rec");
        startRecordind();
      }, countdownTime * 1000 );

    } else if (stage == "recording"){
      stage = "finished"

      stopRecording();
      changeInnerText("完了");
      grayscale();
      fillinForm();

      URL.revokeObjectURL(audioUrl);
      localStream.getTracks().forEach(track => track.stop());

    } else if (stage == "finished"){
      stage = "ready";
      changeInnerText("録音開始");
    };
  };
};

document.addEventListener('turbo:load', main);