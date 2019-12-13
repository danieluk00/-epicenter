
const btnListener = () => {

  const copyToClipboard = () => {

    const el = document.createElement('textarea');
    el.value = document.getElementById('token').innerText;
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
  };

  document.querySelector('.main-button').addEventListener('click', e => {
    copyToClipboard();
  });

};

export { btnListener };
