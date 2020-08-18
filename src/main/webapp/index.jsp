<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    %>
    <base href="<%=basePath%>"/>
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
</head>
<body>

<%-- 新增页面的模态框 --%>
<div class="modal fade" tabindex="-1" role="dialog" id="addModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工添加</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">员工姓名:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName_add" name="empName" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add" class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="email_add" name="email" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别:</label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="radio_add1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="radio_add2" value="F"> 女
                            </label>
                    </div>
                    <div class="form-group">
                        <label for="deptSelect_add" class="col-sm-2 control-label">部门:</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="deptSelect_add" name="deptId">

                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveEmpBtn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<%-- 修改页面的模态框 --%>
<div class="modal fade" tabindex="-1" role="dialog" id="updateModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">员工姓名:</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_Update"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add" class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="email_update" name="email" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别:</label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="radio_update1" value="M" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="radio_update2" value="F"> 女
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="deptSelect_add" class="col-sm-2 control-label">部门:</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="deptSelect_update" name="deptId">
                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateEmpBtn">修改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<%--搭建显示页面--%>
<div class="container">
    <%-- 标题 --%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%-- 按钮 --%>
    <div class="row">
        <div class="col-md-2 col-md-offset-10">
            <input type="button" class="btn btn-primary" id="addEmpBtn" value="新增"/>
            <input type="button" class="btn btn-danger" id="deleteAllBtn" value="批量删除"/>
        </div>
    </div>
    <%-- 显示表格数据 --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped table-hover" id="empTable">
                <thead>
                    <tr>
                        <th>
                            <input id="checkAll" type="checkbox">
                        </th>
                        <th>#</th>
                        <th>Emp_Name</th>
                        <th>email</th>
                        <th>gender</th>
                        <th>dept_name</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%-- 显示分页信息 --%>
    <div class="row">
        <div class="col-md-5 col-md-offset-1" id="bottom_info">
            <%--当前页面：第${requestScope.pageInfo.pageNum}页，总页数：${requestScope.pageInfo.pages}页，总记录数：${requestScope.pageInfo.total}条--%>
                <%--当前页面：第XX页，总页数：XX页，总记录数：XX条--%>
        </div>
        <div class="col-md-6" id="bottom_nav">
            <nav aria-label="Page navigation">
                <ul class="pagination"></ul>
            </nav>
        </div>
    </div>
</div>

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="static/js/jquery-1.11.3/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<%-- 使用js解析json数据 --%>
<script>
    // 1. 页面加载完成以后，直接发送ajax请求，获取分页数据
    $(
        function () {
            to_page(1);
        }
    );

    var TotalPage;

    // 跳转到第几页的方法
    function to_page(pageNo) {
        $.ajax(
            {
                url: "emps",
                data: "pageNo="+ pageNo +"&pageSize=10",
                type: "post",
                success: function (data) {
                    // console.log(data);
                    // 2. 解析并显示员工信息
                    get_and_show_emp(data);
                    // 3. 解析并显示统计信息
                    get_page_info(data);
                    // 4. 解析并显示分页条信息
                    get_page_nav(data);
                }
            }
        );
    }

    // 获取并显示员工数据
    function get_and_show_emp(data){

        // 先清空以前绑定的元素
        $("#empTable tbody").empty();

        // 获取员工数据
        var emps = data.extend.pageInfo.list;

        TotalPage = data.extend.pageInfo.total;

        // console.log(emps);
        // 使用DOM动态添加元素
        $.each(emps,function (index,item) {
            /*console.log(index);
            console.log(item);*/
            var checkEle = $("<td><input class='checkbox-one' type='checkbox'></td>");
            var idEle = $("<td></td>").append(item.empId);
            var empNameEle = $("<td></td>").append(item.empName);
            var emailEle = $("<td></td>").append(item.email);
            var genderEle = $("<td></td>").append(item.gender == 'M'?'男':'女');
            var deptNameEle = $("<td></td>").append(item.department.deptName);
            var updateEle = $("<button></button>").addClass("btn btn-info edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("修改");
            // 给编辑按钮添加自定义属性，绑定当前行对应的id
            updateEle.attr("edit-id",item.empId);
            var deleteEle = $("<button></button>").addClass("btn btn-danger delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            // 给删除按钮绑定自定义属性，绑定id
            deleteEle.attr("delete-id",item.empId);
            var operateEle = $("<td></td>").append(updateEle).append(" ").append(deleteEle);
            // 使用jQuery创建一个tr元素，并在后面添加其他元素
            $("<tr></tr>").append(checkEle).append(idEle).append(empNameEle).append(emailEle).append(genderEle).append(deptNameEle).append(operateEle).appendTo($("#empTable tbody"));
        });
    }

    // 获取显示分页信息
    function get_page_info(data){

        // 先清空以前绑定的元素
        $("#bottom_info").empty();

        var pageInfo = data.extend.pageInfo;
        $("#bottom_info").append("当前页面：第"+ pageInfo.pageNum +"页，总页数："+ pageInfo.pages +"页，总记录数："+ pageInfo.total +"条");

        currentPage = pageInfo.pageNum;
    }

    // 获取显示导航条信息
    function get_page_nav(data) {

        // 先清空以前绑定的元素
        $("#bottom_nav nav ul").empty();

        var pageInfo = data.extend.pageInfo;

        var firstPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append($("<span></span>").append("首页")));
        var prePageLi = $("<li></li>").append($("<a></a>").attr("href","#").append($("<span></span>").append("&laquo;")));

        // 如果当前页是第一页
        if (pageInfo.pageNum <= 1){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(pageInfo.pageNum - 1);
            });
        }

        $("#bottom_nav nav ul").append(firstPageLi).append(prePageLi);

        $.each(pageInfo.navigatepageNums,function (index,pageNum) {
            var numLi = $("<li></li>").append($("<a></a>").attr("href","#").append(pageNum));

            // 给当前的页面添加active样式
            if (pageInfo.pageNum == pageNum){
                numLi.addClass("active");
            }

            // 点击当前页面，添加click事件，跳转页面
            numLi.click(function () {
                to_page(pageNum);
            });

            $("#bottom_nav nav ul").append(numLi);
        });

        var nextPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append($("<span></span>").append("&raquo;")));
        var lastPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append($("<span></span>").append("末页")));

        // 如果当前页是最后一页
        if (pageInfo.pageNum >= pageInfo.pages){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function () {
                to_page(pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(pageInfo.pages);
            });
        }

        $("#bottom_nav nav ul").append(nextPageLi).append(lastPageLi);

    }

    // 给添加按钮绑定click事件
    $("#addEmpBtn").click(function () {

        // 弹出模态框之前把以前表单的数据清理掉
       $("#addModal form")[0].reset();
       $("#addModal form").find("div").removeClass("has-error has-success");
       $("#addModal form .help-block").empty();

        // 弹出模态框之前，先发送ajax请求，查询数据库中的部门，并返回
        get_dept_add_select("#deptSelect_add");

        // 弹出模态框
        $('#addModal').modal({
            // 点击背景，模态框不消失
            backdrop: "static"
        });
    });

    // 添加部门信息的函数
    function get_dept_add_select(ele){
        $.ajax({
            url: "depts",
            method: "get",
            success: function (data) {
                // console.log(data);
                // 动态添加下拉列表元素
                // 清空以前添加的元素
                $(ele).empty();

                $.each(data.extend.depts,function (index,dept) {
                    // 此方法不传参数，可以使用this表示当前dept
                    var optionEle = $("<option></option>").append(dept.deptName).attr("value",this.deptId);
                    $(ele).append(optionEle);
                });
            }
        });
    }

    // 校验添加表单（前端校验）
    function check_add_form(){
        var empName = $("#empName_add").val();
        var email = $("#email_add").val();

        var nameCheckReg = /(^[a-zA-Z0-9_-]{5,16})|(^[\u2E80-\u9FFF]{2,5})/;
        if (!nameCheckReg.test(empName)){
            // alert("用户名不符合规则，需要5-16位英文大小写字母或下划线的组合，或者2-5个汉字的组合");
            is_check_success("#empName_add","error","用户名不符合规则，需要5-16位英文大小写字母或下划线的组合，或者2-5个汉字的组合");
            return false;
        }else{
            is_check_success("#empName_add","success","");
        }

        var emailCheckReg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!emailCheckReg.test(email)){
            // alert("邮箱不符合规则");
            is_check_success("#email_add","error","邮箱不符合规则");
            return false;
        }else{
            is_check_success("#email_add","success","");
        }

        return true;

    }

    // 校验结果正确错误添加相应的样式
    function is_check_success(ele,states,msg){

        // 每次调用前，先清除以前的状态
        $(ele).next("span").text("");
        $(ele).parent().removeClass("has-error has-success")

        if (states == "error"){
            $(ele).next("span").text(msg);
            $(ele).parent().addClass("has-error");
        }else if (states == "success"){
            $(ele).next("span").text(msg);
            $(ele).parent().addClass("has-success");
        }
    }

    // 填写新增表单名字后，当输入框的值发生改变，发送ajax请求到后端，校验用户名是否重复
    $("#empName_add").change(function () {

        var emp_name = $("#empName_add").val();

        $.ajax({
            url: "checkEmpName",
            type: "GET",
            data: "empName=" + emp_name,
            success: function (data) {
                // console.log(data);
                if (data.code == 100){
                    // 成功
                    is_check_success("#empName_add","success","用户名可用");
                    $("#saveEmpBtn").attr("gotoback","success");
                }else if (data.code == 200){
                    // 失败
                    is_check_success("#empName_add","error",data.extend.empName_msg);
                    $("#saveEmpBtn").attr("gotoback","error");
                }
            }
        });
    });

    // 点击保存按钮，添加员工信息到数据库
    $("#saveEmpBtn").click(function () {

        // 在将数据发送到数据库之前，先在前端校验
        /*if (!check_add_form()){
            return false;
        }*/

        // 后端用户名是否重复的save按钮的状态
        if ($(this).attr("gotoback") == "error"){
            return false;
        }
        // 发送ajax请求保存数据
        $.ajax({
            url: "saveEmp",
            method: "POST",
            data: $("#addModal form").serialize(),  // 此方法可以将表单中的数据转化为字符串
            success: function (data) {
                console.log(data);

                // 判断返回结果中，是成功还是失败
                if (data.code == 100){
                    // 保存成功后，关闭模态框
                    $("#addModal").modal("hide");
                    // 跳转到最后一页
                    to_page(TotalPage);
                }else {
                    // 保存失败，取得返回的失败信息
                    if (undefined != data.extend.errMap.empName){
                        // 用户名不符合规则
                        is_check_success("#empName_add","error",data.extend.errMap.empName);
                    }
                    if (undefined != data.extend.errMap.email){
                        // 邮箱不符合规则
                        is_check_success("#email_add","error",data.extend.errMap.email);
                    }
                }
            }
        });
    });

    // 给编辑按钮绑定click事件(jquery的live()方法已过时)
    $(document).on("click",".edit_btn",function () {
        // alert("edit");
        // 获取当前绑定的元素
        // console.log($($(this).parents("tr").children("td")[0]).text());
        // 获取当前编辑按钮父元素tr的第一个td（id）的值
        /*var tdEle = $(this).parents("tr").children("td")[0];
        var id = $(tdEle).text();
        console.log(id);*/

        // 1.获取绑定的id
        var id = $(this).attr("edit-id");

        // 2.发送ajax请求，查询出id对应的Employee并返回显示
        get_id_show_employee(id);
        // 3.查询出部门信息并显示
        get_dept_add_select("#deptSelect_update");
        // 4.弹出修改模态框
        $("#updateModal").modal({
            backdrop: "static"
        });

        // 在模态框的修改按钮上绑定id
        $("#updateEmpBtn").attr("update-id",id);

    })

    // 查询并显示员工信息
    function get_id_show_employee(id){
        $.ajax({
           url: "getEmp/" + id,
           type: "GET",
           success: function (data) {
                // console.log(data);
               // 将获得的数据回显给页面
               $("#empName_Update").text(data.extend.emp.empName);
               $("#email_update").val(data.extend.emp.email);
               $("#updateModal input[type=radio]").val([data.extend.emp.gender]);
               $("#updateModal select").val(data.extend.emp.deptId);
           }
        });
    }

    var currentPage;

    // 点击更新按钮，更新用户数据
    $("#updateEmpBtn").click(function () {

        var email = $("#email_update").val();
        // 1.先检查邮箱是否符合规则
        var emailCheckReg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!emailCheckReg.test(email)){
            // alert("邮箱不符合规则");
            is_check_success("#email_add","error","邮箱不符合规则");
            return false;
        }else{
            is_check_success("#email_add","success","");
        }

        var id = $("#updateEmpBtn").attr("update-id");

        // 2.发送ajax请求，更新员工
        $.ajax({
            url: "updateEmp/" + id,
            /*type: "POST",
            data: $("#updateModal form").serialize() + "&_method=PUT",*/
            type: "PUT",
            data: $("#updateModal form").serialize(),
            success: function (data) {
                console.log(data);
                // 关闭模态窗口
                $("#updateModal").modal("hide");
                // 跳转到修改的员工所在的页数
                to_page(currentPage);
            }
        });

    });

    // 单个删除，点击删除按钮，删除当前数据
    $(document).on("click",".delete_btn",function () {
        // 获取要删除的姓名
        var name = $($(this).parents("tr").find("td")[2]).text();
        var id = $(this).attr("delete-id");
        console.log(name);
        // 1.先弹出确认删除对话框
        if (confirm("您确定要删除【"+ name +"】吗？")){
            // 确认删除，发送ajax请求
            $.ajax({
                url: "deleteById/" + id,
                type: "DELETE",
                success: function (data) {
                    // console.log(data);
                    // 跳转到当前页
                    to_page(currentPage);
                }
            });
        }
    })

    // 点击复选框按钮，全选/全不选
    $("#checkAll").click(function () {
        // 检测当前checkbox的状态
        var status = $(this).prop("checked");
        // 获取所有的checkbox
        $(".checkbox-one").prop("checked",status);
    });

    // 点击每个复选框，当本页复选框全部选中时，checkAll复选框也选中(后加载的元素用on()函数)
    $(document).on("click",".checkbox-one",function () {
        // 判断当前选中的元素是否是10个
        var flag = $(".checkbox-one:checked").length == 10;
        $("#checkAll").prop("checked",flag);
    });

    // 点击批量删除按钮，批量删除Employee
    $("#deleteAllBtn").click(function () {
        var emp_names = "";
        var emp_ids = "";
        $.each($(".checkbox-one:checked"),function () {
            emp_names += $(this).parents("tr").children("td:eq(2)").text() + ",";
            emp_ids += $(this).parents("tr").children("td:eq(1)").text() + ",";
        })
        // 删除最后一个多余的“，”号
        emp_names = emp_names.substring(0,emp_names.length - 1);
        emp_ids = emp_ids.substring(0,emp_ids.length - 1);
        // console.log(emp_names);
        // console.log(emp_ids);

        if(confirm("您确定要批量删除【" + emp_names + "】吗？")){
            // 发送ajax请求，批量删除
            $.ajax({
                url: "deleteBatch/" + emp_ids,
                type: "DELETE",
                success: function (data) {
                    console.log(data);
                    $("#checkAll").prop("checked",false);
                    // 跳转到当前页面
                    to_page(currentPage);
                }
            });
        }
    });


</script>

</body>
</html>
