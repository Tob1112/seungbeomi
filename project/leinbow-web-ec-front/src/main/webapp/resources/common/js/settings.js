/**
 * FileName:settings.js
 * @author
 */

$(function(){
	uaRO('rollover');
	uaScroll();
	$('#retrieval input').setDefaultValue();
	$('#cart-A > ul > li > a').menuOpener(
		{
			speed:10,
			interval:10,
			handle:'mouseover',
			style:{'position':'absolute','right':0,'width':190 + 'px'},
			autoClose:true
		}
	);

	$('#sorter-A > dl > dd > a').menuOpener(
		{
			speed:10,
			interval:10,
			autoClose:true
		}
	);
	$('#categoryNavigation-A > ul > li > a').menuOpener(
		{
			speed:6,
			interval:10,
			closeBtn:'#categoryNavigation-A .close a'
		}
	);
	$('#archive').carousel(
		{
			prevBtn:'.prev > a',
			nextBtn:'.next > a',
			target:'.subBlock > ul',
			width:910,
			span:182,
			interval:10,
			speed:3
		}
	);
	$('#related').carousel(
		{
			prevBtn:'.prev > a',
			nextBtn:'.next > a',
			target:'.subBlock > ul',
			width:910,
			span:182,
			interval:10,
			speed:3
		}
	);
	$('#categoryNavigation-A .brands .subBlock-B > ul > li').reorderElements();
	$('.block-itemDetail-01 .div-B div.orders .request a,.block-search-01 p.submit').jsSubmit();

	if($('#detail-A').length){
		$('#detail-A').itemGallery();
		$('.block-itemDetail-01 .div-B p.movieBtn a').click(
			function(){
				var tar1 = $('.block-itemDetail-01 .div-B .subBlock');
				var tar2 = $('.block-itemDetail-01 .div-B .movie');
				tar1.hide();
				tar2.show();
				tar2.find('.close a').click(
					function(){
						tar1.show();
						tar2.hide();
					}
				);
			}
		);
	}
});