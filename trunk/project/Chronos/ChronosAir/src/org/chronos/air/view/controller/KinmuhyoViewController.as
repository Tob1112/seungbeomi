package org.chronos.air.view.controller {

	import org.chronos.Constants;
	import org.chronos.air.common.LabelUtil;
	import org.chronos.air.event.KinmuhyoEvent;
	import org.chronos.air.event.ShinseiServiceEvent;
	import org.chronos.air.model.ApplicationModel;
	import org.chronos.air.model.Kinmuhyo;
	import org.chronos.air.model.KinmuhyoModel;
	import org.chronos.air.model.KinmuhyoShosai;
	import org.chronos.air.model.KinmuhyoShosaiMapper;
	import org.chronos.air.model.ShinkiKinmuhyo;
	import org.chronos.air.model.ShinseiJokyoEnum;
	import org.chronos.air.util.CalendarUtil;
	import org.chronos.air.util.Logger;
	import org.chronos.air.util.DateUtils;
	import org.chronos.air.util.Zip;
	import org.chronos.air.view.KinmuhyoShinkiSakuseiWindow;
	import org.chronos.air.view.KinmuhyoView;

	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.html.HTMLLoader;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.IMXMLObject;
	import mx.events.DataGridEvent;
	import mx.events.DividerEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;

	public class KinmuhyoViewController implements IMXMLObject{

		private var view:KinmuhyoView;
        [Bindable] public var model:KinmuhyoModel = KinmuhyoModel.getInstance();
        [Bindable] private var appModel:ApplicationModel = ApplicationModel.getInstance();
        [Bindable] private var kinmuhyoXML:XML; // 送信用勤務表XML
        private var stream:FileStream;

		private static const SHOW_MENU_STATE:String = "showMenu";
		private static const HIDE_MENU_STATE:String = "hideMenu";

		public function initialized(doc:Object, id:String):void {
			view = doc as KinmuhyoView;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompletHandler);
		}

		public function creationCompletHandler(e:FlexEvent):void {
			// イベント登録
			//view.kinmuhyoDividedBox.addEventListener(DividerEvent.DIVIDER_RELEASE, menuBoxToggleHandler);	// メニューのトグル機能
			view.kinmuhyoDateChooser.addEventListener(MouseEvent.CLICK, findKinmuhyoHandler);	// DateChooserから年月を取得し、勤務表を検索
			view.kinmuhyoShinkiSakuseiButton.addEventListener(MouseEvent.CLICK, popupKinmuhyoShinkiSakuseiWindow);	// 勤務表新規作成
			// TODO view.kinmuhyoPreviewButton.addEventListener(MouseEvent.CLICK, kinmuhyouPreviewHandler);	// 勤務表プレビュー
			view.kinmuhyoList.addEventListener(ListEvent.CHANGE, kinmuhyoListClickHandler);	// 勤務表リストクリック
			view.saveKinmuhyoButton.addEventListener(MouseEvent.CLICK, saveKinmuhyoHandler);	// 勤務表保存
			view.sendKinmuhyoButton.addEventListener(MouseEvent.CLICK, sendKinmuhyoHandler);        // 勤務表送信

			view.kinmuhyoShosaiDataGrid.addEventListener(DataGridEvent.ITEM_EDIT_BEGIN, beginUpdateKinmuhyoHandler);
			view.kinmuhyoShosaiDataGrid.addEventListener(DataGridEvent.ITEM_EDIT_BEGINNING, beginningUpdateKinmuhyoHandler);
			view.kinmuhyoShosaiDataGrid.addEventListener(DataGridEvent.ITEM_EDIT_END, endUpdateKinmuhyoHandler);
			setCurrentDate();	// 現在の時刻を設定する。(2011年11月3日(水))
		}

		// -----------------------------------------------------------------------------------------------------------------

		/** 現在の時刻を設定する。(2011年11月3日(水)) */
		private function setCurrentDate():void {
			var currentDate:Date = new Date();
			//view.model.currentDate = CalendarUtil.currentDateLabel(currentDate);
			model.currentDate = CalendarUtil.currentDateLabel(currentDate);
		}

		/** メニュー表示/非表示 */
		private function menuBoxToggleHandler(e:DividerEvent):void {
			if (view.currentState == SHOW_MENU_STATE) {
				view.currentState = HIDE_MENU_STATE;
			} else {
				view.currentState = SHOW_MENU_STATE;
			}
		}

		/** DateChooserから年月を取得し、勤務表を検索  */
		private function findKinmuhyoHandler(e:MouseEvent):void {
			var year:int = 0;
			var month:int = 0;
			var getsu:String = "";
			var nengetsu:String;

			switch (e.currentTarget.name) {
			case "kinmuhyoDateChooser":
				year = view.kinmuhyoDateChooser.displayedYear;
				month = view.kinmuhyoDateChooser.displayedMonth + 1;

				if (month < 10) {
					getsu = "0" + month;
				} else {
					getsu = month.toString();
				}

				// 勤務表リストと勤務表詳細と同期
				nengetsu = year + "-" + getsu;
				findKinmuhyoShosai(nengetsu);
				break;
			}
		}

		/** 勤務表新規作成ウィンドウポップアップ */
		private function popupKinmuhyoShinkiSakuseiWindow(e:MouseEvent):void {
			// 勤務表年月最大値取得
			var event:KinmuhyoEvent = new KinmuhyoEvent(KinmuhyoEvent.FIND_MAX_NENGETSU, view);
			event.dispatch();

			// 勤務表年月最大値を作業年月に設定
			var sagyoNengetsu:String = ShinkiKinmuhyo.getInstance().nengetsu;
			var sagyoNengetsuArray:Array = sagyoNengetsu.split("-");

			// 勤務表新規作成ウィンドウポップアップ
			var kinmuhyouShinkiSakuseiWindow:KinmuhyoShinkiSakuseiWindow
					= PopUpManager.createPopUp(view, KinmuhyoShinkiSakuseiWindow, true) as KinmuhyoShinkiSakuseiWindow;
			kinmuhyouShinkiSakuseiWindow.addEventListener(KinmuhyoEvent.KINMUHYO_SHINKI_SAKUSEI, kinmuhyoShinkiSakuseiHandler);	// 勤務表新規作成
			//kinmuhyouShinkiSakuseiWindow.controller.model.shinkiKinmuhyo.nengetsu = sagyoNengetsu;

			if (sagyoNengetsu != "") {
				kinmuhyouShinkiSakuseiWindow.shinkiKinmuhyoDateChooser.displayedYear = sagyoNengetsuArray[0];
				kinmuhyouShinkiSakuseiWindow.shinkiKinmuhyoDateChooser.displayedMonth = sagyoNengetsuArray[1];
			}

			PopUpManager.centerPopUp(kinmuhyouShinkiSakuseiWindow);
		}

		/** 勤務表新規作成 */
		private function kinmuhyoShinkiSakuseiHandler(e:KinmuhyoEvent):void {
			// 勤務表設定
			var nengetsu:String = model.kinmuhyo.nengetsu;
			var nengetsuArray:Array = nengetsu.split("-");
			var year:int = nengetsuArray[0];
			var month:int = nengetsuArray[1];

			view.kinmuhyoDateChooser.displayedYear = year;
			view.kinmuhyoDateChooser.displayedMonth = month - 1;

			// 保存可能状態に更新
			updateKinmuhyoStatus();

		}

		/** 勤務表プレビュー */
		private function kinmuhyouPreviewHandler(e:MouseEvent):void {
			// TODO xml, xslを利用しプレビュー
			var html:HTMLLoader = new HTMLLoader();
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			options.systemChrome = NativeWindowSystemChrome.STANDARD;
			options.type = "normal";
			var windowBounds:Rectangle = new Rectangle(0,0,300,300);
			html = HTMLLoader.createRootWindow(true, options, true, windowBounds);
			html.loadString("<html><body><h1>Hello Chronos!!</h1></body></html>");
			//view.stage.addChild(html);
		}

		/** 勤務表リストから申請アイテム選択時、該当勤務表取得 */
		private function kinmuhyoListClickHandler(e:ListEvent):void {
			var nengetsu:String = Kinmuhyo(e.currentTarget.selectedItem).nengetsu;
			findKinmuhyoShosai(nengetsu);	// 勤務表詳細検索
		}

		private function beginUpdateKinmuhyoHandler(e:DataGridEvent):void {

			Logger.log("update begin");
		}

		private function beginningUpdateKinmuhyoHandler(e:DataGridEvent):void {

			Logger.log("update beginging");
		}

		private function endUpdateKinmuhyoHandler(e:DataGridEvent):void {
			Logger.log("update end");

			updateKinmuhyoStatus();
		}

		/** 勤務表保存 */
		private function saveKinmuhyoHandler(e:MouseEvent):void {
			var event:KinmuhyoEvent = new KinmuhyoEvent(KinmuhyoEvent.SAVE_KINMUHYO);
			event.dispatch();
		}

		/** 勤務表詳細検索 */
		private function findKinmuhyoShosai(nengetsu:String):void {
			model.nengetsu = nengetsu;	// 検索のため

			var event:KinmuhyoEvent = new KinmuhyoEvent(KinmuhyoEvent.FIND_KINMUHYO_SHOSAI, view);
			event.dispatch();
		}
		/** 勤務表送信 */
        private function sendKinmuhyoHandler(e:MouseEvent):void {
				CursorManager.setBusyCursor();
				saveKinmuhyoHandler(e);	// 勤務表保存
                createKinmuhyoXML();    // 勤務表XML生成
                writeKinmuhyoXML();		// 勤務表XML作成
                zipKinmuhyo();			// 勤務表圧縮
                sendKinmuhyo();       // 勤務表送信
        }

        /** 勤務表XML作成 */
        private function createKinmuhyoXML():void {

            var kinmuhyo:Kinmuhyo = model.kinmuhyo;
            var kinmuhyoShosaiAC:ArrayCollection = model.kinmuhyoShosaiAC;
            var cursor:IViewCursor = kinmuhyoShosaiAC.createCursor();

            // 勤務表 -----------------------
            kinmuhyoXML = <勤務表/>;
            kinmuhyoXML.勤務表 = <勤務表/>;
            kinmuhyoXML.勤務表.@年月 = kinmuhyo.nengetsu;
            kinmuhyoXML.勤務表.@社員番号 = appModel.shain.shainBango;
            kinmuhyoXML.勤務表.@社員名 = appModel.shain.shainMei;
            kinmuhyoXML.勤務表.@所定日数 = kinmuhyo.syoteiNissu;
            kinmuhyoXML.勤務表.@作業日数 = kinmuhyo.sagyoNissu;
            kinmuhyoXML.勤務表.@欠勤日数 = kinmuhyo.kekkinNissu;
            kinmuhyoXML.勤務表.@実働時間合計 = kinmuhyo.jitsudoJikanGokei;
            var i:int=0;
            for (; !cursor.afterLast; cursor.moveNext()) {
                var kinmuhyoShosai:KinmuhyoShosai = KinmuhyoShosaiMapper.mapping(cursor.current);
                kinmuhyoXML.勤務表詳細[i] = <勤務表詳細/>;
                kinmuhyoXML.勤務表詳細[i].@日付 = DateUtils.formatYYMM(kinmuhyoShosai.hizuke);
                kinmuhyoXML.勤務表詳細[i].@休み区分 = kinmuhyoShosai.yasumiKubun;
                kinmuhyoXML.勤務表詳細[i].@始業時間 = kinmuhyoShosai.shigyoJikan;
                kinmuhyoXML.勤務表詳細[i].@始業時間値 = kinmuhyoShosai.shigyoJikanchi;
                kinmuhyoXML.勤務表詳細[i].@終了時間 = String(kinmuhyoShosai.syuryoJikan).replace(" ", "");
                kinmuhyoXML.勤務表詳細[i].@終了時間値 = kinmuhyoShosai.syuryoJikanchi;
                kinmuhyoXML.勤務表詳細[i].@休憩時間 = kinmuhyoShosai.kyukeiJikan;
                kinmuhyoXML.勤務表詳細[i].@実働時間 = kinmuhyoShosai.jitsudoJikan;
                kinmuhyoXML.勤務表詳細[i].@作業内容 = kinmuhyoShosai.sagyoNaiyo;
                i++;
            }
        }

        /** 勤務表XML出力 */
        private function writeKinmuhyoXML():void {
        	var kinmuhyo:Kinmuhyo = model.kinmuhyo;

            var sendFileName:String = kinmuhyo.nengetsu.replace("-", "") + "_勤務表_" + appModel.shain.shainMei + ".xml";
            var kinmuhyoXMLFile:File = File.userDirectory.resolvePath(Constants.PROJECT_PATH + File.separator + sendFileName);
            //var kinmuhyoXMLFile:File = File.createTempFile().resolvePath(sendFileName);
            Logger.log("送信用臨時ファイル：" + kinmuhyoXMLFile.nativePath);

            var outputString:String = '<?xml version="1.0" encoding="utf-8"?>\n';
            outputString += kinmuhyoXML.toXMLString();
            outputString = outputString.replace(/\n/g, File.lineEnding);
            stream = new FileStream();
            stream.open(kinmuhyoXMLFile, FileMode.WRITE);
            stream.writeUTFBytes(outputString);
            stream.close();

            appModel.file = kinmuhyoXMLFile;
        }

        /** 勤務表Zipファイルに圧縮 */
        private function zipKinmuhyo():void {
			// applicationModelのzipFileを利用し勤務表をzip化
			Zip.archive();
        }

		/** 勤務表を保存または送信可能な状態に更新 */
		private function updateKinmuhyoStatus():void {
			// 保存可能状態に更新
			view.currentState = "updateKinmuhyo";
			model.isPersisted = false;
		}

		/** 勤務表送信 */
		private function sendKinmuhyo():void {
			var event:ShinseiServiceEvent = new ShinseiServiceEvent(ShinseiServiceEvent.SEND_KINMUHYO, view);
			event.dispatch();
		}

		// LABEL FUNCTION -----------------------------------------------------------------------------
		/** 勤務表リストLabelFunction */
		public function shinseiListLabelFunction(item:Object):String {
			var nengetsu:String = Kinmuhyo(item).nengetsu;
			var code:String = Kinmuhyo(item).shinseiJokyo;
			return LabelUtil.nengetsuLabel(nengetsu)  + " " + ShinseiJokyoEnum.fromCode(code);
		}
		/** 休み区分LabelFuntion */
		public function yasumiKubunLabelFunction(item:Object, data:DataGridColumn):String {
			var value:String;
			// TODO コードを休み区分に変更
			var yasumiKubunAC:ArrayCollection = model.yasumiKubunAC as ArrayCollection;
			for each (var obj:Object in yasumiKubunAC) {
				if (obj.code == item.yasumiKubun || obj.value == item.yasumiKubun) {
					value = obj.value;
					break;
				}
			}

			return value;
		}
		/** 休憩時間LabelFunction */
		public function kyukeiJikanLabelFunction(item:Object, data:DataGridColumn):String {
			var result:String;
			if (item.kyukeiJikan != 0) {
				result = item.kyukeiJikan + " 時間";
			} else {
				result = "";
			}
			return result;
		}
	}
}