const btnListener = () => {
    const sharecode = document.querySelector('.share-code');

    if (sharecode) {

          const copyToClipboard = () => {

            const el = document.createElement('textarea');
            el.value = document.getElementById('token').innerText;
            document.body.appendChild(el);
            el.select();
            document.execCommand('copy');
            document.body.removeChild(el);

            sharecode.classList.add('animated','rubberBand')
            setTimeout(function(){
              sharecode.classList.remove('animated','rubberBand')
            }, 1000);
          };

          document.querySelector('.main-button').addEventListener('click', e => {
            copyToClipboard();
          });

      };
  };

export { btnListener };
