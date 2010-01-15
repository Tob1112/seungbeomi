package chapter01.section17
{
	import mx.containers.Canvas;
	import mx.core.UIComponent;

	public class TypeTest
	{
		public function TypeTest()
		{
			var uiComponent:UIComponent = new UIComponent();
			var canvas:Canvas = new Canvas();
			trace("uiComponent = UIComponent : " + (uiComponent is UIComponent));
			trace("uiComponent = Canva : " + (uiComponent is Canvas));
			trace("canvas = UIComponent : " + (canvas is UIComponent));
		}

	}
}