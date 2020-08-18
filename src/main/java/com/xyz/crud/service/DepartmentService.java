package com.xyz.crud.service;

import com.xyz.crud.bean.Department;

import java.util.List;

public interface DepartmentService {
    /**
     * 获取所有的部门
     * @return
     */
    public List<Department> getAllDepts();
}
