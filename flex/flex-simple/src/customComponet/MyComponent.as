package customComponet {

	import flash.display.Graphics;
	import flash.display.Sprite;

	import mx.containers.HBox;
	import mx.containers.Panel;
	import mx.controls.Alert;
	import mx.controls.Button;

	public class MyComponent extends Panel {

		private var headerDivider:Sprite;
		private var controlsHolder:HBox;

		private var minimizeButton:Button;
		private var maximizeRestoreButton:Button;


        public function MyComponent() {
            super();
            setStyle("color", "#ff00ff");
        }

        override protected function createChildren():void {
            super.createChildren();

            if (!headerDivider) {
                headerDivider = new Sprite();
                titleBar.addChild(headerDivider);
            }

            if (!controlsHolder) {
                controlsHolder = new HBox();
                //controlsHolder.setStyle("paddingRight", getstyle("paddingRight"));
                controlsHolder.setStyle("paddingRight", 10);
                controlsHolder.setStyle("horizontalAlign", "right");
                controlsHolder.setStyle("verticalAlign", "middle");
                controlsHolder.setStyle("horizontalGap", 3);
                rawChildren.addChild(controlsHolder);

            }

            if (!minimizeButton) {
                minimizeButton = new Button();
                minimizeButton.width = 14;
                minimizeButton.height = 14;
                minimizeButton.styleName = "minimizeButton";
                controlsHolder.addChild(minimizeButton);
            }

            if (!maximizeRestoreButton) {
                maximizeRestoreButton = new Button();
                maximizeRestoreButton.width = 14;
                maximizeRestoreButton.height = 14;
                maximizeRestoreButton.styleName = "maximizeRestoreButton";
                controlsHolder.addChild(maximizeRestoreButton);
            }

            addEventListeners();
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            var graphics:Graphics = headerDivider.graphics;
            graphics.clear();
            graphics.lineStyle(1, getStyle("borderColor"));
            graphics.moveTo(1, titleBar.height);
            graphics.lineTo(titleBar.width, titleBar.height);

            controlsHolder.y = titleBar.y;
            controlsHolder.width = unscaledWidth;
            controlsHolder.height = titleBar.height;

            //titleTextField.width = titleBar.width - getStyle("paddingLeft") - getStyle("paddingRight");
            titleTextField.width = titleBar.width - 20;

        }

        private function addEventListeners():void {

        }
	}

}