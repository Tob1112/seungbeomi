package com.icontact.model.domain {

    [RemoteClass(alias="com.icontact.domain.Contact")]
    [Bindable]
    public class Contact {
    	public var id:int;
        public var name:String;
        public var phone:String;
        public var email:String;
        public var address:String;
        public var notes:String;
        public var status:String;

	    public function toString():void {
	    	trace("* Contact[id=" + this.id +
		    	", name=" + this.name +
		    	", phone=" + this.phone +
		    	", email=" + this.email +
		    	", address=" + this.address +
		    	", notes=" + this.notes +
		    	", status=" + this.status + "]");
	    }
    }

}
