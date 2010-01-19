package org.flora.view {

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.containers.HBox;
	import mx.containers.Panel;
	import mx.controls.Alert;
	import mx.controls.Button;

	import org.flora.view.events.LeafStateChangeEvent;

	public class Leaf extends Panel {

		public static const MINIMIZED_HEIGHT:Number = 30;
		public static const WINDOW_STATE_DEFAULT:Number = -1;
		public static const WINDOW_STATE_MINIMIZED:Number = 0;
		public static const WINDOW_STATE_MAXIMIZED:Number = 1;
		public static const WINDOW_STATE_EXPANDED:Number = 2;

		private var headerDivider:Sprite;	//header구분선

		public var windowState:Number; // Corresponds to one of the WINDOW_STATE variables.
		private var controlsHolder:HBox;	// panel의 title부분 최대/최소 버튼등이 위치
		private var expandButton:Button;	// 메뉴확대
		private var minimizeRestoreButton:Button;	// 최소화/복구 버튼

		private var _showControls:Boolean;
		private var _showControlsChanged:Boolean;

		private var _maximize:Boolean;
		private var _maximizeChanged:Boolean;

		//--------------------------------------------------------------------------
		//	CONSTRUCTOR METHODS
		//--------------------------------------------------------------------------
		public function Leaf() {
			super();
			setStyle("titleStyleName", "leafTitle");
			windowState = WINDOW_STATE_DEFAULT;
			horizontalScrollPolicy = "off";
		}

		//--------------------------------------------------------------------------
		//	OVERRIDE METHODS 자식 컴포넌트 생성
		//--------------------------------------------------------------------------
		override protected function createChildren():void {
			trace("createChildren");
			super.createChildren();

			// title 구분선
			if (!headerDivider)	{
				headerDivider = new Sprite();
				titleBar.addChild(headerDivider);
			}

			// title control 버듵 박스
			if (!controlsHolder) {
				controlsHolder = new HBox();
				controlsHolder.setStyle("paddingRight", getStyle("paddingRight"));
				controlsHolder.setStyle("horizontalAlign", "right");
				controlsHolder.setStyle("verticalAlign", "middle");
				controlsHolder.setStyle("horizontalGap", 3);
				rawChildren.addChild(controlsHolder);
			}

			// 최소화/메뉴확장 버튼
			if(!expandButton) {
				expandButton = new Button();
				expandButton.width = 14;
				expandButton.height = 14;
				expandButton.styleName = "expandButton";
				controlsHolder.addChild(expandButton);
			}

			// 최대화 버튼
			if (!minimizeRestoreButton) {
				minimizeRestoreButton = new Button();
				minimizeRestoreButton.width = 14;
				minimizeRestoreButton.height = 14;
				minimizeRestoreButton.styleName = "minimizeRestoreButton";
				controlsHolder.addChild(minimizeRestoreButton);
			}

			addEventListeners();
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			trace("updateDisplayListener");
			super.updateDisplayList(unscaledWidth, unscaledHeight);

			// Shift the divider one pixel up if minimized so there isn't a gap between the left and right borders.
			// The bottom border is removed if minimized.
			var deltaY:Number = windowState == WINDOW_STATE_MINIMIZED ? -1 : 0;
			var graphics:Graphics = headerDivider.graphics;
			graphics.clear();
			graphics.lineStyle(1, getStyle("borderColor"));
			graphics.moveTo(1, titleBar.height + deltaY);
			graphics.lineTo(titleBar.width, titleBar.height + deltaY);

			controlsHolder.y = titleBar.y;
			controlsHolder.width = unscaledWidth;
			controlsHolder.height = titleBar.height;

			titleTextField.width = titleBar.width - getStyle("paddingLeft") - getStyle("paddingRight");
		}

		//--------------------------------------------------------------------------
		//	PRIVATE METHODS
		//--------------------------------------------------------------------------
		private function addEventListeners():void {
			trace("addEventListeners");
			titleBar.addEventListener(MouseEvent.CLICK, onClickTitleBar);

			expandButton.addEventListener(MouseEvent.CLICK, onClickExpandButton);
			minimizeRestoreButton.addEventListener(MouseEvent.CLICK, onClickMinimizeRestoreButton);

			//addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		// EVENT LISTENERS
		private function onClickTitleBar(event:MouseEvent):void	{
			trace("onClickTitleBar");

			// 최소화 되었을때 팝업 형식으로 내용리스트 표시
			if (windowState == WINDOW_STATE_MINIMIZED) {
				Alert.show("onClickTitleBar 팝업으로 내용표시!!");
			}

			if (windowState == WINDOW_STATE_MINIMIZED) {
				// Add the bottom border back in case we were minimized.
				setStyle("borderSides", "left top right bottom");
				onClickMinimizeRestoreButton();
			}
		}

		public function set showControls(value:Boolean):void {
			trace("showControls");
			_showControls = value;
			_showControlsChanged = true;
			invalidateProperties();
		}

		private function onClickMinimizeRestoreButton(event:MouseEvent=null):void {
			trace("onClickMinimizeRestoreButton");
			showControls = true;

			if (windowState == WINDOW_STATE_DEFAULT) {
				dispatchEvent(new LeafStateChangeEvent(LeafStateChangeEvent.MAXIMIZE));
				// Call after the event is dispatched so the old state is still available.
				maximize();
			} else {
				dispatchEvent(new LeafStateChangeEvent(LeafStateChangeEvent.RESTORE));
				// Set the state after the event is dispatched so the old state is still available.
				windowState = WINDOW_STATE_DEFAULT;
				minimizeRestoreButton.selected = false;
			}
		}

		private function onClickExpandButton(event:MouseEvent):void {
			trace("onClickExpandButton");
			dispatchEvent(new LeafStateChangeEvent(LeafStateChangeEvent.MINIMIZE));
			// Set the state after the event is dispatched so the old state is still available.
			minimize();
		}

		private function onMouseDown(event:Event):void {
			trace("onMouseDown");
			// Moves the pod to the top of the z-index.
			parent.setChildIndex(this, parent.numChildren - 1);
		}

		public function maximize():void	{
			trace("maximize");
			windowState = WINDOW_STATE_MAXIMIZED;
			_maximize = true;
			_maximizeChanged = true;
		}

		public function minimize():void {
			trace("minimize");
			// Hide the bottom border if minimized otherwise the headerDivider and bottom border will be staggered.
			setStyle("borderSides", "left top right");
			windowState = WINDOW_STATE_MINIMIZED;
			height = MINIMIZED_HEIGHT;
			showControls = false;
		}

	}
}