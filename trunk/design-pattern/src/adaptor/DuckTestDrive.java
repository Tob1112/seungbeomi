package adaptor;

public class DuckTestDrive {

	 public static void main(String[] args) {

		 MallardDuck duck = new MallardDuck();
		 WildTurkey turkey = new WildTurkey();
		 Duck turkeyAdaptor = new TurkeyAdaptor(turkey);	// turkey를 duck으로 보이게한다

		 System.out.println(" * The Turkey says...");
		 turkey.gobble();
		 turkey.fly();

		 System.out.println();
		 System.out.println(" * The Duck says...");
		 testDuck(duck);

		 System.out.println();
		 System.out.println(" * The TurkeyAdaptor says...");
		 // client에서는 중간에 어댑터가 있는지 전혀 알지 못한다.
		 testDuck(turkeyAdaptor);	//핵심 - duck을 가장한 turkey객체를 넘기자!!

	}

	private static void testDuck(Duck duck) {
		duck.quack();
		duck.fly();
	}
}
