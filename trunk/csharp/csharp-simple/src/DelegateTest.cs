/*=============================================================
(c) YEAR by AUTHOR
All rights reserved.
================================================================*/

namespace test{
   
   delegate void SimpleDelegate1();
   delegate void SimpleDelegate2(int i);
   
   class AType {
      public void F1(){
         System.Console.WriteLine("AType.F1");
      }
      public void F2(int x) {
         System.Console.WriteLine("AType.F2 x = " + x);
      }
   }
   
   class DelegateTest{
      public static void Main(string[] args){
         AType atype = new AType();
         
         SimpleDelegate1 s1 = new SimpleDelegate1(atype.F1);
         SimpleDelegate2 s2 = new SimpleDelegate2(atype.F2);
         
         s1();
         s2(1234);
         
      }
   }
}
