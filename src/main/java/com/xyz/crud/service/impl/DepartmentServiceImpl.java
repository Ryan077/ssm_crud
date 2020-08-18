package com.xyz.crud.service.impl;

import com.xyz.crud.bean.Department;
import com.xyz.crud.dao.DepartmentMapper;
import com.xyz.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    /**
     * 获取所有的部门
     * @return
     */
    @Override
    public List<Department> getAllDepts() {
        return departmentMapper.selectByExample(null);
    }
}
