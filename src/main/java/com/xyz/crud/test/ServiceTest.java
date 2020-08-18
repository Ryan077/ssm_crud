package com.xyz.crud.test;

import com.github.pagehelper.PageInfo;
import com.xyz.crud.bean.Employee;
import com.xyz.crud.service.EmployeeService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * Service层测试
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class ServiceTest {

    @Autowired
    EmployeeService employeeService;

    @Test
    public void findAllEmpsTest(){
        List<Employee> allEmps = employeeService.getAllEmps();
        System.out.println(allEmps.size());
    }

    @Test
    public void pageInfoTest(){
        PageInfo<Employee> pageInfo = employeeService.getEmpsByPage("1", "10");
        System.out.println(pageInfo);
    }

}
