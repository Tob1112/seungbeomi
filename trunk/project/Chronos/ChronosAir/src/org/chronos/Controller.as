package org.chronos
{
	import com.adobe.cairngorm.control.FrontController;
	import org.chronos.air.event.ApplicationEvent;
	import org.chronos.air.event.DAOEvent;
	import org.chronos.air.event.KinmuhyoEvent;
	import org.chronos.air.event.ShinseiServiceEvent;
	import org.chronos.air.model.ApplicationCommand;
	import org.chronos.air.model.DAOCommand;
	import org.chronos.air.model.KinmuhyoCommand;
	import org.chronos.air.model.ShinseiServiceCommand;
	import org.chronos.air.sample.PersonCommand;
	import org.chronos.air.sample.PersonEvent;

	public class Controller extends FrontController
	{
		public function Controller()
		{
			super();

			// アプリケーション初期化
			addCommand(ApplicationEvent.INITIALIZE_APPLICATION, ApplicationCommand);

			// DAO ---------------------------------------------------------------
			//addCommand(DAOEvent.OPEN_DATABASE, DAOCommand);	// database 解放
			addCommand(DAOEvent.SAVE_SHAIN, DAOCommand);		// ユーザー情報保存
			addCommand(DAOEvent.FIND_KINMUHYO_LIST, DAOCommand); // 勤務表リスト検索
			addCommand(DAOEvent.FIND_KINMUHYO, DAOCommand); 	// 勤務表検索
			addCommand(DAOEvent.FIND_MAX_NENGETSU, DAOCommand);	// 勤務表年月最大値取得
			addCommand(DAOEvent.FIND_JIKOKUHYO, DAOCommand);	// 時刻表検索(勤務表用)
			addCommand(DAOEvent.FIND_CODE_DATA, DAOCommand);	// コードデータ検索
			addCommand(DAOEvent.SAVE_KINMUHYO, DAOCommand);		// 勤務表保存
			addCommand(DAOEvent.FIND_KINMUHYO_SHOSAI, DAOCommand);	// 勤務表詳細検索

			// 勤務表 --------------------------------------------------------------
			addCommand(KinmuhyoEvent.FIND_MAX_NENGETSU, KinmuhyoCommand); // 勤務表年月最大値取得
			addCommand(KinmuhyoEvent.SAVE_KINMUHYO, KinmuhyoCommand);		// 勤務表保存
			addCommand(KinmuhyoEvent.FIND_KINMUHYO_SHOSAI, KinmuhyoCommand);	// 勤務表詳細検索

			// 申請サービス ---------------------------------------------------------
			addCommand(ShinseiServiceEvent.LOGIN, ShinseiServiceCommand);	// ログイン
			addCommand(ShinseiServiceEvent.LOGOUT, ShinseiServiceCommand);	// ログアウト
			addCommand(ShinseiServiceEvent.SEND_KINMUHYO, ShinseiServiceCommand);	// 勤務表送信

			// sample --------------------------------------------------------------
			addCommand(PersonEvent.SAY_HELLO, PersonCommand);
			addCommand(PersonEvent.FILE_UPLOAD, PersonCommand);

		}

	}
}