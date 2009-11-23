package datagrid
{
    import mx.controls.DataGrid;
    import flash.display.Shape;
    import mx.core.FlexShape;
    import flash.display.Graphics;
    import flash.display.Sprite;
    import mx.rpc.events.AbstractEvent;
    import mx.collections.ArrayCollection;
    import flash.events.Event;

    public class CustomRowColorDG extends DataGrid
    {
        private var _rowColorFunction:Function;

        public function CustomRowColorDataGrid()
        {
//            super();
        }

        public function set rowColorFunction(f:Function):void
        {
            this._rowColorFunction = f;
        }

        public function get rowColorFunction():Function
        {
            return this._rowColorFunction;
        }



        private var displayWidth:Number; // I wish this was protected, or internal so I didn't have to recalculate it myself.
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            if (displayWidth != unscaledWidth - viewMetrics.right - viewMetrics.left)
            {
                displayWidth = unscaledWidth - viewMetrics.right - viewMetrics.left;
            }
        }


        override protected function drawRowBackground(s:Sprite, rowIndex:int,
                                                y:Number, height:Number, color:uint, dataIndex:int):void
        {
            if( this.rowColorFunction != null )
            {
                if( dataIndex < (this.dataProvider as ArrayCollection).length )
                {
                    var item:Object = (this.dataProvider as ArrayCollection).getItemAt(dataIndex);
                    color = this.rowColorFunction.call(this, item, color);
                }
            }

            super.drawRowBackground(s, rowIndex, y, height, color, dataIndex);
        }


    }
}