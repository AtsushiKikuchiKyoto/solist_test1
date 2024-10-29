function comment(){

  const soundElements = document.querySelectorAll("[id^='sound_']");
  
  // 各サウンドアイテムにクリックイベントを追加
  soundElements.forEach(sound => {
    sound.addEventListener("click", () => {
      // サウンドのIDから番号を取得
      const soundId = sound.id.split("_")[1];
      // 対応するコメントのIDを作成
      const commentId = `comment_${soundId}`;
      const comment = document.getElementById(commentId);
      // コメントの表示・非表示を切り替え
      if (comment) {
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
//  window.addEventListener('turbo:render', avatar);