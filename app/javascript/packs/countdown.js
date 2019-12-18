
const joinWrapper = document.querySelector('.join-wrapper')

if (joinWrapper) {


  let id = joinWrapper.getAttribute('data-id');
  let notWorkingDate = new Date(joinWrapper.getAttribute('data-time')).getTime();
  const time_left = joinWrapper.getAttribute('data-deadline');

// *****************
let dateArray = joinWrapper.getAttribute('data-time').split(' ');
let dateRebuild = `${dateArray[0]}T${dateArray[1]}`;
let dateIos = Date.parse(dateRebuild);

// *****************

dt = notWorkingDate ? notWorkingDate : dateIos;
  dt = dt + time_in_ms(time_left);

  //const deadline = eventData.dataset.deadline;
  const deadline = new Date(dt)
  //const tokenEvent = eventData.dataset.token;

  function getTimeRemaining(endtime){
    var t = Date.parse(endtime) - Date.parse(new Date());
    var seconds = Math.floor( (t/1000) % 60 );
    var minutes = Math.floor( (t/1000/60) % 60 );
    var hours = Math.floor( (t/(1000*60*60)) % 24 );
    var days = Math.floor( t/(1000*60*60*24) );

    if (t>0) {
      return {
        'total': t,
        'days': days,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds
      };
    } else {
        return {
          'total': 0,
          'days': 0,
          'hours': 0,
          'minutes': 0,
          'seconds': 0
      }
    }
  }

  let clock = document.getElementById('clockdiv');

  function initializeClock(endtime){
    var timeinterval = setInterval(function(){
      var t = getTimeRemaining(endtime);

        if (t.total==0) {
          console.log('redirect')
          window.location.replace("/optimising?event="+id);
        } else if (t.days>0) {
          clock.innerHTML = `<span class="clock"><span class="hour">${t.days}</span>d <span class="hour">${t.hours}</span>h <span class="hour">${t.minutes}</span>m</span>`;
        } else {
          clock.innerHTML = `<span class="clock"><span class="hour">${t.hours}</span>h <span class="hour">${t.minutes}</span>m <span class="hour">${t.seconds}</span>s</span>`;
        }

        // clock.classList.add('animated','pulse')
        //   setTimeout(function(){
        //     clock.classList.remove('animated','pulse')
        //   }, 900);

        if(t.total<=0){
          clearInterval(timeinterval);
        }
    },1000);
  }

  function time_in_ms(time_left) {
    if( time_left ==='3 minutes' ) {
      return 3*60*1000;
    } else if (time_left === '1 hour') {
      return 1*60*60*1000;
    } else if (time_left === '4 hours') {
      return 4*60*60*1000;
    } else if (time_left === '12 hours') {
      return 12*60*60*1000;
    } else if (time_left === '1 day') {
      return 24*60*60*1000;
    } else if (time_left === '3 days') {
      return 3*24*60*60*1000;
    } else if (time_left === '5 days') {
      return 5*24*60*60*1000;
    } else {
      return 0;
    }
  }


  initializeClock(deadline);
}
