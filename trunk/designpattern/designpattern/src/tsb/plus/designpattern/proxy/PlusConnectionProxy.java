package tsb.plus.designpattern.proxy;

import tsb.plus.designpattern.delegate.PlusDelegate;
import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

/**
 * 프록시패턴 : 어떤 객체에 대한 접근을 제어하기 위한 용도로 대리인이나 대변인에 해당하는 객체를 제공하는 패턴 
 * 프록시패턴을 이용하면 원격객체라든가 생성하기 힘든 객체, 
 * 보안이 중요한 객체와 같은 다른 객체에 대한 접근을 제어하는 대변자 객체를 만들 수 있다.
 * 
 * @author seungbeomi
 */
public class PlusConnectionProxy implements PlusConnection {

	private PlusConnection plusConnection;
	private PlusDelegate plusDelegate;

	public PlusConnectionProxy(PlusDelegate plusDelegate) {
		this.plusDelegate = plusDelegate;
	}

	@Override
	public Result send(Param param) {
		
		System.out.println("Proxy::Proxy 메소드 실행");
		
		if (plusConnection == null) {
			plusConnection = new PlusConnectionImpl(plusDelegate);
		}
		return plusConnection.send(param);
	}

}
