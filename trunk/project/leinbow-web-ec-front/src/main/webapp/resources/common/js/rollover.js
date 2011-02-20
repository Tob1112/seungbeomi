/**
 * FileName:rollover.js
 * @author
 */

/**********************************************************
* rollover
*/

function UaRollover(){
}
UaRollover.prototype = {
	initialize:function(clses){
		var len = clses.length;
		this.storedImg = new Array();
		var elems = new Array();
	
		for(var k=0; k<len; k++){
			elems = elems.concat(this.getElementsByClassName("img", clses[k]));
			elems = elems.concat(this.getElementsByClassName("input", clses[k]));
		}

		len = elems.length;
		for(var i=0; i<len; i++){

			var elem = elems[i];
			var imgSrc = elem.src;

			if(imgSrc.indexOf("_cur.")>-1){
				continue;
			}
			var ovrStr = this.imgOvrReplace(imgSrc, true)
			this.storedImg[imgSrc] = new Image();
			this.storedImg[imgSrc].src = ovrStr;

			elem.ins = this;
			elem.onmouseover = this.mouseOverEvent;
			elem.onmouseout = this.mouseOutEvent;

		}
	},
	getElementsByClassName:function(pTagName, pClassName){
		var res = new Array();
		var tags = document.getElementsByTagName(pTagName);
		var len = tags.length;
		for(var i=0; i<len; i++){
			var classes = tags[i].className;
			if(classes.indexOf(pClassName)>-1){
				res[res.length] = tags[i];
			}
		}
		return res;
	},
	mouseOverEvent:function (){
		this.src = this.ins.imgOvrReplace(this.src, true);
	},
	mouseOutEvent:function(){
		this.src = this.ins.imgOvrReplace(this.src, false);
	},
	imgOvrReplace:function(pSrc, pIsOvr){
		var srcStr = pSrc;
		if(pIsOvr){
			if(srcStr.indexOf("-ovr")>-1){
				return srcStr;
			}
			srcStr = this.strReplace(srcStr, ".gif", "-ovr.gif");
			srcStr = this.strReplace(srcStr, ".jpg", "-ovr.jpg");
			srcStr = this.strReplace(srcStr, ".png", "-ovr.png");
		}else{
			srcStr = this.strReplace(srcStr, "-ovr.gif", ".gif");
			srcStr = this.strReplace(srcStr, "-ovr.jpg", ".jpg");
			srcStr = this.strReplace(srcStr, "-ovr.png", ".png");
		}
		return srcStr;
	},
	strReplace:function (pStr, pKey, pAlt){
		return pStr.split(pKey).join(pAlt);
	}
}

var uaRollover = new UaRollover();


function uaRO(){
	uaRollover.initialize(arguments);
}
