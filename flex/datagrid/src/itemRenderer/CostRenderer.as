package itemRenderer
{
	import flash.display.Graphics;

	import mx.containers.Canvas;

	public class CostRenderer extends Canvas
	{
		override public function set data(value:Object):void {
			super.data = value;
			if (value != null && value.cost != null) {
				this.invalidateDisplayList();
			}
		}

		override public function get data():Object {
			return super.data.cost;
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaleHeight:Number):void {
			var g:Graphics = this.graphics;

			if (this.data.cost == 200) {
				g.beginFill(0x0000ff);
				g.drawRect(0,0,unscaledWidth,unscaleHeight);

			} else {
				g.clear();
			}
		}

	}
}