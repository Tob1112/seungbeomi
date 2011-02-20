var currentImageLink = Math.floor( Math.random() * 4 );
var slideshows;
var slideshow;
var previousImage;
var ImageSwitchSeconds = 2;
var slideTimer;
var runTimer = true;


$(document).ready(function(){ 
  slideshows = $('#slide_links .link');
	slideshows.click(function(){
    	currentImageLink = $(this).attr("rel");
		runTimer = false;
		clearTimeout(slideTimer);
  		slideSwitch();

	});
	if (runTimer) {
  		setTimeout("slideSwitch()");
	}
});

function slideSwitch() {
  slideshow = slideshows[currentImageLink];
  previousImage = slideshows[currentImageLink-1];


  //remove selected class (borders) from all links, then add to current selection
  $('#slide_links .link').removeClass("selected");
  $(slideshow).addClass("selected");
  
  //but if current selection is the 4th slide, kill the bottom border (which is a background img)
  if(slideshow == slideshows[3])
  	$(slideshow).css("background", "none");
  
  //prev_selected adds a bottom border to element before current one (simulating top border)
  slideshows.removeClass("prev_selected");
  $(previousImage).addClass("prev_selected");

  l_nIndex = currentImageLink;
  l_sHtml = $('#slide_copy_hidden_'+ l_nIndex).html();
  l_sImageHtml = $('#slide_image_hidden_'+ l_nIndex).html();

  //set explicit height/width on slide_wrapper so it holds it's ground when hidden below
  l_nslideHeight = $('#slide_wrapper').height();
  $('#slide_wrapper').height(l_nslideHeight);
  
  //hide slide wrapper, change the content, then fade it back in

  $('#slide_copy_holder, #slide_image_holder').hide();
  $('#slide_copy_holder').html(l_sHtml);
  $('#slide_image_holder').html(l_sImageHtml);
  $('#slide_copy_holder, #slide_image_holder').fadeIn();
  
  
  if (++currentImageLink > 3) {
    currentImageLink = 0;
  }

	if (runTimer) {
  		clearTimeout(slideTimer);
  		slideTimer = setTimeout("slideSwitch(true)", ImageSwitchSeconds * 2000);
	}
}
