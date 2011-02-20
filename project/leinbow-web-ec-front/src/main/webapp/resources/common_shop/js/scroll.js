/**
 * FileName:scroll.js
 * @author
 */

/**********************************************************
* pagescroll
*/


function ScrollClass() {
}
ScrollClass.prototype ={

	offset:new Object(),
	speed:12,
	timer:0,
	objCover:"",
	objBody:"",
	direction:new Object(),
	isCompatMode:document.compatMode == "CSS1Compat",
	major:parseInt(navigator.appVersion),
	minor:parseFloat(navigator.appVersion),
	isIE:navigator.userAgent.indexOf("MSIE") != -1,
	isOpera:window.opera,
	isMozilla:navigator.userAgent.indexOf("Gecko") != -1,
	isNN :navigator.userAgent.indexOf("Netscape") != -1,
	isMac:navigator.userAgent.indexOf("Mac") != -1,
	isSafari:navigator.userAgent.indexOf("Safari") != -1,

	setScrollSpeed:function(num){
		if(typeof num == "number") {
			this.speed = num;
		}
	},
	getScrollSpeed:function(){
		return this.speed;
	},
	getMaxScroll:function(){
		var pos = new Object();
		var sc  = new Object();
		if(this.isNN || this.isSafari || this.isOpera || (this.isMac && this.isMozilla)) {
			pos.x = this.major <= 5 ? document.documentElement.offsetWidth - window.innerWidth + 16 : document.documentElement.offsetWidth - window.innerWidth + 17;
			pos.y = this.major <= 5 ? document.documentElement.offsetHeight - window.innerHeight + 16 : document.documentElement.offsetHeight - window.innerHeight + 17;
		} else {
			if(this.isMac) {
				pos.x = document.body.offsetWidth- document.body.clientWidth + 1;
				pos.y = document.body.offsetHeight - document.body.clientHeight + 1;
			} else {
				pos.x = this.isCompatMode ? document.documentElement.scrollWidth - document.documentElement.clientWidth : document.body.scrollWidth - document.body.clientWidth;
				pos.y = this.isCompatMode ? document.documentElement.scrollHeight - document.documentElement.clientHeight : document.body.scrollHeight - document.body.clientHeight;
			}
		}
		if(pos.x < 0) { sc.x = 0; }
		if(pos.y < 0) { sc.y = 0; }
		return {x:pos.x, y:pos.y };
	},
	getScrollLeft:function(){
		if(this.isIE) {
			return this.isCompatMode ? document.documentElement.scrollLeft : document.body.scrollLeft;
		} else {
			return window.pageXOffset ? window.pageXOffset : 0;
		}
	},
	getScrollTop:function(){
		if(this.isIE) {
			return this.isCompatMode ? document.documentElement.scrollTop : document.body.scrollTop;
		} else {
			return window.pageYOffset ? window.pageYOffset : 0;
		}
	},
	scrollTo:function(){
		clearTimeout(this.timer);
		this.offset.x = null;
		this.offset.y = null;
		var toX = this.parse("x", this.findAnchor(arguments[0]) ? this.getAnchorPos(arguments[0]).x : arguments[0]);
		var toY = this.parse("y", this.findAnchor(arguments[1]) ? this.getAnchorPos(arguments[1]).y : arguments[1]);
		this.direction.is_x = toX - this.getScrollLeft() >= 0 ? true : false;
		this.direction.is_y = toY - this.getScrollTop() >= 0 ? true : false;
		this.pageScroll(toX, toY);
	},
	findAnchor:function(id){
		return (document.getElementById(id) || document.anchors[id]);
	},
	getAnchorPos:function(id){
		if(document.getElementById(id)) {
			var element = document.getElementById(id);
			var obj = new Object();
			do {
				obj.x = (!obj.x) ? element.offsetLeft : obj.x + element.offsetLeft;
				obj.y = (!obj.y) ? element.offsetTop : obj.y + element.offsetTop;
			} while((element = element.offsetParent) != null);
			return {x:obj.x < 0 ? 0 : obj.x, y:obj.y };
		} else if(document.layers) {
			var element = document.anchors[id];
			return {x:element.x, y:element.y };
		} else {
			return {x:0, y:0};
		}
	},
	parse:function(direction, value){
		var maxScroll = this.getMaxScroll();
		var range = {min_x:0, max_x:maxScroll.x, min_y:0, max_y:maxScroll.y };
		switch(direction) {
			case "x":
				if(typeof value == "boolean") {
					return value ? 0 : this.getScrollLeft();
				} else if(typeof value == "number") {
					if(!this.isOpera) {
						if(value < 0) {
							return 0;
						} else if(value > range.max_x) {
							return range.max_x;
						}
					}
					return value;
				} else if(typeof value == "string") {
					switch(value) {
						case "left": return 0;
						case "center": return Math.floor(range.max_x / 2);
						case "right": return range.max_x;
						default: this.getScrollLeft();
					}
				}
				return this.getScrollLeft();
				break;
			case "y":
				if(typeof value == "boolean") {
					return value ? 0 : this.getScrollTop();
				} else if(typeof value == "number") {
					if(value < 0) {
						return 0;
					} else if(value > range.max_y) {
						return range.max_y;
					}
					return value;
				} else if(typeof value == "string") {
					switch(value) {
						case "top": return 0;
						case "middle": return Math.floor(range.max_y / 2);
						case "bottom": return range.max_y;
						default: this.getScrollTop();
					}
				}
				return this.getScrollTop();
				break;
		}
	},
	pageScroll:function(toX, toY){
		clearTimeout(this.timer);
		var dX = this.direction.is_x;
		var dY = this.direction.is_y;
		var scX = this.getScrollLeft();
		var scY = this.getScrollTop();
		var cuX = dX ? Math.ceil((toX - scX) / this.speed) : Math.floor((toX - scX) / this.speed);
		var cuY = dY ? Math.ceil((toY - scY) / this.speed) : Math.floor((toY - scY) / this.speed);
		if(((dX && scX + cuX < toX -1) || (!dX && scX + cuX > toX + 1)) || ((dY && scY + cuY < toY - 1) || (!dY && scY + cuY > toY +1))) {
			if(this.offset.x != null && this.offset.y != null) {
				if(this.offset.x == scX && this.offset.y == scY) {
					scroll.allCover('off');
					return;
				} else if((dX && this.offset.x > scX) || (!dX && this.offset.x < scX)) {
					scroll.allCover('off');
					return;
				} else if((dY && this.offset.y > scY) || (!dY && this.offset.y < scY)) {
					scroll.allCover('off');
					return;
				}
			}
			window.scrollTo(scX + cuX, scY + cuY);
			this.timer = setTimeout("ScrollClass.prototype.pageScroll("+toX+","+toY+")",this.speed);
			this.offset.x = scX;
			this.offset.y = scY;
		} else {
			scroll.allCover('off');
			clearTimeout(this.timer);
			window.scrollTo(toX, toY);
			return false;
		}
	},
	allCover:function(display){
		if(display == 'on') {
			this.objCover = document.createElement("div");
			this.objBody.appendChild(this.objCover);
			this.objCover.style.width =  100 + '%';
			this.objCover.style.height = this.setCover() + 'px';
			this.objCover.style.position = 'absolute';
			this.objCover.style.zIndex = 999;
			this.objCover.style.top = 0;
			this.objCover.style.left = 0;
			return true;
		}else if (display == 'off' && this.objCover) {
			this.objBody.removeChild(this.objCover);
			return false;
		}
	},
	setCover:function(){
		if (window.innerHeight && window.scrollMaxY) {	
			return window.innerHeight + window.scrollMaxY;
		} else if (document.body.scrollHeight > document.body.offsetHeight){
			return document.body.scrollHeight;
		} else {
			return document.body.offsetHeight;
		}
	},
	autoSetUp:function() {
		if(!document.getElementsByTagName){ return; }
		this.objBody = document.getElementsByTagName("body").item(0);
		this.setCover();
		var anch    = document.getElementsByTagName('a');
		var path;
		for (var i = 0; i < anch.length; i++) {
			var name = anch[i].getAttribute('name');
			
			if(!name){
				path = anch[i].getAttribute('href');
				if(path.indexOf('#') != -1 && (!path.split('#')[0] || path.split('#')[0] == location.href.split('#')[0])){
					anch[i].onclick = function(){
						scroll.allCover('on');
						scroll.scrollTo(0, this.getAttribute('href').split('#')[1]);
						return false;
					}
				}
			}
		}
	}
}

var scroll = new ScrollClass();

function uaScroll(){
	scroll.autoSetUp();
}
