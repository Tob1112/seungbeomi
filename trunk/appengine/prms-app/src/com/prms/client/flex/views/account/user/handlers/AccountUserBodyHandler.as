// Import necessary classes.
import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.prms.client.flex.business.events.account.AccountUserEvent;
import com.prms.client.flex.business.events.account.AccountUserInfoEvent;
import com.prms.client.flex.vo.AccountUser;

import mx.controls.Alert;
import mx.formatters.DateFormatter;
import mx.messaging.messages.RemotingMessage;

[Bindable] private var account:AccountUser;

private var userBodyDocument:AccountUserBody;

/**
 *
 */
private function creationCompleteHandler():void {

    userBodyDocument = AccountUserBody(document);
    registerClassAlias("flex.messaging.messages.RemotingMessage",RemotingMessage);

    presentPassword.addEventListener(KeyboardEvent.KEY_UP, handleValid);
    newPassword.addEventListener(KeyboardEvent.KEY_UP, handleValid);
    newPasswordConfirmed.addEventListener(KeyboardEvent.KEY_UP, handleValid);

    // 社員番号と社員名をサーバーから取得する
    var userInfoObj:AccountUserInfoEvent = new AccountUserInfoEvent(userBodyDocument);
    CairngormEventDispatcher.getInstance().dispatchEvent(userInfoObj);
}

/**
 *
 * @param eventObj
 * Event listener for the valid and invalid events.
 */
private function handleValid(eventObj:*):void {
    if (presentPassword.text != "" && newPassword.text != "" && newPasswordConfirmed.text != "") {
        // Enable Submit button.
        submitButton.enabled = true;
    }
}

/**
 * Submit form is everything is valid.
 */
private function clickAccountSubmitHandler():void {

    // 入力されたパスワードが４桁以上、８桁以下の場合
    if (newPassword.text.length >=  4 && newPassword.text.length <=  8)
    {
        // 入力された新たなパスワードが一致する場合
        if (newPassword.text == newPasswordConfirmed.text)
        {
            var account:AccountUser = new AccountUser();

            account.accountUserPassword = presentPassword.text;
            account.accountUserNewPassword = newPassword.text;

            var userObj:AccountUserEvent = new AccountUserEvent(account, userBodyDocument);
            CairngormEventDispatcher.getInstance().dispatchEvent(userObj);
        }
        // 入力された新たなパスワードが一致しない場合
        else
        {
            Alert.show("入力されたパスワードが一致しません。新しいパスワードを再入力してください。");
        }
    }
    // 桁数エラーの場合
    else
    {
        Alert.show("桁数エラーです。4～8字の半角英数字で入力してください。");
    }
}

