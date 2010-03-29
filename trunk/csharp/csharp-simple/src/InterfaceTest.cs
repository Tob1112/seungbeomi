/*=============================================================
(c) YEAR by AUTHOR
All rights reserved.
================================================================*/
using System;

namespace test{
   
   interface IMyInterface {
      void IMethod();
   }
   
   class InterfaceTest:IMyInterface{
      public void IMethod(){
         Console.WriteLine("implements IMethod");
      }
      
      public static void Main(string[] args){
         InterfaceTest it = new InterfaceTest();
         it.IMethod();
         
         IMyInterface imc = it;
         imc.IMethod();
         
      }
   }
}
