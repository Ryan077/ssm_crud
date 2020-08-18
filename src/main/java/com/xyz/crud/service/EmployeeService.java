package com.xyz.crud.service;

import com.github.pagehelper.PageInfo;
import com.xyz.crud.bean.Employee;

import java.util.List;

public interface EmployeeService {
    /**
     * 查询所有的员工
     * @return
     */
    public List<Employee> getAllEmps();
    /**
     * 分页查询员工集合
     * @return
     */
    public PageInfo<Employee> getEmpsByPage(String pageNo, String pageSize);

    /**
     * 保存员工
     * @param employee
     */
    void save(Employee employee);

    /**
     * 判断用户名是否重复
     * @param empName
     * @return
     */
    boolean checkEmpName(String empName);

    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    Employee getEmpById(Integer id);

    /**
     * 更新Employee信息
     * @param employee
     */
    void updateEmp(Employee employee);

    /**
     * 根据id删除单个员工
     * @param id
     */
    void deleteById(Integer id);

    /**
     * 批量删除
     * @param ids
     */
    void deleteBatch(String ids);
}
