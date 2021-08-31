<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 小强
  Date: 2021/8/30 0030
  Time: 20:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>UserPage</title>

    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12" align="center;">
            <h2>用户列表</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2 offset-md-10">
            <button class="btn btn-primary btn-sm " data-toggle="modal" data-target="#addUserModal">添加</button>
        </div>
        <%--搜索框--%>
        <form class="form-inline" action="${pageContext.request.contextPath}/user/queryAll" method="post">
            <div class="form-group" style="float: right;display: flex">
                <input type="text" class="form-control mr-5" placeholder="用户名" name="name"/>
                <input type="text" class="form-control" placeholder="密码" name="password"/>
                <span class="input-group-btn">
                    <button type="submit" class="btn btn-info btn-search">搜索</button>
                </span>
            </div>
        </form>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>姓名</th>
                    <th>密码</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="user">
                    <tr>
                        <th>${user.id}</th>
                        <th>${user.name}</th>
                        <th>${user.password}</th>
                        <th>
                            <a onclick="query(${user.id})" class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                修改
                            </a>
                            <a onclick="dodelete(${user.id})" class="btn btn-danger btn-sm"
                               href="javascript:void(0);">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </a>
                        </th>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <%--分页导航--%>
    <div class="row">
        <div class="col-md-6">
            第${pageInfo.pageNum}页，共${pageInfo.pages}页，共${pageInfo.total}条记录
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul class="pagination pagination-sm">
                    <li class="page-item"><a class="page-link"
                                             href="${pageContext.request.contextPath}/user/queryAll?page=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li class="page-item"><a class="page-link"
                                                 href="${pageContext.request.contextPath}/user/queryAll?page=${pageInfo.pageNum-1}">上一页</a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                        <c:if test="${page==pageInfo.pageNum}">
                            <li class="page-item active"><a class="page-link" href="#">${page}</a></li>
                        </c:if>
                        <c:if test="${page!=pageInfo.pageNum}">
                            <li class="page-item"><a class="page-link"
                                                     href="${pageContext.request.contextPath}/user/queryAll?page=${page}">${page}</a>
                            </li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li class="page-item"><a class="page-link"
                                                 href="${pageContext.request.contextPath}/user/queryAll?page=${pageInfo.pageNum+1}">下一页</a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link"
                                             href="${pageContext.request.contextPath}/user/queryAll?page=${pageInfo.pages}">末页</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <!-- 模态框示例（Modal） -->
    <form method="post" action="${pageContext.request.contextPath}/user/insert" class="form-horizontal" role="form"
          id="form_data" style="margin: 20px;">
        <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="myModalLabel">
                            添加用户
                        </h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="user_name" class="col-sm-3 control-label">用户名</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="name" value="" id="user_name"
                                           placeholder="用户名" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="password" class="col-sm-3 control-label">密码</label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" name="password" value="" id="password"
                                           placeholder="密码" required>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            添加
                        </button>
                        <span id="tip"> </span>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
    </form>

    <%--修改模态框--%>
    <form method="post" action="${pageContext.request.contextPath}/user/update" class="form-horizontal" role="form"
          id="form_data2" style="margin: 20px;">
        <div class="modal fade" id="updateUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="myModalLabel1">
                            修改用户
                        </h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="upid" class="col-sm-3 control-label">ID</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="id" value="" id="upid" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="upname" class="col-sm-3 control-label">用户名</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="name" value="" id="upname">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="uppassword" class="col-sm-3 control-label">密码</label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" name="password" value="" id="uppassword"
                                    >
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            修改
                        </button>
                        <span id="tip2"> </span>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
    </form>
</div>

<script type="text/javascript">

    /*删除确认操作*/
    function dodelete(id,page){
        var flag = confirm("确定要删除该用户吗？");
        if(flag){
            window.location.href="${pageContext.request.contextPath}/user/deleteById?id=" + id+"&page=" + page;
        }
    }


    /*查询要修改的数据显示到模态框中*/
    function query(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/user/toUpdate",
            async: true,
            type: "GET",
            data: {
                "id": id
            },
            // 成功后开启模态框
            success: function (data) {
                $("#upid").val(data.id);
                $("#upname").val(data.name);
                $("#uppassword").val(data.password);
                $("#updateUserModal").modal('show');
                console.log(data);

            },
            error: function () {
                alert("请求失败");
            },
            dataType: "json"
        });
    }


</script>
</body>
</html>
