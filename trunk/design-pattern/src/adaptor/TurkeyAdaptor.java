package adaptor;

// Adaptor Pattern
// 		- 한 인터페이스를 다른 인터페이스로 변환해주는 역할
//
// Duck가 모자라서 Turkey객체를 사용해야하는 상황 - turkey를 Duck로 바꿔야겠지!!
// turkey가 가지고 있는 메소드를 duck이 가지고 있는 메소드로 변환한다.
// adaptor - 타겟인터페이스를 구현(duck)하며, adaptee instance(turkey) 가 들어있다.
public class TurkeyAdaptor implements Duck{	// turkey를 duck으로 사용

	Turkey turkey;

	public TurkeyAdaptor(Turkey turkey) {	//  원래형식(turkey)의 객체에 대한 레퍼런스가 필요
		this.turkey = turkey;
	}

	@Override
	public void quack() {
		turkey.gobble();
	}

	@Override
	public void fly() {
		for (int i=0; i < 5; i++) {
			turkey.fly();
		}
	}
}
