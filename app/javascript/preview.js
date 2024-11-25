document.addEventListener('turbo:load', function(){
  if (!document.getElementById('preview')) return null;

  const fileField = document.querySelector('input[type="file"]');
  fileField.addEventListener('change', (e)=>{
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    const target = document.getElementById("preview");
    target.src = blob;
  });
});