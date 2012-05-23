package tsb.plus.designpattern.factory;

import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public abstract class PlusServiceInvoker {

	public abstract Result invoke(Param param);
	
}
