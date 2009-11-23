package datagrid {
    import mx.controls.Label;
    import mx.controls.listClasses.*;

    public class UserLabelRendr3r extends Label {

        private const ADMIN_COLOR:uint = 0xFF6600;
        private const USER_COLOR:uint = 0x9B30FF;
        private const GEN_COLOR:uint = 0x8B8B00;

		override public function set data(data :Object):void{
			if(data.userName == "user" || data.userName == "admin" || data.userName == "gen")
				this.text = data.userName;
			else{
				this.text = "No_User"
				this.setStyle("color",0);
			}
		}
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            setStyle("color", getColor());// Set the font color based type of user
        }

        private function getColor():uint{
        	var col : uint;
        	switch(text){
        		case "user":
        					col= USER_COLOR;
        					break;
        		case "admin":
        					col= ADMIN_COLOR;
        					break;
        		case "gen":
        					col= GEN_COLOR;
        					break;
        	}
        	return col;
        }

    }
}
