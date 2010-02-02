package com.prms.client.flex.util
{
    import flash.system.Capabilities;

    /**
     * layoutサイズ設定
     * @author developer002
     */
    public class LayoutSizeUtil
    {
        /** コンテンツ 幅 */
        static private var _contentWidth:Number = 0;
        /** コンテンツ 縦 */
        static private var _contentHeight:Number = 0;

        /**
         * 画面の最大水平解像度を求める
         * @return 最大水平解像度
         */
        public static function screenWidth():Number{
            return flash.system.Capabilities.screenResolutionX;
        }

        /**
         * 画面の最大垂直解像度を求める
         * @return 最大垂直解像度
         */
        public static function screenHeight():Number{
            return flash.system.Capabilities.screenResolutionY;
        }

        /**
         * ユーザレイアウト画面以外は使わないようにすること!!!
         * ユーザ画面のメニューの幅を求める
         * @param width コンポーネントの幅
         * @return メニューの幅
         */
        public static function layoutMenuWidth(width:Number):Number{
            return width * 0.98;
        }

        /**
         * ユーザレイアウト画面以外は使わないようにすること!!!
         * ユーザ画面のメニューの縦を求める
         * @param height コンポーネントの縦
         * @return メニューの縦
         */
        public static function layoutMenuHeight(height:Number):Number{
            return height * 0.06;
        }

        /**
         * ユーザレイアウト画面以外は使わないようにすること!!!
         * ユーザ画面のコンテンツの幅を求める
         * @param width コンポーネントの幅
         * @return コンテンツの幅
         */
        public static function layoutContentWidth(width:Number):Number{
            _contentWidth = width * 0.98;
            return _contentWidth;
        }

        /**
         * ユーザレイアウト画面以外は使わないようにすること!!!
         * ユーザ画面のコンテンツの縦を求める
         * @param height コンポーネントの縦
         * @return コンテンツの縦
         */
        public static function layoutContentHeight(height:Number):Number{
            _contentHeight = height * 0.90;
            return _contentHeight;
        }

        /**
         * モジュールの幅を求める
         * @return ジュールの幅
         */
        public static function moduleWidth():Number{
            return _contentWidth;
        }

        /**
         * モジュールの縦を求める
         * @return モジュールの縦
         */
        public static function moduleHeight():Number{
            return _contentHeight;
        }

        /**
         * コンテンツの幅を求める
         * @return コンテンツの幅
         */
        public static function moduleContentWidth():Number{
            return _contentWidth * 0.98;
        }

        /**
         * コンテンツの縦を求める
         * @return コンテンツの縦
         */
        public static function moduleContentHeight():Number{
            return _contentHeight * 0.98;
        }
    }
}

