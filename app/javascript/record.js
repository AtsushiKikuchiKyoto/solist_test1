function uploadToRailsForm(blob) {
  const fileField = document.querySelector('.sound-form-file');

  // BlobをFileオブジェクトとして扱う
  const file = new File([blob], 'recording.webm', { type: 'audio/webm' });

  // DataTransfer APIでファイルを挿入
  const dataTransfer = new DataTransfer();
  dataTransfer.items.add(file);
  fileField.files = dataTransfer.files;

  console.log("Blob has been added to the form");
}

function record(){
  if (!document.querySelector(".sound-new")) return null;

    let startButton = document.getElementById("record-start");
    let stopButton = document.getElementById("record-stop");
    let mediaRecorder;
    let localStream;
    const chunks = [];
    let audioUrl;

  startButton.onclick = function () {
    navigator.mediaDevices.getUserMedia({audio: true })
    .then(function (stream) {
      localStream = stream;
      mediaRecorder = new MediaRecorder(stream);
      mediaRecorder.start();

    }).catch(function (err) {
      console.log(err);
    });
  }

  stopButton.onclick = function () {
    mediaRecorder.stop();
    mediaRecorder.ondataavailable = function (event) {

      // 録音データ生成
      chunks.push(event.data);
      const audioBlob = new Blob(chunks, { type: "audio/webm" });
      uploadToRailsForm(audioBlob);
      audioUrl = URL.createObjectURL(audioBlob);
      
      // html audioタグで再生
      document.getElementById("record-audio").src = audioUrl

    }
    URL.revokeObjectURL(audioUrl);
    localStream.getTracks().forEach(track => track.stop());
  }
}

document.addEventListener('turbo:load', record);
document.addEventListener('turbo:render', record);