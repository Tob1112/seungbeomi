/*=============================================================
(c) YEAR by AUTHOR
All rights reserved.
================================================================*/
using System;

namespace test{
   
   class Base {
      public void FuncA() {
         Console.WriteLine("Base.FuncA");
      }
      public virtual void FuncB(){
         Console.WriteLine("Base.FuncB");
      }
   }
   
   class Derived:Base {
      new public void FuncA() {
         Console.WriteLine("Derived.FuncA");
      }
      public override void FuncB(){
         Console.WriteLine("Derived.FuncB");
      }
   }
   
   class OverridingTest{
      public static void Main(string[] args){
         Derived d = new Derived();
         d.FuncA();   //Derived.FuncA
         d.FuncB();   //Derived.FuncB
         
         Base a = d;
         a.FuncA();   //Base.FuncA
         a.FuncB();   //Derived.FuncB
         
      }
   }
}
