const optimisingAnimation = () => {

  const opt = document.querySelector('.optimising');

  let id = opt.getAttribute('data-id');

  if (opt) {

    animateTitle('title');

    setTimeout(function(){
      animateTitle('title1');
      document.getElementById('title').classList.add('d-none');
    }, 3000);

    setTimeout(function(){
      animateTitle('title2');
    }, 6000);

    setTimeout(function(){
      animateTitle('title3');
    }, 9000);

    setTimeout(function(){
        window.location.replace("/confirmation?event="+id);
    }, 9000);

  }
}

const animateTitle = (element) => {

  const elementName = document.getElementById(element);

  if (elementName.classList.contains('d-none')) {
    elementName.classList.remove('d-none');
  }

  elementName.classList.add('animated','bounceInDown');
  setTimeout(function(){
    elementName.classList.remove('animated','bounceInDown');
    elementName.classList.add('animated','bounceOutDown');

    setTimeout(function(){
        elementName.classList.add('d-none');
    }, 500);

  }, 2500);


}

export { optimisingAnimation };
