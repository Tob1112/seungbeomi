package tsb.plus.designpattern.fw;

import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public interface PlusDelegate {

	Result run(Param param);
	
}
