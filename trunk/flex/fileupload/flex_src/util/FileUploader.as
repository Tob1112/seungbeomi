package util {
    import flash.events.DataEvent;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.net.FileReference;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;

    import mx.controls.Alert;
    import mx.controls.ProgressBar;

    public class FileUploader {

        //ファイルをアップロードしたりダウンロードしたりするクラス
        private var _fileRef:FileReference;

        public var fileUploadProgressBar:ProgressBar;

        public function FileUploader() {
        }

        public function upload():void {

            _fileRef = new FileReference();
            _fileRef.addEventListener(Event.SELECT, selectHandler);
            _fileRef.addEventListener(Event.COMPLETE, completeHandler);
            _fileRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadDataHandler);
            _fileRef.addEventListener(ProgressEvent.PROGRESS, fileUploadProgressHandler);
            //ファイル選択ダイアログを起動しましょう。
            _fileRef.browse();
        }

        private function fileUploadProgressHandler(event:ProgressEvent):void {
            fileUploadProgressBar.setProgress(event.bytesLoaded, event.bytesTotal);
        }

        //ファイル選択ダイアログでファイルを選択するとコールされます。
        private function selectHandler(event:Event):void {

            //ファイルデータ以外のリクエストパラメーター
            var params:URLVariables = new URLVariables();
            params.title = "なにかのファイルです〜";

            //アクションメソッド"upload"を指定、値は適当です。
            params.upload ="action_method";

            //リクエストオブジェクトを生成
            var request:URLRequest = new URLRequest("http://localhost:8080/fileupload/upload");
            request.method = URLRequestMethod.POST;
            request.data = params;

            //アップロード
            _fileRef.upload(request, "formFile");
        }

        private function completeHandler(e:Event):void {
            //このイベントだとサーバーの処理結果データが受け取れないんですよね〜
            //なので、DataEvent.UPLOAD_COMPLETE_DATAで処理結果判定します。
        }

        private function uploadDataHandler(event:DataEvent):void {
            var result:String = new String(event.data);

            if( result == "hoge" ) {
                Alert.show("アップロード成功です");
            } else {
                Alert.show("サーバー処理失敗\n\n理由 ： " + result);
            }
        }
    }
}
