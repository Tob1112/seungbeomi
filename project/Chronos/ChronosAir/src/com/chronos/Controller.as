package com.chronos
{
	import com.adobe.cairngorm.control.FrontController;
	import com.chronos.air.event.ApplicationEvent;
	import com.chronos.air.event.DAOEvent;
	import com.chronos.air.event.KinmuhyoEvent;
	import com.chronos.air.event.ShinseiServiceEvent;
	import com.chronos.air.model.ApplicationCommand;
	import com.chronos.air.model.DAOCommand;
	import com.chronos.air.model.KinmuhyoCommand;
	import com.chronos.air.model.ShinseiServiceCommand;
	import com.chronos.air.sample.PersonCommand;
	import com.chronos.air.sample.PersonEvent;

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
			addCommand(DAOEvent.FIND_KINMUHYO, DAOCommand); // 勤務表リスト検索
			addCommand(DAOEvent.FIND_MAX_NENGETSU, DAOCommand);	// 勤務表年月最大値取得
			addCommand(DAOEvent.FIND_JIKOKUHYO, DAOCommand);	// 時刻表検索(勤務表用)
			addCommand(DAOEvent.FIND_CODE_DATA, DAOCommand);	// コードデータ検索
			addCommand(DAOEvent.KINMUHYO_HOZON, DAOCommand);	// 勤務表保存

			// 勤務表 --------------------------------------------------------------
			addCommand(KinmuhyoEvent.GET_MAX_NENGETSU, KinmuhyoCommand); // 勤務表年月最大値取得
			addCommand(KinmuhyoEvent.KINMUHYO_HOZON, KinmuhyoCommand);		// 勤務表保存

			// 申請サービス ---------------------------------------------------------
			addCommand(ShinseiServiceEvent.LOGIN, ShinseiServiceCommand);	// ログイン
			addCommand(ShinseiServiceEvent.LOGOUT, ShinseiServiceCommand);	// ログアウト

			// sample --------------------------------------------------------------
			addCommand(PersonEvent.SAY_HELLO, PersonCommand);
			addCommand(PersonEvent.FILE_UPLOAD, PersonCommand);

		}

	}
}