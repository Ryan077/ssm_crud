package com.xyz.crud.controller;

import com.github.pagehelper.PageInfo;
import com.xyz.crud.bean.Employee;
import com.xyz.crud.bean.Msg;
import com.xyz.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 控制Employee类的增删改查操作（create retrieve update delete）
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 保存员工，使用REST风格，GET表示查询，POST表示添加，PUT表示修改，DELETE表示删除
     *
     * 使用JSR303进行数据校验
     * 1. 导入 hibernate-validator 坐标
     * 2. 在 javabean 类上添加验证注释
     * 3. 在使用方法上 添加@Valid验证，最后参数上添加BindingResult返回结果
     *
     * @return
     */
    @RequestMapping(value = "/saveEmp", method = RequestMethod.POST)
    @ResponseBody
    // @Valid 用来验证数据合法性，BindingResult 是验证后返回的结果
    public Msg saveEmp(@Valid Employee employee, BindingResult bindingResult){

        if (bindingResult.hasErrors()){
            Map<String,String> errMap = new HashMap<>();
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError error : fieldErrors){
                System.out.println("错误的字段名：" + error.getField());
                System.out.println("错误信息：" + error.getDefaultMessage());
                errMap.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errMap",errMap);
        }else{
            // 验证的结果没有错误，才保存
            employeeService.save(employee);
            return Msg.success();
        }
    }

    /**
     * 批量删除Employee
     * @param ids 传递来的格式是 45,55,66,77
     * @return
     */
    @RequestMapping(value = "/deleteBatch/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteBatch(@PathVariable("ids") String ids){
        employeeService.deleteBatch(ids);
        return Msg.success();
    }

    /**
     * 根据id删除单个员工
     * @param id
     * @return
     */
    @RequestMapping(value = "/deleteById/{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteById(@PathVariable("id") Integer id){
        employeeService.deleteById(id);
        return Msg.success();
    }

    /**
     * 判断前端传递来的用户名是否重复
     * @param empName
     * @return
     */
    @RequestMapping("/checkEmpName")
    @ResponseBody
    public Msg checkEmpName(String empName){

        // 先在后台判断用户名是否符合规则
        String nameReg = "(^[a-zA-Z0-9_-]{5,16})|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(nameReg)){
            return Msg.fail().add("empName_msg","用户名不符合规则，需要5-16位英文大小写字母或下划线的组合，或者2-5个汉字的组合");
        }

        // 符合规则后再判断用户名是否重复
        boolean b = employeeService.checkEmpName(empName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("empName_msg","用户名重复");
        }
    }

    /**
     * 根据id查询Employee
     * @param id
     * @return
     */
    @RequestMapping(value = "/getEmp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpById(@PathVariable Integer id){
        Employee employee = employeeService.getEmpById(id);
        return Msg.success().add("emp",employee);
    }

    /**
     * 更新Employee
     * @param employee
     * @return
     */
    @RequestMapping(value = "/updateEmp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /**
     * 分页查询整页的数据
     * @param pageNo
     * @param pageSize
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody    // 不返回页面，直接返回json数据
    public Msg getEmpsWithAjax(@RequestParam( value = "pageNo", defaultValue = "1") String pageNo,
                               @RequestParam( value = "pageSize", defaultValue = "10") String pageSize){
        // 获得查询到的员工及分页信息
        PageInfo<Employee> pageInfo = employeeService.getEmpsByPage(pageNo, pageSize);
        return Msg.success().add("pageInfo",pageInfo);
    }

    /*@RequestMapping("/emps")
    @ResponseBody    // 不返回页面，直接返回json数据
    public PageInfo<Employee> getEmpsWithAjax(@RequestParam( value = "pageNo", defaultValue = "1") String pageNo,
                                              @RequestParam( value = "pageSize", defaultValue = "10") String pageSize, HttpServletRequest request){
        // 获得查询到的员工及分页信息
        PageInfo<Employee> pageInfo = employeeService.getEmpsByPage(pageNo, pageSize);
        return pageInfo;
    }*/

    /*@RequestMapping("/emps")
    public String getEmps(@RequestParam( value = "pageNo", defaultValue = "1") String pageNo,
                          @RequestParam( value = "pageSize", defaultValue = "10") String pageSize, HttpServletRequest request){
        // 获得查询到的员工及分页信息
        PageInfo<Employee> pageInfo = employeeService.getEmpsByPage(pageNo, pageSize);
        request.setAttribute("pageInfo",pageInfo);
        return "list";
    }*/

}
