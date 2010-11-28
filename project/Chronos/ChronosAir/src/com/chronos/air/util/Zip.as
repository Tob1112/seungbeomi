package com.chronos.air.util
{
	import com.chronos.Constants;
	import com.chronos.air.common.MessageId;
	import com.chronos.air.common.Messages;
	import com.chronos.air.model.ApplicationModel;

	import lib.deng.fzip.FZip;

	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	public class Zip {

		[Bindable] private static var appModel:ApplicationModel = ApplicationModel.getInstance();
		private static var fileRef:FileReference;

		// zip ファイルを作成する。
        public static function archive():void {
            var outputStream:FileStream;
            var outputFile:File;
            var outputFileName:String;

            try {
                var zip:FZip = new FZip();
                var file:File = appModel.file;
                var zipFile:File
                outputStream = new FileStream();

				if (!file.isDirectory && file.name.charAt(0) != "." && file.extension == "xml") {
	                // zipファイルインスタンス生成
					var bytes:ByteArray = new ByteArray();
                    var inputStream:FileStream = new FileStream();
                    inputStream.open(file, FileMode.READ);
                    inputStream.readBytes(bytes,0,file.size);
                    inputStream.close();
                    // zip ファイル書き込み
                    zip.addFile(file.name, bytes);

					// TODO ファイル名変更
					//outputFileName = file.name.replace(".xml", ".zip");
					outputFileName = file.name.substring(0,6) + "-KINMUHYO.zip";
	                outputFile = File.userDirectory.resolvePath(Constants.PROJECT_PATH + File.separator + outputFileName);
	                outputStream.open(outputFile, FileMode.WRITE);
	                zip.serialize(outputStream);
	                outputStream.close();
	                Logger.log(outputFile.nativePath + "に圧縮されました。");

					zipFile = File.userDirectory.resolvePath(outputFile.nativePath);
					appModel.file = zipFile;

				} else {
					Messages.showError(MessageId.DO_NOT_ARCHIVE_ERROR);
				}
            } catch (e:Error) {
                e.getStackTrace();
            } finally {
            }
        }

	}
}