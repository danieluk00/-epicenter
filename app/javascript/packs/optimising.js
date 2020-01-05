const optimisingAnimation = () => {

  const opt = document.querySelector('.optimising');

  if (opt) {

    let id = opt.getAttribute('data-id');

    animateTitle('title');

    setTimeout(function(){
      animateTitle('title1');
      document.getElementById('title').classList.add('d-none');
    }, 2000);

    setTimeout(function(){
      animateTitle('title2');
    }, 4000);

    setTimeout(function(){
      animateTitle('title3');
    }, 6000);

    setTimeout(function(){
        window.location.replace("/confirmation?event="+id);
    }, 9000);

    document.getElementById('skip').addEventListener('click', e => {
      console.log('abc')
      window.location.replace("/confirmation?event="+id);
    })
  

  }
}

const animateTitle = (element) => {

  const elementName = document.getElementById(element);

  if (elementName.classList.contains('d-none')) {
    elementName.classList.remove('d-none');
  }

  elementName.classList.add('animated','fadeIn');
  setTimeout(function(){
    elementName.classList.remove('animated','fadeIn');
    elementName.classList.add('animated','fadeIn');

    setTimeout(function(){
        elementName.classList.add('d-none');
    }, 500);

  }, 1500);


}

export { optimisingAnimation };
