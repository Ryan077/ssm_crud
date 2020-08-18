package com.xyz.crud.test;

import com.xyz.crud.bean.Department;
import com.xyz.crud.bean.Employee;
import com.xyz.crud.dao.DepartmentMapper;
import com.xyz.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void crudTest(){
//        departmentMapper.insertSelective(new Department(null,"开发部"));

//        employeeMapper.insertSelective(new Employee(null,"tom","M","tom123@qq.com",1));

        // 执行批量操作的SqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++){
            String uuidName = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null,uuidName,"M",uuidName+"@qq.com",1));
        }

        System.out.println("操作成功...");
    }

}
