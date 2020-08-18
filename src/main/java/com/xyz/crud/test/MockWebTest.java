package com.xyz.crud.test;

import com.github.pagehelper.PageInfo;
import com.xyz.crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 虚拟Web请求测试
 */
@RunWith(SpringJUnit4ClassRunner.class)
// 测试环境使用，用来表示测试环境使用的applicationContext是webApplicationContext类型的
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MockWebTest {

    // SpringMvc的IOC容器
    @Autowired
    private WebApplicationContext webApplicationContext;

    // 虚拟的MVC请求，获取到处理结果
    private MockMvc mockMvc;

    @Before
    public void getMockMvc(){
        // 构造MockMvc
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.webApplicationContext).build();
    }

    @Test
    public void getEmpsTest() throws Exception {
        // 获取模拟请求的结果
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps")
                .param("pageNo","9").param("pageSize","15")).andReturn();
        // 获取的结果中包含域中的数据，比如获取request域中的数据
        MockHttpServletRequest request = mvcResult.getRequest();
        PageInfo<Employee> pageInfo = (PageInfo<Employee>) request.getAttribute("pageInfo");

        System.out.println("当前页码：" + pageInfo.getPageNum());
        System.out.println("总页码：" + pageInfo.getPages());
        System.out.println("总记录数：" + pageInfo.getTotal());
        int[] nums = pageInfo.getNavigatepageNums();
        for (int num : nums) {
            System.out.print(num + " ");
        }
        System.out.println();
        List<Employee> list = pageInfo.getList();
        System.out.println(list);
    }

}
