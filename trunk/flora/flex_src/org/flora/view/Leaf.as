package org.flora.view {

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.containers.HBox;
	import mx.containers.Panel;
	import mx.controls.Button;

	import org.flora.view.events.LeafStateChangeEvent;

	public class Leaf extends Panel {

		public static const MINIMIZED_HEIGHT:Number = 30;
		public static const WINDOW_STATE_DEFAULT:Number = -1;
		public static const WINDOW_STATE_MINIMIZED:Number = 0;
		public static const WINDOW_STATE_MAXIMIZED:Number = 1;

		private var headerDivider:Sprite;

		public var windowState:Number; // Corresponds to one of the WINDOW_STATE variables.
		private var controlsHolder:HBox;
		private var minimizeButton:Button;
		private var maximizeRestoreButton:Button;

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
		//	OVERRIDE METHODS
		//--------------------------------------------------------------------------
		override protected function createChildren():void {
			trace("createChildren");
			super.createChildren();

			if (!headerDivider)	{
				headerDivider = new Sprite();
				titleBar.addChild(headerDivider);
			}

			if (!controlsHolder) {
				controlsHolder = new HBox();
				controlsHolder.setStyle("paddingRight", getStyle("paddingRight"));
				controlsHolder.setStyle("horizontalAlign", "right");
				controlsHolder.setStyle("verticalAlign", "middle");
				controlsHolder.setStyle("horizontalGap", 3);
				rawChildren.addChild(controlsHolder);
			}

			if(!minimizeButton) {
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

			minimizeButton.addEventListener(MouseEvent.CLICK, onClickMinimizeButton);
			maximizeRestoreButton.addEventListener(MouseEvent.CLICK, onClickMaximizeRestoreButton);

			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		// EVENT LISTENERS
		private function onClickTitleBar(event:MouseEvent):void	{
			trace("onClickTitleBar");
			if (windowState == WINDOW_STATE_MINIMIZED) {
				// Add the bottom border back in case we were minimized.
				setStyle("borderSides", "left top right bottom");
				onClickMaximizeRestoreButton();
			}
		}

		public function set showControls(value:Boolean):void {
			trace("showControls");
			_showControls = value;
			_showControlsChanged = true;
			invalidateProperties();
		}

		private function onClickMaximizeRestoreButton(event:MouseEvent=null):void {
			trace("onClickMaximizeRestoreButton");
			showControls = true;

			if (windowState == WINDOW_STATE_DEFAULT) {
				dispatchEvent(new LeafStateChangeEvent(LeafStateChangeEvent.MAXIMIZE));
				// Call after the event is dispatched so the old state is still available.
				maximize();
			} else {
				dispatchEvent(new LeafStateChangeEvent(LeafStateChangeEvent.RESTORE));
				// Set the state after the event is dispatched so the old state is still available.
				windowState = WINDOW_STATE_DEFAULT;
				maximizeRestoreButton.selected = false;
			}
		}

		private function onClickMinimizeButton(event:MouseEvent):void {
			trace("onClickMinimizeButton");
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