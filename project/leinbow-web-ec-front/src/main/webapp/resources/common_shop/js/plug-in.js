/**
 * FileName:plug-in.js
 * @author
 */
var c = 0;
$.fn.extend({
	menuOpener:function(obj){
		var aClass        = (obj.aClass)?obj.aClass:'active';
		var oClass        = (obj.oClass)?obj.aClass:'open';
		var style         = (obj.style)?obj.style:{'position':'absolute'};
		var autoClose     = (obj.autoClose)?obj.autoClose:false;
		var autoCloseTime = (obj.autoCloseTime)?obj.autoCloseTime:100;
		var handle        = (obj.handle)?obj.handle:'click';
		var speed         = (obj.speed)?obj.speed:1;
		var interval      = (obj.interval)?obj.interval:10;
		var $closeBtn     = (obj.closeBtn)?$(obj.closeBtn):false;
		var $openElement  = false;
		var k = 0;
		var trgLength = this.length;

		var chPosition,chAutoClose,chCloseBtn,$div,$next,$this;

		var isMobile = false;
		var ua =navigator.userAgent;
		if(ua.indexOf('iPhone') > -1 || ua.indexOf('iPad') > -1 || ua.indexOf('iPod')  > -1 || ua.indexOf('Android')  > -1){
			isMobile=true;
		}else{
			isMobile=false;
		}


		/* set slide element */
		this.each(function(){
			$this = $(this);
			if($this.next().length){

				style       = (obj.style)?obj.style:{'position':'absolute'};
				chPosition  = 'absolute'
				chAutoClose = true;
				chCloseBtn  = false;

				/* */
				
				/* min-width exist check */
				if (typeof document.documentElement.style.minWidth != "undefined") {
					$div = $('<div>').css({
						'overflow':'hidden'
						,'height':0 + 'px'
						,'min-width':$this.parent().width() + 'px'
					});
				}else{
					$div = $('<div>').css({
						'overflow':'hidden'
						,'height':0 + 'px'
						,'width':$this.parent().width() + 'px'
					});
				}

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
			
			/* Set width to SubCategory */
			if($this.parent().parent().parent().hasClass('area-categoryNavigation-01')){
				var w    = _getWidth($tar);
				$tar.css({'width': (w<$tar.parent().parent().width())? w+'px':$tar.parent().parent().width()+'px'});
			}
			
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
				if(autoClose){
					_autoCloser([$tar,$trg]);
				}
				_bypassSlide($tar,h,$trg);
				$openElement = $tar;
			}else if($openElement && $tar.get(0) == $openElement.get(0) && handle == 'click'){
				_closer($openElement,$openElement.prev());
				$openElement = false;
			}else{
				_closer($openElement,$openElement.prev());
				if(autoClose){
					_autoCloser([$tar,$trg]);
				}
				_bypassSlide($tar,h,$trg);
				$openElement = $tar;
			}
			if(!data.bindCheck && $openElement){
				$openElement.find('> div > ul > li > a').menuOpener(
					{
						speed:4,
						interval:1,
						
						style:{
							'position':data.chPosition,
							'width':$openElement.width() +'px',
							'left':(data.index == trgLength - 1)?$openElement.width() * -1 + 'px':$openElement.width() + 'px',
							'zIndex':20,
							'top': 0 + 'px'
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
							$openElement = false;
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
		function _getWidth($tar){
			var highest = 0;
			$tar.children().each(function(){
				highest = (highest < this.offsetWidth)?this.offsetWidth:highest;
			})
			return highest;
		}
		function _autoCloser(ary) {
			var len = ary.length;
			var $ary;
			var t = ary[0].get(0).autoCloseTimer;
			for(var i = 0; i < len; i++){
				$ary = ary[i];
				$ary.unbind('mouseout');
				$ary.mouseout(function(){
					clearTimeout(t);
					t = setTimeout(function(){
						ary[0].removeClass(oClass);
						ary[0].css({'overflow':'hidden'});
						_bypassSlide(ary[0],0,ary[1]);
						if($openElement && $openElement.get(0) == ary[0].get(0)){
							$openElement = false;
						}
					},autoCloseTime)
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
		}
		function _bypassSlide($tar,h,$trg){
			clearInterval($trg.get(0).data.timer);
			$trg.get(0).data.timer = setInterval(
				function(){
					_slider($tar,h,$trg)
				},interval
			);
		}
		function _slider($tar,lastH,$trg){
			var type  = (lastH == 0)?-1:1;
			var strH  = ($tar.height()==0)?1:$tar.height();
			var nextH = Math.ceil(Math.abs(lastH - strH) / speed);
			$tar.css({'height': (strH + nextH * type) +'px'});
			if(lastH !=0 && lastH - strH == 1){
				$tar.css({'height':'auto','overflow':'visible'});
				$tar.addClass(oClass);
				if($('#restir_viewer.flash').length && !$tar.parents('.' +oClass).length){
						//alert('open');
//					xxx();  //・ｽ・ｽ Flash ・ｽﾌポ・ｽC・ｽ・ｽ・ｽ^・ｽ・ｽ・ｽ・ｽp・ｽﾌ関撰ｿｽ
					if(!isMobile){
						swfName("external_restir_viewer").disableCursor();
					}
				}
				clearInterval($trg.get(0).data.timer);
			}
			else if(lastH == 0 && strH == 1){
				$trg.removeClass(aClass);
				$trg.parent().removeClass(aClass);
				if($('#restir_viewer.flash').length && !$('#categoryNavigation-A > ul > li.' +aClass).length){
						//alert('close');
//					yyy();・ｽ@// ・ｽ・ｽ Flash ・ｽﾌポ・ｽC・ｽ・ｽ・ｽ^・ｽL・ｽ・ｽp・ｽﾌ関撰ｿｽ
					if(!isMobile){
						swfName("external_restir_viewer").enableCursor();
					}
				}
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

		if(limt < max){$trgNext.fadeIn(300);}

		$trgPrev.click(function(){
			_bypassSlide(1);
			counter++;
			if(counter == max){
				$trgPrev.hide();
				$trgNext.show();
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
				$trgPrev.show();
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
		var isMobile = false;
		var ua =navigator.userAgent;
		if(ua.indexOf('iPhone') > -1 || ua.indexOf('iPad') > -1 || ua.indexOf('iPod')  > -1 || ua.indexOf('Android')  > -1){
			isMobile=true;
		}else{
			isMobile=false;
		}
		var len = itemArray.length;
		if(isMobile){
			$('#restir_viewer').css('display','none');		
			$('.div-A').prepend('<div id="viewer" class="javascript"></div>');
		}else{
			$('#restir_viewer').css('visibility','visible');
		}
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

		var preloadimages=[];

		var img = new Image();
		img.src = '/g_images/prt-disable-01.gif';

		var newImages      = {};

		if(itemArray[0]){
			this.find('.orders,.ask').hide();
		}

		var $this          = this;
		var progressed     = [itemArray[1],'','','',''];

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
		var $soldOutElem   = $('<em>SOLD OUT<em>');

		/* set default color */
		_setColorObj($colorElem,colorObj);
		_setDisable();

		/* **** Color *** */
		function _setColorObj($tar,obj){
			var $ul = $('<UL>');
			var checkFirstColor  = false;
			var checkFirstSelect = false;
			var checkQuantity;

			$tar.html($ul);
			for(var a in obj){
				if(!checkFirstColor){
					checkFirstColor = a;
				}
				var c = obj[a];
				var $a = $('<a>').attr('href','#').css({'backgroundColor':c['colorCode']}).html($('<IMG>').attr({'src':img.src,'width':28,'height':28}));
				$a.get(0).data = a;
				var li = $('<li>').appendTo($ul).append($a);
				if(!c['quantity']) {
					$a.find('img').show();
				}else{
					$a.find('img').hide();
				}

				if(!isMobile){
					preloadimages[a] = new Image();
					preloadimages[a].src = c['img'];
				}else{
					preloadimages[a] = new Array(7);
					preloadimages[a][0] = new Image();
					preloadimages[a][0].src = c['img'];
					for(var i=1;i<7;i++){
						preloadimages[a][i] = new Image();
						preloadimages[a][i].src = c['img'].replace("pc1","pc"+i).replace("-m.jpg","-s.jpg");
					}
				}

				checkQuantity = _checkQuantity($a,colorObj,'size');
				
				if(!isMobile){ 
					$a.click(function(){
						progressed[1] = this.data;
						progressed[2] = progressed[3] = progressed[4] = false;
						_setElem([
							{$tar:$colorNameElem,elem:colorObj[this.data]['name']},
							{$tar:$imageElem,elem:''},
							{$tar:$dataElem,elem:'&nbsp;'},
							{$tar:$sizeNameElem,elem:'&nbsp;'}
						]);
						_setQuantity();
						_setSizeObj($sizeElem,colorObj[this.data]['size'],true);
						_setActive($ul,progressed[1]);
						_setDisable();

						if(!checkFirstSelect && this.data != checkFirstColor){
							so2.addVariable("flashIndex",colorObj[this.data]['imgKey']); // for Flash
						}else if(checkFirstSelect){
							changeImage(colorObj[this.data]['imgKey']); // for Flash
							return false						
						}
						so2.write("restir_viewer");
					});
					$a.mouseover(function(){
						var sizeName = (progressed[2])?progressed[2]:'&nbsp;';
						var dataTxt  = (progressed[2])?colorObj[this.data]['size'][progressed[2]]['txt']:'&nbsp;';
						_setSizeObj($sizeElem,colorObj[this.data]['size']);
						_setElem([
							{$tar:$colorNameElem,elem:colorObj[this.data]['name']},
							{$tar:$imageElem,elem:$('<IMG>').attr({'src':colorObj[this.data]['img']})}
						]);
					});
					$a.mouseout(function(){
						if(progressed[1]){
							_setSizeObj($sizeElem,colorObj[progressed[1]]['size']);
						}else{
							_setSizeObj($sizeElem,sizeObj);
						}
						var colorName  = (progressed[1])?colorObj[progressed[1]]['name']:'&nbsp;';
						var colorImage = (progressed[1])?$('<IMG>').attr({'src':colorObj[this.data]['img']}):'&nbsp;';
						var sizeName   = (progressed[2])?progressed[2]:'&nbsp;';
						var dataTxt    = (progressed[1] && progressed[2])?colorObj[progressed[1]]['size'][progressed[2]]['txt']:'&nbsp;';
						_setElem([
							{$tar:$colorNameElem,elem:colorName},
							{$tar:$imageElem,elem:''}
						]);
						_setActive($sizeElem.find('ul'),progressed[2]);
					});
					if(!checkFirstSelect && checkQuantity){
						$a.trigger('click');
						checkFirstSelect = true;
					}
				}else{

					$a.mouseover(function(){
						progressed[1] = this.data;
						progressed[2] = progressed[3] = progressed[4] = false;
						_setElem([
							{$tar:$colorNameElem,elem:colorObj[this.data]['name']},
							{$tar:$imageElem,elem:''},
							{$tar:$dataElem,elem:'&nbsp;'},
							{$tar:$sizeNameElem,elem:'&nbsp;'}
						]);
						_setQuantity();
						_setSizeObj($sizeElem,colorObj[this.data]['size'],true);
						_setActive($ul,progressed[1]);
						_setDisable();
							
						// viewerObject is global
						
						var nextViewerObject = new Object();
						var imageAddr = colorObj[this.data]['img'].split('/');
						var imageName = imageAddr[3].split('-pc1-');
						
						nextViewerObject['path']= "/g_images/"+ imageAddr[2] +"/";
						nextViewerObject['images']="";

						/* load default images */
						var $newImage;
						if(!newImages[0]){
							for(var i=0;i<6;i++){
								$newImage = $('<img>');
								var imageNumber = i+1;
								$newImage.attr('src',nextViewerObject['path'] + imageName[0] + "-pc"+ imageNumber + "-s.jpg");
								newImages[i] = $newImage;
							}
						}

						/* for click */
						$(function(){
							nextViewerObject['images']="";
							for(var i=0;i<6;i++){
								var imageNumber = i+1;
								if(newImages[i][0].height>0){
									if(i!=0){
										nextViewerObject['images']+=';';
									}
									nextViewerObject['images']+= imageName[0] + '-pc' + imageNumber;
								}
							}
							viewerObject = nextViewerObject;
							$('#viewer').empty();
							$('#viewer').itemViewer({ fadeSpeed:1000 });
						});
						
						
						/* for first time */
						$(window).load(function(){
							nextViewerObject['images']="";
							for(var i=0;i<6;i++){
								var imageNumber = i+1;
								if(newImages[i][0].height>0){
									if(i!=0){
										nextViewerObject['images']+=';';
									}
									nextViewerObject['images']+= imageName[0] + '-pc' + imageNumber;
								}
							}
							viewerObject = nextViewerObject;
							$('#viewer').empty();
							$('#viewer').itemViewer({ fadeSpeed:1000 });
						});
					});
					if(!checkFirstSelect && checkQuantity){
						$a.trigger('mouseover');
						checkFirstSelect = true;
					}
				}
				
			}
			if(!checkFirstSelect){
				if(!isMobile){
					$tar.find('ul li a:eq(0)').trigger('click');
				}else{
					$tar.find('ul li a:eq(0)').trigger('mouseover');
				}
				checkFirstSelect = true;
			}
		}

		/* **** Size *** */
		function _setSizeObj($tar,obj,flg){
			var $ul = $('<UL>');
			$tar.html($ul);
			var total = 0;
			var check = false;
			for(var a in obj){
				var s = obj[a];
				var $a = $('<a>').attr('href','#').html(a);
				$a.get(0).data = a;
				
				if(!isMobile){
					$a.click(function(){
						if($(this).hasClass(dClass)){return false;}
						progressed[2] = (progressed[1])?this.data:false;
						if(progressed[2] && progressed[1]){
							progressed[3] = colorObj[progressed[1]]['size'][this.data]['jncode'];
							progressed[4] = colorObj[progressed[1]]['size'][this.data]['quantity'];
						}
						var dataTxt  = (progressed[1])?colorObj[progressed[1]]['size'][this.data]['txt']:'&nbsp;';
						var sizeName = (progressed[1])?this.data:'&nbsp;';
						_setElem([
							{$tar:$sizeNameElem,elem:sizeName},
							{$tar:$dataElem,elem:dataTxt}
						]);
						_setActive($ul,progressed[2]);
						_setDisable();
						_setQuantity();
						return false;
					});
					$a.mouseover(function(){
						var dataTxt  = (progressed[1])?colorObj[progressed[1]]['size'][this.data]['txt']:'&nbsp;';
						var sizeName = (progressed[1])?this.data:'&nbsp;';
						if(!obj[this.data]['quantity']){
							_setElem([
								{$tar:$sizeNameElem,elem:$('<span>'+sizeName+'<em class="out">SOLD OUT</em></span>')},
								{$tar:$dataElem,elem:dataTxt}
							]);
						}else{
							_setElem([
								{$tar:$sizeNameElem,elem:sizeName},
								{$tar:$dataElem,elem:dataTxt}
							]);
						}
					});
					$a.mouseout(function(){
						var dataTxt  = (progressed[1] && progressed[2])?colorObj[progressed[1]]['size'][progressed[2]]['txt']:'&nbsp;';
						var sizeName = (progressed[2])?progressed[2]:'&nbsp;';
						_setElem([
							{$tar:$sizeNameElem,elem:sizeName},
							{$tar:$dataElem,elem:dataTxt}
						]);
					});
					$a.focus(function(){
						this.blur();
					});
				} else {
					$a.mouseover(function(){
						var dataTxt  = (progressed[1])?colorObj[progressed[1]]['size'][this.data]['txt']:'&nbsp;';
						var sizeName = (progressed[1])?this.data:'&nbsp;';
						if(!obj[this.data]['quantity']){
							_setElem([
								{$tar:$sizeNameElem,elem:$('<span>'+sizeName+'<em class="out">SOLD OUT</em></span>')},
								{$tar:$dataElem,elem:dataTxt}
							]);
						}else{
							_setElem([
								{$tar:$sizeNameElem,elem:sizeName},
								{$tar:$dataElem,elem:dataTxt}
							]);
						}
						
						if($(this).hasClass(dClass)){return false;}
						progressed[2] = (progressed[1])?this.data:false;
						if(progressed[2] && progressed[1]){
							progressed[3] = colorObj[progressed[1]]['size'][this.data]['jncode'];
							progressed[4] = colorObj[progressed[1]]['size'][this.data]['quantity'];
						}
						var dataTxt  = (progressed[1])?colorObj[progressed[1]]['size'][this.data]['txt']:'&nbsp;';
						var sizeName = (progressed[1])?this.data:'&nbsp;';
						_setElem([
							{$tar:$sizeNameElem,elem:sizeName},
							{$tar:$dataElem,elem:dataTxt}
						]);
						_setActive($ul,progressed[2]);
						_setDisable();
						_setQuantity();
						return false;
					});
					$a.mouseout(function(){
						var dataTxt  = (progressed[1] && progressed[2])?colorObj[progressed[1]]['size'][progressed[2]]['txt']:'&nbsp;';
						var sizeName = (progressed[2])?progressed[2]:'&nbsp;';
						_setElem([
							{$tar:$sizeNameElem,elem:sizeName},
							{$tar:$dataElem,elem:dataTxt}
						]);
					});
					$a.focus(function(){
						this.blur();
					});
				}
				
				if(!s['quantity']){
					$a.addClass(dClass);
				}
				var li = $('<li>').appendTo($ul).append($a);
				if(s['quantity'] && !check && flg){
					if(!isMobile){
						$a.trigger('click');
					}else{
						$a.trigger('mouseover');
					}
					check = true;
				}
			}
		}
		function _setElem(ary){
			var len = ary.length;
			for(var i = 0; i < len; i++){
				ary[i].$tar.html(ary[i].elem);
			}
		}
		function _checkQuantity($tar,obj,index){
				var total = 0;
				for(var a in obj[$tar.get(0).data][index]){
					total += obj[$tar.get(0).data][index][a]['quantity'];
				}
				if(!total){
					$tar.find('img').show();
				}else{
					$tar.find('img').hide();
				}
				return total;
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
			$quantityElem.unbind('change');
			if(!progressed[4]){
				_setValue();
				return false
			}
			var $tar = $quantityElem;
			var q = progressed[4];
			progressed[4] = 1;
			_setValue();
			if(q){
				$tar.html('');
			}
			var opt = $('<option>').appendTo($tar).html('1')
			for(var i = 2; i <= q; i++){
				var opt = $('<option>').appendTo($tar).html(i)
			}
			$tar.change(function(){
				var n = $(this).val();
				progressed[4] = n;
				_setValue();
				return false;
			})
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
//			if($(this).closest('form').find('input[type="hidden"]').length){alert($(this).closest('form').find('input[type="hidden"]').val());return false}
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
	},
	
	itemViewer:function(obj){
		if(!viewerObject){return false;}

		var isMobile = false;
		var ua =navigator.userAgent;
		if(ua.indexOf('iPhone') > -1 || ua.indexOf('iPad') > -1 || ua.indexOf('iPod')  > -1 || ua.indexOf('Android')  > -1){
			isMobile=true;
		}else{
			isMobile=false;
		}
		
		var fadeSpeed = (obj.fadeSpeed)?obj.fadeSpeed:100;
		var $ul = $('<ul>');
		var $p = $('<p>');
		var $span = $('<span>').hide();
		var alp = ['A','B','C','D','E','F'];
		var loader = new Image();
		loader.src = "/g_images/icn-loader-01.gif";
		$loader = $('<img src="'+loader.src+'" alt="" class="loader">');
		var imgStrArry = viewerObject['images'].split(';');
		var len = imgStrArry.length;
		for(var i = 0; i<len; i++){
			var path = viewerObject['path'] + imgStrArry[i];
			var thmImg = new Image();
			thmImg.src = path + '-s.jpg';
			var $thmImg =$('<img src="'+thmImg.src+'">');
			var $a = $('<a href="#"></a>').append($thmImg);
			var $li = $('<li>').appendTo($ul).append($a);
			$a.get(0).data = path;
			$li.addClass('li-'+alp[i]);

			$thmImg.error(function(){
				$(this).parent().parent().hide(); /* (for IE) */
			});

			if(!isMobile){
				$a.click(function(){
					var url = this.data + '-m.jpg';
					$p.html($loader);
					$loader.fadeIn(400);
					var imgPreloader = new Image();
					var $img =$('<img src="'+url+'" class="item">').hide();
					imgPreloader.onload = function(){
						imgPreloader.onload = null;
						$loader.hide();
						$p.html($img);
						$img.fadeIn(fadeSpeed);
					}
					imgPreloader.src = url;
					return false;
				});
			}else{
				$a.mouseover(function(){
					var url = this.data + '-m.jpg';
					$p.html($loader);
					$loader.fadeIn(400);
					var imgPreloader = new Image();
					var $img =$('<img src="'+url+'" class="item">').hide();
					imgPreloader.onload = function(){
						imgPreloader.onload = null;
						$loader.hide();
						$p.html($img);
						$img.fadeIn(fadeSpeed);
					}
					imgPreloader.src = url;
					return false;
				});
			}
			
		}
		this.append($p).append($ul);
		if(!isMobile){
			this.find('a:eq(0)').trigger('click');
		}else{
			this.find('a:eq(0)').trigger('mouseover');
		}
	},
	
	appendSNSButtons:function(){


		var $div = $(this);
		
		var $share     = $('<img src="/images/share.png"/>').addClass('img-share');
		$div.append($share);
		
		
		var $twitter_button  = $('<a>').addClass('addthis_button_twitter').html('<img src="/images/share_twitter.png" onMouseOver="this.src=\'/images/share_twitter_mo.png\'" onMouseOut="this.src=\'/images/share_twitter.png\'"/>');
		var $twitter_label = $('<img src="/images/share_twitter_2.png"/>').addClass('img-twitter');

		var $div_twitter =$('<div>').addClass('twitter');
		$div_twitter.append($twitter_button);
		$div_twitter.append($twitter_label);
		

		var $facebook_button = $('<a>').addClass('addthis_button_facebook').html('<img src="/images/share_facebook.png" onMouseOver="this.src=\'/images/share_facebook_mo.png\'" onMouseOut="this.src=\'/images/share_facebook.png\'"/>');
		var $facebook_label = $('<img src="/images/share_facebook_2.png"/>').addClass('img-facebook');

		var $div_facebook =$('<div>').addClass('facebook');
		$div_facebook.append($facebook_button);
		$div_facebook.append($facebook_label);


		var $mail_button = $('<a>').addClass("at300b button_mail").attr({"href": "mailto:Enter your friend's email address here?body=" + document.URL ,"title":"Send E-mail"} ).html('<img src="/images/share_mail.png" onMouseOver="this.src=\'/images/share_mail_mo.png\'" onMouseOut="this.src=\'/images/share_mail.png\'"/>');
		var $mail_label = $('<img src="/images/share_mail_2.png"/>').addClass('img-mail');

		var $div_mail =$('<div>').addClass('mail');
		$div_mail.append($mail_button);
		$div_mail.append($mail_label);

		$div.append($div_mail);
		$div.append($div_facebook);
		$div.append($div_twitter);

		var language;
		var indexEn = new RegExp("/indexEn.html");
		var indexZh = new RegExp("/indexZh.html");
		if(document.URL.match(indexEn)){
			language = "en";
		}else if(document.URL.match(indexZh)){
			language = "zh";
		}else{
			language = "ja";
		}

		var $options = $('<script type="text/javascript">var addthis_share ={templates: {twitter: " {{url}} #RESTIR"}, url_transforms: {clean: true} };var addthis_config={username : "restir", data_track_clickback: true, ui_language: "' + language + '"}</script>');
		$(this).parent().append($options);

	
		var $twitter_preload = $('<a>').html('<img src="/images/share_twitter_mo.png"/>');
		var $facebook_preload = $('<a>').html('<img src="/images/share_facebook_mo.png"/>');
		var $mail_preload = $('<a>').html('<img src="/images/share_mail_mo.png"/>');

		var addthissHost = (("https:" == document.location.protocol) ? "https:" : "http:");
		$widget = $("<script type='text/javascript' src='" + document.location.protocol + "//s7.addthis.com/js/250/addthis_widget.js'></script>");
		$(this).parent().append($widget);
		

	},
	
	menuFix:function(obj){

		var width = (obj.width)?obj.width:830;
		
		var url = document.URL;
		var gift = new RegExp("/gift/");
		var goods = new RegExp("/goods/");
		
		var $firstOne = $('#categoryNavigation-A > ul > li:first-child > a');
		
		var totalWidth = 0;
		var childCount = 0;
		var oldPaddingStr = $firstOne.css('padding-left');
		var oldPadding = Number(oldPaddingStr.slice(0,oldPaddingStr.length-2)); /* remove 'px' */
		var oldMarginStr = $firstOne.parent().css('margin-left');
		var oldMargin = Number(oldMarginStr.slice(0,oldMarginStr.length-2)); /* remove 'px' */
		
		var fixPadding = 0;
		
		/* Gift Check */
		if(url.match(gift)){
			$(this).find('li.gift > a').attr('id', 'presentlocation');
		}
		else if(url.match(goods)){
			var cid = _getUrlVars()["cid"];
			var flag = 0;
			
			$(this).find('li.gift > a').each(function(){
				$(this).parent().find('.subBlock-A > ul > li > a').each(function(){
					if( _getHrefVars($(this))["cid"] == cid ){
						flag = 1;
						return false;
					}
				});
				if(flag==1){
					$(this).attr('id', 'presentlocation');
					return false;
				}
			}); 
		}

		/* Sale Check */
		if($firstOne.text() == "SALE"){
			$firstOne.addClass('sale');
			$firstOne.html("<div style='font-size:10px; font-family: Helvetica, Arial, sans-serif; font-weight:normal;'>2010AW</div><div style='margin-top:-2px;'>SALE</div>");
			$firstOne.css({'margin-top':'-10px'});
		}
		
		/* Width Fix */
		$(this).find('> li').each(function(){
			totalWidth += $(this).width() + oldMargin;
			childCount += 1;
		});
		fixPadding = oldPadding + Math.floor((width - totalWidth) / (childCount*2) );
		$(this).find('> li > a').each(function(){
			$(this).css({'padding':'0px '+ fixPadding +'px'});
		});
		
		$(this).css({'visibility':'visible'});
		
		function _getUrlVars()
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

		function _getHrefVars(link)
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
	}
})





















