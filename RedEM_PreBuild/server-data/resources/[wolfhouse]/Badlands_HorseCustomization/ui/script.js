$(document).ready(function(){


  // Listen for NUI Events
  window.addEventListener('message', function(event){
    // Open Skin Creator
    if(event.data.openSkinCreator == true){
      $(".skinCreator").css("display","block");
      $(".rotation").css("display","flex");;
	  Load()
    }
    // Close Skin Creator
    if(event.data.openSkinCreator == false){
      $(".skinCreator").fadeOut(400);
      $(".rotation").fadeOut(400);
    }
	
	function Load(){
document.getElementById("czaprak").value = event.data.czaprak;
document.getElementById("bag").value = event.data.torba;
document.getElementById("tail").value = event.data.ogon;
document.getElementById("mane").value = event.data.grzywa;
document.getElementById("saddle").value = event.data.siodlo;
document.getElementById("stirrups").value = event.data.buty;
document.getElementById("mat").value = event.data.mata;

}
  });
  

  // Form update
  $('input').change(function(){	  
    $.post('http://WH_Redemrp_HorseCustomization/updateComponents', JSON.stringify({
      value: false,
// Body    
      czaprak: $('.czaprak').val(),
	  bag: $('.bag').val(),
	  tail: $('.tail').val(),
	  mane: $('.mane').val(),
	  saddle: $('.saddle').val(),
	  stirrups: $('.stirrups').val(),
	  mat: $('.mat').val(),

    }));
  });
  
  
  $('.arrow').on('click', function(e){
    e.preventDefault();
    $.post('http://WH_Redemrp_HorseCustomization/updateComponents', JSON.stringify({
      value: false,
// Body
      czaprak: $('.czaprak').val(),
	  bag: $('.bag').val(),
	  tail: $('.tail').val(),
	  mane: $('.mane').val(),
	  saddle: $('.saddle').val(),
	  stirrups: $('.stirrups').val(),
	  mat: $('.mat').val()
    }));
  });

  // Form submited
  $('.yes').on('click', function(e){
    e.preventDefault();
    $.post('http://WH_Redemrp_HorseCustomization/saveComponents', JSON.stringify({
      czaprak: $('.czaprak').val(),
	  bag: $('.bag').val(),
	  tail: $('.tail').val(),
	  mane: $('.mane').val(),
	  saddle: $('.saddle').val(),
	  stirrups: $('.stirrups').val(),
	  mat: $('.mat').val()
    }));
  }); 
  
    $('.exit').on('click', function(e){
    e.preventDefault();
    $.post('http://WH_Redemrp_HorseCustomization/exit');
  }); 
  
  // Rotate player
  $(document).keypress(function(e) {
    if(e.which == 113){ // Q pressed
      $.post('http://WH_Redemrp_HorseCustomization/heading', JSON.stringify({
        value: -10
      }));
    }
  if(e.which == 100){ // D pressed
      $.post('http://WH_Redemrp_HorseCustomization/defcam');
    }
    if(e.which == 101){ // E pressed
      $.post('http://WH_Redemrp_HorseCustomization/heading', JSON.stringify({
        value: 10
      }));
    }
  });



});
