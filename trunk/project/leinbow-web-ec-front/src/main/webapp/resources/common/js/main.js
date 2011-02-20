function setStyle(ID){
	var url	= fn + ID + ".css";
	$('#jstyle').attr({href:url});
	$('a#btn-fontsize-' + ID).addClass("current");
	if ( ID == 'st' ){
		$('a#btn-fontsize-l').removeClass("current");
	} else if ( ID == 'l' ){
		$('a#btn-fontsize-st').removeClass("current");
	}
	$.cookie('cssstyle', ID, {expires:30, path:'/'});
}
