/**
 * FileName:getRstrCookie.js
 * @author
 */

/**********************************************************
* getRstrCookie
*/


function getRstrCookie() {
	var ckz = document.cookie;
	var foc = ckz.indexOf("0010resrAdd=");
	if (foc != -1){
		var soc = foc + 12;
		var eoc = ckz.indexOf(";",soc);
		if (eoc == -1) eoc = ckz.length;
		var voc = ckz.substring(soc,eoc);
		voc = decodeURIComponent(voc);
		if (voc == 'viewCm'){
			return false;
		}
	}else{
		location.href='top.html';
	}
}

getRstrCookie();

