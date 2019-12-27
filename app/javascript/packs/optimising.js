const optimisingAnimation = () => {

  const opt = document.querySelector('.optimising');

  if (opt) {

    let id = opt.getAttribute('data-id');

    animateTitle('title');

    setTimeout(function(){
      animateTitle('title1');
      document.getElementById('title').classList.add('d-none');
    }, 2500);

    setTimeout(function(){
      animateTitle('title2');
    }, 5000);

    setTimeout(function(){
      animateTitle('title3');
    }, 7500);

    setTimeout(function(){
        window.location.replace("/confirmation?event="+id);
    }, 10000);

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

  }, 2000);


}

export { optimisingAnimation };
