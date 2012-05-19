package intro;

public abstract class Duck {

	FlyBehavior flyBehavior;
	QuackBehavior quackBehavior;

	// 동적으로 행동을 지정
	public void setFlyBehavior(FlyBehavior flyBehavior) {
		this.flyBehavior = flyBehavior;
	}
	public void setQuackBehavior(QuackBehavior quackBehavior) {
		this.quackBehavior = quackBehavior;
	}

	public Duck() {}

	public abstract void display();

	public void performFly() {
		flyBehavior.fly();
	}

	public void performQuack() {
		quackBehavior.quack();
	}

	public void swim() {
		System.out.println("모든 오리는 물에 뜬다. 가짜오리도 물에 뜬다.");
	}
}
