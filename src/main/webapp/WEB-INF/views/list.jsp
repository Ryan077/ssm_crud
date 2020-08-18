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
                <input type="button" class="btn btn-primary" value="新增"/>
                <input type="button" class="btn btn-danger" value="批量删除"/>
            </div>
        </div>
        <%-- 显示表格数据 --%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-striped table-hover">
                    <tr>
                        <th>
                            <input type="checkbox">
                        </th>
                        <th>#</th>
                        <th>Emp_Name</th>
                        <th>email</th>
                        <th>gender</th>
                        <th>dept_name</th>
                        <th>操作</th>
                    </tr>

                    <c:forEach items="${requestScope.pageInfo.list}" var="employee">
                        <tr>
                            <td><input type="checkbox"></td>
                            <td>${employee.empId}</td>
                            <td>${employee.empName}</td>
                            <td>${employee.email}</td>
                            <td>${employee.gender=="M"?"男":"女"}</td>
                            <td>${employee.department.deptName}</td>
                            <td>
                                <button class="btn btn-info">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                                </button>
                                <button class="btn btn-danger">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
        <%-- 显示分页信息 --%>
        <div class="row">
            <div class="col-md-5 col-md-offset-1">
                当前页面：第${requestScope.pageInfo.pageNum}页，总页数：${requestScope.pageInfo.pages}页，总记录数：${requestScope.pageInfo.total}条
            </div>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li>
                            <a href="emps?pageNo=1">
                                <span aria-hidden="true">首页</span>
                            </a>
                        </li>

                        <c:if test="${requestScope.pageInfo.hasPreviousPage}">
                            <li>
                                <a href="emps?pageNo=${requestScope.pageInfo.pageNum - 1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${requestScope.pageInfo.navigatepageNums}" var="pageNum" >
                            <%-- 判断遍历的页面是否是当前页 --%>
                            <c:if test="${ pageNum == requestScope.pageInfo.pageNum }">
                                <li class="active"><a href="emps?pageNo=${pageNum}">${pageNum}</a></li>
                            </c:if>
                            <c:if test="${ pageNum != requestScope.pageInfo.pageNum }">
                                <li><a href="emps?pageNo=${pageNum}">${pageNum}</a></li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${requestScope.pageInfo.hasNextPage}">
                            <li>
                                <a href="${requestScope.pageInfo.pageNum + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <li>
                            <a href="emps?pageNo=${requestScope.pageInfo.pages}">
                                <span aria-hidden="true">末页</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>




    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="static/js/jquery-1.11.3/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
