package
{
	import flash.display.Sprite;

	import mx.charts.BubbleChart;
	import mx.containers.HBox;
	import mx.containers.Panel;
	import mx.controls.Button;

	public class TestAppContainer extends Panel
	{
		public function TestAppContainer()
		{
			super();
			width = 400;
			height = 300;
		}

		override protected function createChildren():void {
			super.createChildren();

			title = "pnl";

			var spt:Sprite = new Sprite();
			titleBar.addChild(spt);

			var hb:HBox = new HBox();
			hb.setStyle("paddingRight", getStyle("paddingRight"));
			hb.setStyle("horizontalAlign", "right");
			hb.setStyle("verticalAlign", "middle");
			hb.width = this.width * 0.9;
			hb.height = 30;
			rawChildren.addChild(hb);

			var btn:Button = new Button()
			btn.label = "btn";
			hb.addChild(btn);
		}

	}
}