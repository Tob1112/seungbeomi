package chapter03.section24
{
	import mx.containers.VBox;
	import mx.containers.utilityClasses.IConstraintLayout;
	import mx.core.UIComponent;

	public class ForceLayout extends VBox
	{
		public var gap:Number;

		public function ForceLayout()
		{
			super();
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			var yPos:Number = unscaledHeight;
			var child:UIComponent;
			var i:int = 0;

			while (i < this.numChildren) {
				child = UIComponent(getChildAt(i));
				yPos = yPos - child.height;

				if (child is IConstraintLayout) {
				//	if ((child as IConstraintLayout).isSelected) {
						yPos -= 20;
						child.move(child.x, yPos);
						yPos -= 20;
				//	} else {
				//		child.move(child.x, yPos);
				//	}
				} else {
				//	child.move(child.x, yPos);
				}

				yPos = yPos - gap;
				i++;
			}

			i = 0;
			var amountToCenter:Number = yPos / 2;

			while (i < this.numChildren) {
				getChildAt(i).y -= amountToCenter;
				i++;
			}
		}

	}
}