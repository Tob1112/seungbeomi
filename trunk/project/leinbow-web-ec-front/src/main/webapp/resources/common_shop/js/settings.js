/**
 * FileName:settings.js
 * @author
 */

$(function(){
	uaRO('rollover');
	uaScroll();
	$('#retrieval input').setDefaultValue();

	$('#categoryNavigation-A >ul').menuFix(
		{
			width:830
		}
	);

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
	$('#categoryNavigation-A > ul > li:not(.set-Link) > a').menuOpener(
		{
			speed:4,
			interval:10,
			handle:'mouseover',
			autoClose:true
		}
	);

	$('#newslist').carousel(
		{
			prevBtn:'.new > a',
			nextBtn:'.old > a',
			target:'.subBlock > ul',
			width:852,
			span:213,
			interval:10,
			speed:3
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
				$('.block-itemDetail-01 .div-B .subBlock').hide();
				$('.block-itemDetail-01 .div-B .movie').css({'width':'320px','height':'400px'});
				callPlayFromHead();
			}
		);
	}

	$('.e-SHOP > a').ready(function(){
		$('.e-SHOP > a').attr('href',"/store/store.html");
	});
	$('.e-SHOP > a').click(function(){
		location.href=$('.e-SHOP > a').attr('href');
	});

	
	$('.block-itemDetail-01 > .div-B > .subBlock .addthis_default_style').appendSNSButtons();
	
});
function closeMovie(){
		$('.block-itemDetail-01 .div-B .subBlock').show();
		$('.block-itemDetail-01 .div-B .movie').css({'width':'1px','height':'1px'});
}
function setIesixMsg(){
	var bsr = navigator.userAgent;
	var msginner = document.createElement('DIV');
	var hdr = document.getElementById('header');
	if(bsr.indexOf("MSIE 6") != -1 || bsr.indexOf("MSIE 5") != -1){
	hdr.insertBefore(msginner , hdr.firstChild);
	hdr.firstChild.id = 'set-Ie6Msg';
	hdr.firstChild.innerHTML = '<p style="padding-bottom:39px;"><a href="http://www.microsoft.com/japan/windows/internet-explorer/" target="_blank"><img src="/g_images/txt-ie6-01.gif" alt="CART" width="960" height="90" class="rollover" /></a></p>';
	}
}

function callPlayFromHead(){
	var obj = document.getElementById('external_restir_prodMovie');
	obj.playFromHead();
}

function winopen(uri, name, prop){
	var extra = new Array();
	if(prop){
		(prop.left)?extra[extra.length] = "left="+prop.left:"";
		(prop.top)?extra[extra.length] = "top="+prop.top:"";
		(prop.height)?extra[extra.length] = "height="+prop.height:"";
		(prop.width)?extra[extra.length] = "width="+prop.width:"";

		extra[extra.length] = (prop.channelmode)?"channelmode="+prop.channelmode:"channelmode=no";
		extra[extra.length] = (prop.directories)?"directories="+prop.directories:"directories=no";
		extra[extra.length] = (prop.fullscreen)?"fullscreen="+prop.fullscreen:"fullscreen=no";
		extra[extra.length] = (prop.location)?"location="+prop.location:"location=no";
		extra[extra.length] = (prop.menubar)?"menubar="+prop.menubar:"menubar=no";
		extra[extra.length] = (prop.resizable)?"resizable="+prop.resizable:"resizable=yes";
		extra[extra.length] = (prop.scrollbars)?"scrollbars="+prop.scrollbars:"scrollbars=yes";
		extra[extra.length] = (prop.status)?"status="+prop.status:"status=no";
		extra[extra.length] = (prop.titlebar)?"titlebar="+prop.titlebar:"titlebar=no";
		extra[extra.length] = (prop.toolbar)?"toolbar="+prop.toolbar:"toolbar=no";
	}
	extra = extra.join(",");

	var newwin=window.open(uri,name,extra);
	newwin.focus();
}

function getUrlVars()
{
	var vars = [], hash;
	var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
	for(var i = 0; i <hashes.length; i++)
	{
		hash = hashes[i].split('=');
		vars.push(hash[0]);
		vars[hash[0]] = hash[1];
	}
	return vars;
}

function getHrefVars(link)
{
	var vars = [], hash;
	var hashes = link.attr("href").slice(link.attr("href").indexOf('?') + 1).split('&');
	for(var i = 0; i <hashes.length; i++)
	{
		hash = hashes[i].split('=');
		vars.push(hash[0]);
		vars[hash[0]] = hash[1];
	}
	return vars;
}
