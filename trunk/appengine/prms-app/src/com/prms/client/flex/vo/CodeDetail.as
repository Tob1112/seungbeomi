package com.prms.client.flex.vo {

    /**
     * コード詳細
     * @auther 孫承範
     */
    [RemoteClass(alias="com.prms.client.server.model.CodeDetail")]
    [Bindable]
    public class CodeDetail {
        /** コード詳細 */
        public var codeDetail:String;

        /** コード名 */
        public var codeDetailName:String;

        /*
         * WorkPatternCodeRenderer(ComboBox)で
         * データ格納用
         */
        private var _label:String;
        private var _data:Object;

        public function get label():String {
            return codeDetailName;
        }

        public function get data():Object {
            return codeDetail;
        }
    }
}