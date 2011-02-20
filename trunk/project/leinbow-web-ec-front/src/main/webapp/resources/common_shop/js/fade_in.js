/* ===============================================
 *
 *	RESTIR内追加js
 *	HOME ニュース画像
 *	フェードイン・フェードアウト
 *	コンテンツタイトル ロールオーバー
 *	Mailアドレス入力
 *
 * ============================================== */

var imgID = "";
var tgtID = "";


var imgTitle	= new Array();

for (i = 0; i <= 4; i++) {
	imgTitle[i] = new Array();
}

var trgtIMG = "";


window.onload = function() {
//マウスアウトとオンマウスの画像を先読み ======================================
	//Magazine --------------------------
	imgTitle[0][0] = "files_top/magazine/images/categoryid-01.gif";
	imgTitle[0][1] = "files_top/magazine/images/categoryid-01-ovr.gif";

	//Videos ----------------------------
	imgTitle[1][0] = "files_top/videos/images/categoryid-01.gif";
	imgTitle[1][1] = "files_top/videos/images/categoryid-01-ovr.gif";

	//News ------------------------------
	imgTitle[2][0] = "files_top/news/images/categoryid-01.gif";
	imgTitle[2][1] = "files_top/news/images/categoryid-01-ovr.gif";

	//Blog ------------------------------
	imgTitle[3][0] = "files_top/blog/images/categoryid-01.gif";
	imgTitle[3][1] = "files_top/blog/images/categoryid-01-ovr.gif";

	//Music -----------------------------
	imgTitle[4][0] = "files_top/music/images/categoryid-01.gif";
	imgTitle[4][1] = "files_top/music/images/categoryid-01-ovr.gif";



//各コンテンツエリア　マウスイベント判定 ======================================
	//Magazine --------------------------
	document.getElementById('restir_topMagazine').onmouseover = function() {
		trgtIMG = document.getElementById('title_magazine');
		trgtIMG.src = imgTitle[0][1];
	}

	document.getElementById('restir_topMagazine').onmouseout = function() {
		trgtIMG = document.getElementById('title_magazine');
		trgtIMG.src = imgTitle[0][0];
	}

	//Videos ----------------------------
	document.getElementById('restir_topVideos').onmouseover = function() {
		trgtIMG = document.getElementById('title_videos');
		trgtIMG.src = imgTitle[1][1];
	}

	document.getElementById('restir_topVideos').onmouseout = function() {
		trgtIMG = document.getElementById('title_videos');
		trgtIMG.src = imgTitle[1][0];
	}

	//News ------------------------------
	document.getElementById('restir_topNews').onmouseover = function() {
		trgtIMG = document.getElementById('title_news');
		trgtIMG.src = imgTitle[2][1];
	}

	document.getElementById('restir_topNews').onmouseout = function() {
		trgtIMG = document.getElementById('title_news');
		trgtIMG.src = imgTitle[2][0];
	}

	//Blog ------------------------------
	document.getElementById('restir_topBlog').onmouseover = function() {
		trgtIMG = document.getElementById('title_blog');
		trgtIMG.src = imgTitle[3][1];
	}

	document.getElementById('restir_topBlog').onmouseout = function() {
		trgtIMG = document.getElementById('title_blog');
		trgtIMG.src = imgTitle[3][0];
	}

	//Music -----------------------------
	document.getElementById('restir_topMusic').onmouseover = function() {
		trgtIMG = document.getElementById('title_music');
		trgtIMG.src = imgTitle[4][1];
	}

	document.getElementById('restir_topMusic').onmouseout = function() {
		trgtIMG = document.getElementById('title_music');
		trgtIMG.src = imgTitle[4][0];
	}



//Mailアドレス入力 =============================================================================
	
		document.getElementById('inpMail').onclick = function() {
		var mailBG = document.getElementById('inpMail').style;
		mailBG.background = 'none';
	}

	document.getElementById('inpMail').onblur = function() {
		var mailBG = document.getElementById('inpMail');
		if (mailBG.value == "") {
			mailBG.style.background = 'url(common_shop/css/formBG.jpg) no-repeat 0 50%';
		}
	}





//フェードイン関連 =============================================================================
	var obj = document.getElementById('restir_topNews');	//ニュースエリアの要素を取得
	var newsImgObj = obj.getElementsByTagName('img');		//ニュースエリアのimg情報を取得
	var newsObjMax = newsImgObj.length;


	// Newsサムネール画像にID名を自動で付ける --------------------------------------------------
	for (i=0; i<(newsObjMax); i++) {
		imgID = 'imgNum' + i;
		newsImgObj[i].setAttribute('id', imgID);			//imgに新しくid要素を作り、名前をつける
	}


	// マウスイベント別にフェードイン・アウトの実行 --------------------------------------------
	for (j=0; j<=(newsObjMax); j++) {
		imgID = 'imgNum' + j;

		document.getElementById(imgID).onmouseover = function() {
			tgtID = this.id;
			fadeImg(tgtID, 1);
		}
		
		document.getElementById(imgID).onmouseout = function() {
			tgtID = this.id;
			fadeImg(tgtID, 0);
		}
	}

}






//フェードイン関連 =============================================================================
// フェードイン・アウトの振り分け -----------------------------------------------------------
//IE：			開始透明度 0（透明） ～ 100（不透明）-整数値
//Firefox：	開始透明度 0（透明） ～ 1.0（不透明）-小数値
//この数値の違いのためMozilla Firefoxのソースで opa/100 の処置
//この opacity の数値を増加させることによってフェードインを行う
//opa、opacnt、opastep、timerOver、timerOutの数値は変更可能

var opa				= 50;		//フェードイン透明度　0は透明
var opacnt		= opa;	//透明度の増減カウント変数
var opastep		= 10;		//透明度の増減の間隔
var timerIn		= 30;		//フェードイン		setTimeout関数の実行間隔　ミリ秒
var timerOut	= 50;		//フェードアウト	setTimeout関数の実行間隔　ミリ秒
var trgtIMG;

function fadeImg(imgID, evnt) {
	trgtIMG = document.getElementById(imgID);
	trgtIMG.style.visibility = 'visible';
		
	//フェードイン
	if (evnt == 1) {
		fadeIn(imgID, 100);
	}

	//フェードアウト
	if (evnt == 0) {
		fadeOut(imgID, opa);
	}
}





//フェードイン ----------------------------------------------------------------------------
//ロールオーバー
//透明度を減少
function fadeIn(imgID, opacnt) {
	if (opacnt > opa) {
		trgtIMG = document.getElementById(imgID);
		trgtIMG.style.filter	= 'alpha(opacity:' + opacnt + ')';	// IE のソース
		trgtIMG.style.opacity	= opacnt/100;												//Mozilla Firefoxのソース
		opacnt -= opastep;
		setTimeout("fadeIn('" + imgID + "'," + opacnt + ")", timerIn);
	}
	else if (opacnt <= opa) {
		trgtIMG.style.filter	= 'alpha(opacity:' + opa + ')';			// IE のソース
		trgtIMG.style.opacity	= opa/100;													//Mozilla Firefoxのソース
		opacnt	= opa;
	}
}


//フェードアウト ----------------------------------------------------------------------------
//ロールアウト
//透明度を増加
function fadeOut(imgID, opacnt) {
	if (opacnt < 100) {
		trgtIMG = document.getElementById(imgID);
		trgtIMG.style.filter	= 'alpha(opacity:' + opacnt + ')';	// IE のソース
		trgtIMG.style.opacity	= opacnt/100;												//Mozilla Firefoxのソース
		opacnt += opastep;
		setTimeout("fadeOut('" + imgID + "'," + opacnt + ")", timerOut);
	}
	else if (opacnt >= 100) {
		trgtIMG.style.filter	= 'alpha(opacity:' + 100 + ')';			// IE のソース
		trgtIMG.style.opacity	= 1;																//Mozilla Firefoxのソース
		opacnt = opa;
	}
}

