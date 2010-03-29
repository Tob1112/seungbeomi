/*=============================================================
(c) YEAR by AUTHOR
All rights reserved.
================================================================*/
using System;

namespace test{
   
   public class Test {
      private int sum;
      private int mul;
      
      public void SetValue(int x, int y) {
         sum = x + y;
         mul = x * y;
      }
      public int GetValue() {
         return sum + mul;
      }
   }
   
   public class Hello{
      public static void Main(){
         Test test = new Test();
         test.SetValue(3,5);
         int s = test.GetValue();
         Console.WriteLine("<<< " + s);
      }
   }
}
