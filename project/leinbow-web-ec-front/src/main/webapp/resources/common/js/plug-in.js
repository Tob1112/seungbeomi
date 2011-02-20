/**
 * FileName:plug-in.js
 * @author
 */
var c = 0;
$.fn.extend({
	menuOpener:function(obj){
		var aClass       = (obj.aClass)?obj.aClass:'active';
		var oClass       = (obj.oClass)?obj.aClass:'open';
		var style        = (obj.style)?obj.style:{'position':'absolute'};
		var autoClose    = (obj.autoClose)?obj.autoClose:false;
		var handle       = (obj.handle)?obj.handle:'click';
		var speed        = (obj.speed)?obj.speed:1;
		var interval     = (obj.interval)?obj.interval:10;
		var $closeBtn    = (obj.closeBtn)?$(obj.closeBtn):false;
		var $openElement = false;
		var k = 0;
		var trgLength = this.length;

		var chPosition,chAutoClose,chCloseBtn,$div,$next,$this;


		/* set slide element */
		this.each(function(){
			$this = $(this);
			if($this.next().length){

				/* irregular */
				if($this.parent().hasClass('brands')){
					style       = {'position':'absolute','width':960 + 'px','left':0}
					chPosition  = 'static'
					chAutoClose = false;
					chCloseBtn  = '#categoryNavigation-A .close a,#categoryNavigation-A > ul > li:not(.brands) > a';
				}else{
					style       = (obj.style)?obj.style:{'position':'absolute'};
					chPosition  = 'absolute'
					chAutoClose = true;
					chCloseBtn  = false;
				}
				/* */

				$div = $('<div>').css({
					'overflow':'hidden'
					,'height':0 + 'px'
				});
				$div.css(style);
				$next = $this.nextAll();
				$next.wrapAll($div).css({
					'display':'block',
					'position':'static',
					'visibility':'visible'
				})
				this.data = {
					index:k,
					timer:0,
					bindCheck:false,
					chPosition:chPosition,
					auto:chAutoClose,
					chCloseBtn:chCloseBtn
				}
				k++;
			}
		});
		/* set slide element */

		this.bind(handle,function(){
			var $tar = $(this).next();
			var $trg = $(this);
			if($tar.length){
				_event($tar,$trg)
				return false;
			}
		});
		this.focus(function(){
			this.blur();
		});
		function _event($tar,$trg){
			var h    = _getHeight($tar)
			var data = $trg.get(0).data;
			$tar.removeClass(oClass);
			$trg.addClass(aClass);
			$trg.parent().addClass(aClass);

			if(!$openElement){
				_bypassSlide($tar,h,$trg);
				$openElement = $tar;
			}else if($openElement && $tar.get(0) == $openElement.get(0) && handle == 'click'){
				_closer($openElement,$openElement.prev());
				$openElement = false;
			}else{
				_closer($openElement,$openElement.prev());
				_bypassSlide($tar,h,$trg);
				$openElement = $tar;
			}

			if(autoClose){
				_autoCloser([$tar,$trg]);
			}

			if(!data.bindCheck && $openElement){
				$openElement.find('> div > ul > li > a').menuOpener(
					{
						speed:4,
						interval:1,
						style:{
							'position':data.chPosition,
							'width':$openElement.width() +'px',
							'left':(data.index == trgLength - 1)?$openElement.width() * -1 - 5 + 'px':$openElement.width() - 5 + 'px',
							'zIndex':20,
							'top':-5 + 'px'
							},
						autoClose:data.auto,
						closeBtn:data.chCloseBtn
					}
				);
			}
			data.bindCheck = true;
			if($closeBtn){
				$closeBtn.click(
					function(){
						var tar;
						if($openElement){
							$tar = $openElement;
							_closer($tar,$tar.prev());	
						}else{
							return false;
						}
					}
				)
			}
			return false;
		}
		function _getHeight($tar){
			var total = 0;
			$tar.children().each(function(){
				total += this.offsetHeight;
			})
			return total;
		}
		function _autoCloser(ary) {
			var t   = 0
			var len = ary.length;
			var $ary;
			for(var i = 0; i < len; i++){
				$ary = ary[i];
				$ary.mouseout(function(){
					clearTimeout(t);
					t = setTimeout(function(){
						_closer(ary[0],ary[1])
					},100)
				});
				$ary.mouseover(function(){
					clearTimeout(t);
				});
			}
		}
		function _closer($tar,$trg){
			$tar.removeClass(oClass);
			$tar.css({'overflow':'hidden'});
			_bypassSlide($tar,0,$trg);
			$openElement = false;
		}
		function _bypassSlide($tar,h,$trg){
			clearInterval($trg.get(0).data.timer)
			$trg.get(0).data.timer = setInterval(
				function(){
					_slider($tar,h,$trg)
				},interval
			);
		}
		function _slider($tar,lastH,$trg){
			var type  = (lastH == 0)?-1:1;
			var strH  = $tar.height();
			var nextH = Math.ceil(Math.abs(lastH - strH) / speed);
			$tar.css({'height': (strH + nextH * type) +'px'});
			if(lastH !=0 && lastH - strH == 1){
				$tar.css({'height':'auto','overflow':'visible'});
				$tar.addClass(oClass);
				clearInterval($trg.get(0).data.timer);
			}
			else if(lastH == 0 && strH == 1){
				$trg.removeClass(aClass);
				$trg.parent().removeClass(aClass);
				clearInterval($trg.get(0).data.timer);
			}
		}
	},



	carousel:function(obj){

		var $trgPrev   = $(this).find(obj.prevBtn);
		var $trgNext   = $(this).find(obj.nextBtn);
		var $tar       = $(this).find(obj.target).wrap('<div></div>').parent().css({'marginLeft':0});
		var wid        = obj.width;
		var span       = obj.span;
		var interval   = (obj.interval)?obj.interval:1;
		var speed      = (obj.speed)?obj.speed:1;
		var max        = $tar.find('li').length;
		var timer      = 0;
		var counter    = max;
		var limt       = wid / span;
		var clickCheck = false;

		$trgPrev.fadeOut(300);
		if(limt >= max){$trgNext.fadeOut(300);}

		$trgPrev.click(function(){
			_bypassSlide(1);
			counter++;
			if(counter == max){
				$trgPrev.hide();$trgNext.show();
			}else{
				$trgNext.show();
			}
			return false;
		});
		$trgNext.click(function(){
			_bypassSlide(-1);
			counter--;
			if(counter <= limt){
				$trgNext.hide();
			}else{
				$trgPrev.show();
			}
			return false;
		});
		function _bypassSlide(type){
			var defMargin;
			if(clickCheck){return false;}
			clickCheck = true;
			clearInterval(timer);
			defMargin =  parseInt($tar.css('marginLeft'));
			timer = setInterval(function(){
				_slider($tar,defMargin +(type * span));
			},interval);
		}
		function _slider($tar,lastM){
			var strM  = parseInt($tar.css('marginLeft'));
			var nextM = Math.ceil((lastM - strM) / speed);
			$tar.css({'marginLeft': strM + nextM +'px'});
			if(nextM == 0){
				$tar.css({'marginLeft': lastM +'px'});
				clearInterval(timer);
				clickCheck = false;
				return false;
			}
		}
	},
	itemGallery:function () {
		if(!itemArray){ return false; } //itemArray is global
		var len = itemArray.length;

		/* Object color root */
		var colorObj = new Object();
		for(var i = 2 ; i < len ; i++ ){
			colorObj[itemArray[i][1]] = {
				'name':itemArray[i][2]
				,'colorCode':itemArray[i][3]
				,'size':{}
				,'img':itemArray[i][7]
				,'imgKey':itemArray[i][8]
			}
		}
		for(var i = 2 ; i < len ; i++ ){
			colorObj[itemArray[i][1]]['size'][itemArray[i][4]] = {
				'jncode':itemArray[i][0]
				,'txt':itemArray[i][5]
				,'quantity':itemArray[i][6]
			}
		}

		/* Object size root */
		var sizeObj = new Object();
		for(var i = 2 ; i < len ; i++ ){
			sizeObj[itemArray[i][4]] = {
				'color':{}
			}
		}
		for(var i = 2; i < len ; i++ ){
			sizeObj[itemArray[i][4]]['color'][itemArray[i][1]] = {
				'jncode':itemArray[i][0]
				,'name':itemArray[i][2]
				,'colorCode':itemArray[i][3]
				,'colorKey':itemArray[i][1]
				,'quantity':itemArray[i][6]
			}
		}

		preloadimages=[];
		var img = new Image();
		img.src = '/g_images/prt-disable-01.gif';

		/* ask  */
		if(itemArray[0]){
			this.find('.ask').show();
		}else if(!itemArray[0]){
			this.find('.orders').show();
		}

		var $this          = this;
		var progressed     = [itemArray[1],'','','','']

		/* set className */
		var dClass         = 'disable';
		var aClass         = 'active';

		/* target elements */
		var $imageElem     = this.find('div.div-A .image');
		var $colorElem     = this.find('dl.color dd');
		var $colorNameElem = this.find('dl.color .name');
		var $sizeElem      = this.find('dl.size dd')
		var $dataElem      = this.find('dl.data dd');
		var $sizeNameElem  = this.find('dl.size .name');
		var $quantityElem  = this.find('.orders .quantity dd select');

		/* set default color */
		var i = 0;
		for(var a in colorObj){
			var c = colorObj[a];
			preloadimages[a] = new Image();
			preloadimages[a].src = c['img'];
			if(!i){
				_setColorObj($colorElem,colorObj);
				_setSizeObj($sizeElem,sizeObj,true);
				_checkQuantity($colorElem.find('ul li a'),colorObj,'size');
				_setDisable();
				return false;
			}
		}

		/* **** Color *** */
		function _setColorObj($tar,obj){
			var $ul = $('<UL>');
			$tar.html($ul);
			for(var a in obj){
				var c = obj[a];
				var $a = $('<a>').attr('href','#').css({'backgroundColor':c['colorCode']}).html($('<IMG>').attr({'src':img.src,'width':28,'height':28}));
				$a.get(0).data = a;
				$a.click(function(){
					progressed[1] = this.data;
					progressed[2] = progressed[3] = progressed[4] = false;
					_setElem($colorNameElem,colorObj[this.data]['name'],true);
					_setElem($imageElem,'');
					_setElem($dataElem,'&nbsp;');
					_setElem($sizeNameElem,'&nbsp;');
					_setSizeObj($sizeElem,colorObj[this.data]['size'],false);
					_setActive($ul,progressed[1]);
					_checkQuantity($colorElem.find('ul li a'),colorObj,'size');
					_setDisable();
					_setQuantity();
					changeImage(colorObj[this.data]['imgKey']); // for Flash
					return false;
				});
				$a.mouseover(function(){
					var sizeName = (progressed[2])?progressed[2]:'&nbsp;';
					var dataTxt  = (progressed[2])?colorObj[this.data]['size'][progressed[2]]['txt']:'&nbsp;';
					_setSizeObj($sizeElem,colorObj[this.data]['size']);
					_setElem($colorNameElem,colorObj[this.data]['name'],false);
					_setElem($imageElem,$('<IMG>').attr({'src':colorObj[this.data]['img']}),false)
					_setElem($dataElem,dataTxt);
					_setElem($sizeNameElem,sizeName);
				})
				$a.mouseout(function(){
					if(progressed[1]){
						_setSizeObj($sizeElem,colorObj[progressed[1]]['size']);
					}else{
						_setSizeObj($sizeElem,sizeObj,true);
					}
					var colorName  = (progressed[1])?colorObj[progressed[1]]['name']:'&nbsp;';
					var colorImage = (progressed[1])?$('<IMG>').attr({'src':colorObj[this.data]['img']}):'&nbsp;';
					var sizeName   = (progressed[2])?progressed[2]:'&nbsp;';
					var dataTxt    = (progressed[1] && progressed[2])?colorObj[progressed[1]]['size'][progressed[2]]['txt']:'&nbsp;';
					_setElem($colorNameElem,colorName);
					_setElem($imageElem,'');
					_setElem($sizeNameElem,sizeName);
					_setElem($dataElem,dataTxt);
				})
				var li = $('<li>').appendTo($ul).append($a);
				if(!c['quantity']) {
					$a.find('img').show();
				}else{
					$a.find('img').hide();
				}
			}
		}

		/* **** Size *** */
		function _setSizeObj($tar,obj,flg){
			var $ul = $('<UL>');
			$tar.html($ul);
			var total = 0;
			for(var a in obj){
				var s = obj[a];
				var $a = $('<a>').attr('href','#').html(a);
				$a.get(0).data = a;
				$a.click(function(){
					if($(this).hasClass(dClass)){return false;}
					progressed[2] = (progressed[1])?this.data:false;
					if(progressed[2] && progressed[1]){
						progressed[3] = colorObj[progressed[1]]['size'][this.data]['jncode'];
						progressed[4] = colorObj[progressed[1]]['size'][this.data]['quantity'];
					}
					_setActive($ul,progressed[2]);
					_setDisable();
					_setQuantity();
					return false;
				});
				$a.mouseover(function(){
					var dataTxt  = (progressed[1])?colorObj[progressed[1]]['size'][this.data]['txt']:'&nbsp;';
					var sizeName = (progressed[1])?this.data:'&nbsp;';
					_setElem($sizeNameElem,sizeName);
					_setElem($dataElem,dataTxt);
				});
				$a.mouseout(function(){				
					var dataTxt  = (progressed[1] && progressed[2])?colorObj[progressed[1]]['size'][progressed[2]]['txt']:'&nbsp;';
					var sizeName = (progressed[2])?progressed[2]:'&nbsp;';
					_setElem($sizeNameElem,sizeName);
					_setElem($dataElem,dataTxt);

				});
				$a.focus(function(){
					this.blur();
				})
				if(!s['quantity'] && !flg){
					$a.addClass(dClass);
				}
				var li = $('<li>').appendTo($ul).append($a);
			}
			_setActive($ul,progressed[2]);
		}
		function _setElem($tar,elem){
			$tar.html(elem);
		}
		function _checkQuantity($tar,obj,index){
			$tar.each(function(){
				var total = 0;
				for(var a in obj[this.data][index]){
					total += obj[this.data][index][a]['quantity'];
				}
				if(!total){
					$(this).find('img').show();
				}else{
					$(this).find('img').hide();;		
				}
			});	
		}
		function _setDisable(){
			if(progressed[4]){
				$this.find('.orders .disabled').hide();
				$this.find('.orders select').get(0).disabled = false;
			}else{
				$this.find('.orders .disabled').show();
				$this.find('.orders select').get(0).disabled = true;
			}
		}
		function _setQuantity(){
			if(!progressed[4]){
				_setValue();
				return false
			}
			$tar = $quantityElem;
			q = progressed[4];
			progressed[4] = 1;
			_setValue();
			if(q){
				$tar.html('');
			}
			var opt = $('<option>').appendTo($tar).html('1')
			for(var i = 2; i <= q; i++){
				var opt = $('<option>').appendTo($tar).html(i)
				opt.click(function(){
					var n = $(this).html();
					progressed[4] = n;
					_setValue();
					return false;
				})
			}
		}
		function _setActive(tar,index){
			tar.find('li').removeClass(aClass);
			tar.find('li').each(function(){
				if($(this).find('a').get(0).data == index){
					$(this).addClass(aClass);
				};
			});
		}
		function _setValue(){
			$this.find('.request input').val(
				progressed[0] + ',' + progressed[3] + ',' + progressed[4]
			)
		}
	},
	jsSubmit:function(){
		$(this).click(function(){
			$(this).closest('form').get(0).submit();	
		})
	},
	setDefaultValue:function(){
		this.focus(function(){
			if(this.value == this.defaultValue){
				this.value = "";
				this.style.color = '#000'
			}
		})
		this.blur(function(){
			if(!this.value){
				this.value = this.defaultValue;
				this.style.color = '#999'
			}else{
				this.style.color = '#000'
			}
		})
	},
	reorderElements:function(){
		this.find('ul:eq(1)').each(
			function(){
				var uls = [];
				var items = []
				var n = $(this).find('li').length;
				var rows = Math.ceil(n / 4);
				for(var i = 0; i < rows; i++){
					items[i] = [];
					for(var ii = i; ii < n ; ii +=rows ){
						items[i][items[i].length] = $(this).find('li:eq(' + ii + ')')
					}
				}
				var ul = [];
				var len = items.length;
				for(var i = 0; i < len; i++){
					ul[i] = $('<ul>');
					var len2 = items[i].length;
					for(var ii = 0; ii < len2; ii++){
						ul[i].append(items[i][ii]);
					}
				}
				len = ul.length;
				for(var i = 0; i < len; i++){
					$(this).parent().append(ul[i]);
				}
				$(this).remove();
			}
		);
		var anc = this.find('ul a');
		anc.each(function(){
			var h = $(this).closest('ul').height();
			$(this).css(
				{
					'minHeight':h-2 + 'px'
				}
			)
		});
	}
})





















