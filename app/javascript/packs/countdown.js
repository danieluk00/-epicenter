var deadline = 'December 11 2019 23:59:59 GMT+0200';

function getTimeRemaining(endtime){
  var t = Date.parse(endtime) - Date.parse(new Date());
  var seconds = Math.floor( (t/1000) % 60 );
  var minutes = Math.floor( (t/1000/60) % 60 );
  var hours = Math.floor( (t/(1000*60*60)) % 24 );
  var days = Math.floor( t/(1000*60*60*24) );
  return {
    'total': t,
    'days': days,
    'hours': hours,
    'minutes': minutes,
    'seconds': seconds
  };
}

let clock = document.getElementById('clockdiv');


function initializeClock(endtime){



  var timeinterval = setInterval(function(){
    var t = getTimeRemaining(endtime);

    if (t >= 0) {
      if (t.days>0) {
        clock.innerHTML = `<span class="clock"><span class="hour">${t.days}</span>d <span class="hour">${t.hours}</span>h <span class="hour">${t.minutes}</span>m</span>`;
      } else {
        clock.innerHTML = `<span class="clock"><span class="hour">${t.hours}</span>h <span class="hour">${t.minutes}</span>m <span class="hour">${t.seconds}</span>s</span>`;
      }
    } else {
        // window.location.href = `/confirmation`
    }

    if(t.total<=0){
      clearInterval(timeinterval);
    }
  },1000);
}

initializeClock(deadline);
