package handler
{
	import flash.events.MouseEvent;

	import mx.controls.Alert;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class MainHandler implements IMXMLObject
	{
		private var doc:main;
		private var isAppSettingMode:Boolean = false;
		private var isShowMemo:Boolean = false;

		public function initialized(document:Object, id:String):void {
           doc = document as main;
           doc.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(e:FlexEvent):void {
           	//終了 - メインに戻る
           	doc.btnReturnToMain.addEventListener(MouseEvent.CLICK, clickBtnReturnToMain);
           	//テストスタート
           	doc.btnTestStart.addEventListener(MouseEvent.CLICK,clickBtnTestStart);
           	//履歴
           	doc.btnHistory.addEventListener(MouseEvent.CLICK,clickBtnHistory);
           	//履歴を初期化
           	doc.btnInitHistory.addEventListener(MouseEvent.CLICK, clickBtnInitHistory);
			//履歴からメインに戻る
			doc.btnReturnToMainFromHistory.addEventListener(MouseEvent.CLICK, clickBtnReturnToMainFromHistory);
			//アプリケーション終了
			doc.btnClose.addEventListener(MouseEvent.CLICK, clickBtnClose);
			//メモ
			doc.btnMemo.addEventListener(MouseEvent.CLICK, clickBtnMemo);
			//前へ
			doc.btnPrev.addEventListener(MouseEvent.CLICK, clickBtnPrev);
			//次へ
			doc.btnNext.addEventListener(MouseEvent.CLICK, clickBtnNext);
			//チェックレビュー
			doc.btnCheckReview.addEventListener(MouseEvent.CLICK, clickBtnCheckReview);
			//試験を終了 - 結果画面表示
			doc.btnEndTestFromTest.addEventListener(MouseEvent.CLICK, clickBtnEndTestFromTest);
			//問題へ戻る
			doc.btnReturnToTest.addEventListener(MouseEvent.CLICK, clickBtnReturnToTest);
			//試験を終了 - 結果画面表示
			doc.btnEndTestFromCheckReview.addEventListener(MouseEvent.CLICK, clickBtnEndTestFromCheckReview);
			//結果画面から終了 - メイン画面表示
			doc.btnEndTestFromResult.addEventListener(MouseEvent.CLICK, clickBtnEndTestFromResult);

			//画面設定
		   	doc.viewStack.selectedChild = doc.mainView;
        }

		//終了 - メインに戻る
        private function clickBtnReturnToMain(e:MouseEvent):void {
			shoowMainView();
        }

        //テストスタート
        private function clickBtnTestStart(e:MouseEvent):void {
        	showTestView();
        }

        //履歴
        private function clickBtnHistory(e:MouseEvent):void {
			doc.currentState = "historyState";
			doc.viewStack.selectedChild = doc.historyView;
        }

		//履歴を初期化
        private function clickBtnInitHistory(e:MouseEvent):void {
			Alert.show("履歴を初期化");
        }

        //履歴からメインに戻る
		private function clickBtnReturnToMainFromHistory(e:MouseEvent):void {
			shoowMainView();
		}

		//アプリケーション終了
		private function clickBtnClose(e:MouseEvent):void {
			Alert.show("アプリケーション終了");
		}

		//メモ
		private function clickBtnMemo(e:MouseEvent):void {
			if (!isShowMemo) {
				doc.testView.memoVBox.height = 100;
				isShowMemo = true;
			} else {
				doc.testView.memoVBox.height = 0;
				isShowMemo = false;
			}
		}

		// 前へ
		private function clickBtnPrev(e:MouseEvent):void {
			Alert.show("前の問題");
		}

		// 次へ
		private function clickBtnNext(e:MouseEvent):void {
			Alert.show("次の問題");
		}

		//問題一覧
		private function clickBtnCheckReview(e:MouseEvent):void {
			doc.currentState = "checkReviewState";
			doc.pnl.title = "ITパスポート問題集 チェックリスト";
			doc.viewStack.selectedChild = doc.checkReviewView;
		}

		//試験を終了 - 結果画面表示
		private function clickBtnEndTestFromTest(e:MouseEvent):void {
			showResultView();
		}

		//問題へ戻る
		private function clickBtnReturnToTest(e:MouseEvent):void {
			showTestView();
		}

		//試験を終了 - 結果画面表示
		private function clickBtnEndTestFromCheckReview(e:MouseEvent):void {
			showResultView();
		}

		//結果画面から終了 - メイン画面表示
		private function clickBtnEndTestFromResult(e:MouseEvent):void {
			shoowMainView();
		}

		//メイン画面表示
		private function shoowMainView():void {
			doc.currentState = "";
			doc.pnl.title = "ITパスポート問題集";
			doc.viewStack.selectedChild = doc.mainView;
		}

		//結果画面表示
		private function showResultView():void {
			doc.currentState = "resultState";
			doc.pnl.title = "ITパスポート問題集 テスト結果";
			doc.viewStack.selectedChild = doc.virtualResultView;
		}

		//テスト画面表示
		private function showTestView():void {
			doc.currentState = "testState";
        	doc.pnl.title = "ITパスポート問題集 テスト中";
        	doc.viewStack.selectedChild = doc.testView;
		}

	}
}