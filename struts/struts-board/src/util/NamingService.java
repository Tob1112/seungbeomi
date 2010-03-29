package util;

import java.util.Hashtable;

public class NamingService{

	 private static NamingService ns = new NamingService();
	 //저장하기 위한 Hashtable을  멤버로 선언 name,value 쌍으로 존재
	 private Hashtable ht;

	 //NamingService 오라클 connection pool을 만들어 여기에 담아두도록 한다.
	 //private을 선언하여 한번만 생성되도록 한다
	 private NamingService(){
	      //ns=new NamingService();
		  ht=new Hashtable();
	 }
	 //다른 곳에서 참조하도록 한다
	 public static NamingService getInstance(){
		   return ns;
	 }

	 //조회하기 위한 메소드
	 public Object getAttribute(String name){
		   return ht.get(name);
	 }

	 //저장하기 위한 메소드 해쉬테이블에 name과 object를 넣어준다.
	 public void setAttribute(String name,Object o){
	    ht.put(name,o);
	 }
}