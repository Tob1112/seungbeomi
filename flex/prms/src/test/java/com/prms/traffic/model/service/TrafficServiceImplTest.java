package com.prms.traffic.model.service;

import junit.framework.TestCase;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.prms.traffic.model.persistence.iface.TrafficExpensesTotalDao;
import com.prms.traffic.model.service.iface.TrafficService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:applicationContext-persist.xml"})
public class TrafficServiceImplTest extends TestCase {

    @Autowired
    private TrafficExpensesTotalDao dao;

    @Autowired
    private TrafficService service;
/*
    @Test
    public void testExestCurrentYM() {
    	String empNo = "R258";
        String ym = "200910";

        TrafficExpensesMonth trafficExpensesMonth = new TrafficExpensesMonth();
        trafficExpensesMonth.setEmpNo(empNo);
        trafficExpensesMonth.setYm(ym);

        int result = dao.existCurrentYM(trafficExpensesMonth);
        assertEquals(0, result);
    }
*/
/*
    @Test
    public void testGetTrafficTotalExpenses() {
        assertNotNull(dao);

        String empNo = "R258";
        String ym = "200910";

        TrafficExpensesMonth trafficExpensesMonth = new TrafficExpensesMonth();
        trafficExpensesMonth.setEmpNo(empNo);
        trafficExpensesMonth.setYm(ym);

        TrafficExpensesMonth result = (TrafficExpensesMonth)dao.getTotalTrafficFare(trafficExpensesMonth);
        System.out.println(result);
    }
*/
    @Test
    public void testGetTotalTrafficFare() {
    	assertNotNull(service);

    	String empNo = "R258";
    	String ym = "200910";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "200911";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "200912";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201001";
    	service.getTotalTrafficFare(empNo, ym);

        empNo = "R258";
    	ym = "201002";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201003";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201004";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201005";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201006";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201007";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201008";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201009";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201010";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201011";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201012";
    	service.getTotalTrafficFare(empNo, ym);

    	empNo = "R258";
    	ym = "201101";
    	service.getTotalTrafficFare(empNo, ym);

    }

    /*
    @Test
    public void testMakeStringYM() {
    	int year = 2009;
    	int month = 9;

    	TrafficServiceImpl target = new TrafficServiceImpl();
    	String result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2009;
    	month = 10;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2009;
    	month = 11;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2010;
    	month = 0;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2010;
    	month = 1;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2010;
    	month = 2;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2010;
    	month = 3;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2010;
    	month = 4;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2010;
    	month = 5;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2010;
    	month = 6;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2010;
    	month = 7;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2010;
    	month = 8;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2010;
    	month = 9;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);

    	year = 2010;
    	month = 10;
    	result = target.makeStringYM(year, month);
    	System.out.println("<<< result : " + result);
    }
    */
/*
    @Test
    public void testInitTrafficExpensesMonth() {
    	TrafficServiceImpl trafficServiceImpl = new TrafficServiceImpl();

    	TrafficExpensesMonth trafficExpensesMonth = new TrafficExpensesMonth();
		trafficExpensesMonth.setEmpNo("R258");
		trafficExpensesMonth.setYm("200910");

    	trafficServiceImpl.initTrafficExpensesMonth(trafficExpensesMonth);
    }
*/
}
