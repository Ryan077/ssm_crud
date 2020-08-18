package com.xyz.crud.controller;

import com.xyz.crud.bean.Department;
import com.xyz.crud.bean.Msg;
import com.xyz.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理与部门相关请求的控制器
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    /**
     * 查询所有部门信息
     * @return 通用的返回类
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getAllDepts(){
        List<Department> allDepts = departmentService.getAllDepts();
        return Msg.success().add("depts",allDepts);
    }

}
