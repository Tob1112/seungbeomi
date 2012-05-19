package tsb.plus.designpattern.delegate;

import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public interface PlusDelegate {

	Result send(Param param);
	
}
