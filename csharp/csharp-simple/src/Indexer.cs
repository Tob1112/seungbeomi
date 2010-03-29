/*================================================================================
Indexer
      클래스의 객체나 구조체의 변수를 배열형식으로 이용할 수 있게 해주는 기법이다.
===================================================================================*/
using System;
using System.IO;

namespace test{
   
   class FileByteArray {
      
      Stream stream;
      
      public FileByteArray(string fileName) {
         stream = new FileStream(fileName, FileMode.Open);
      }
      
      public void Close() {
         stream.Close();
         stream = null;
      }
      
      public byte this[long index] {
         get {
            byte[] buffer = new byte[1];
            stream.Seek(index, SeekOrigin.Begin);
            stream.Read(buffer, 0, 1);
            return buffer[0];
         } set {
            byte[] buffer = new byte[1] {value};
            stream.Seek(index, SeekOrigin.Begin);
            stream.Write(buffer, 0, 1);
         }  
      }
      
      public long Length {
         get {
            return stream.Seek(0, SeekOrigin.End);
         }
      }
   }
   
   class Indexer{
      public static void Main(string[] args){
         
         // Indexer Test.txt
         
         if (args.Length != 1) {
            Console.WriteLine("Usege : Indexer <filename>");
            return;
         }
         
         if (!System.IO.File.Exists(args[0])) {
            Console.WriteLine("File " + args[0] + " not found.");
            return;
         }
         
         FileByteArray file = new FileByteArray(args[0]);
         long len = file.Length;
         
         for(long i=0; i < len/2; i++) {
            byte t;
            t = file[i];
            file[i] = file[len-i-1];
            file[len-i-1] = t;
         }
         file.Close();
         Console.WriteLine("complete");
      }
   }
}
