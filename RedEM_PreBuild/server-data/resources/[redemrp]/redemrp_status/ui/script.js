
$(document).ready(function () {
  var thrist = 0;
  var hunger = 0;
  var temp = 0;
  var show = false;
  window.addEventListener("message", function (event) {
    if (event.data.showhud == undefined) {
      thrist = event.data.thrist;
      hunger = event.data.hunger;
      temp = event.data.temp;
    }
    if (event.data.showhud == true || event.data.showhud == false) {
      show = event.data.showhud;
    }
    if (show == true) {
      $('#huds').fadeIn();
      setProgressThrist(thrist, '.progress-thrist');
      setProgressHunger(hunger, '.progress-hunger');
      setProgressTemp(temp, '.progress-temp');
    }
    if (show == false) {
      setTimeout(function () {
        $('#huds').fadeOut();
      }, 2000);
    }
  });

  // Functions
  function setProgressThrist(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var x = document.getElementById("test1");
    if (percent > 20) {
      x.style.stroke = "#fff";
    }
    if (percent <= 20) {
      x.style.stroke = "#ffaf02";
    }
    if (percent <= 10) {
      x.style.stroke = " #FF0245";
    }

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent * 100) / 100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }

  function setProgressHunger(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var x2 = document.getElementById("test2");
    if (percent > 20) {
      x2.style.stroke = "#fff";
    }
    if (percent <= 20) {
      x2.style.stroke = "#ffaf02";
    }
    if (percent <= 10) {
      x2.style.stroke = " #FF0245";
    }

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent * 100) / 100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }

  function setProgressTemp(percent, element) {
    var circle = document.querySelector(element);
    var iner = document.getElementById('iner');
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var x3 = document.getElementById("test3");
    if (percent > 30) {
      x3.style.stroke = "#cf0000";
      iner.innerHTML = parseInt(percent);
    }
    if (percent <= 30) {
      x3.style.stroke = "#eb3b00";
      iner.innerHTML = parseInt(percent);
    }
    if (percent <= 25) {
      x3.style.stroke = "#ffc800";
      iner.innerHTML = parseInt(percent);
    }
    if (percent <= 20) {
      x3.style.stroke = "#fff";
      iner.innerHTML = parseInt(percent);
    }
    if (percent <= 10) {
      x3.style.stroke = "#0084ff";
      iner.innerHTML = parseInt(percent);
    }
    if (percent <= 0) {
      x3.style.stroke = "#0011ff";
      iner.innerHTML = parseInt(percent);
    }

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - (((-percent * 100) / 100) / 100 * circumference) * 2.5;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }

});
