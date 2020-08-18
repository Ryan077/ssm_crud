package com.xyz.crud.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xyz.crud.bean.Employee;
import com.xyz.crud.bean.EmployeeExample;
import com.xyz.crud.dao.EmployeeMapper;
import com.xyz.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAllEmps() {
        return employeeMapper.selectByExample(null);
    }

    @Override
    public PageInfo<Employee> getEmpsByPage(String pageNo, String pageSize) {
        int pageNoInt = Integer.parseInt(pageNo);
        int pageSizeInt = Integer.parseInt(pageSize);
        // 启用分页插件
        PageHelper.startPage(pageNoInt,pageSizeInt);
        // 设置分页插件的查询排序规则
        PageHelper.orderBy("emp_id asc");
        // 查询所有员工
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        // 将分页的所有信息封装到pageInfo中，后面的数字控制分页条显示的数
        PageInfo<Employee> pageInfo = new PageInfo<>(employees,5);
        return pageInfo;
    }

    @Override
    public void save(Employee employee) {
        int i = employeeMapper.insertSelective(employee);
    }

    @Override
    public boolean checkEmpName(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        List<Employee> employees = employeeMapper.selectByExample(employeeExample);
        return employees.size() == 0;
    }

    @Override
    public Employee getEmpById(Integer id) {
        return employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    @Override
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    @Override
    public void deleteById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteBatch(String ids) {
        // 先将ids拆分成一个一个的数字
        String[] splitIds = ids.split(",");
        List<Integer> idsInt = new ArrayList<>();
        for (String id : splitIds){
            idsInt.add(Integer.parseInt(id));
        }
        EmployeeExample example = new EmployeeExample();
        example.createCriteria().andEmpIdIn(idsInt);
        employeeMapper.deleteByExample(example);
    }
}
