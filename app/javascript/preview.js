function preview(){
  if (!document.getElementById('preview')) return null;

  const fileField = document.querySelector('input[type="file"]');
  fileField.addEventListener('change', (e)=>{
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    const image = document.getElementById("preview");
    image.src = blob;
  });
};
document.addEventListener('turbo:load', preview);
document.addEventListener('turbo:render', preview);