package tsb.plus.designpattern.proxy;

import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public interface PlusConnection {

	Result send(Param param);
	
}
