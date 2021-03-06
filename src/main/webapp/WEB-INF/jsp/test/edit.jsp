<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    if (path.equals("/")) {
        path = "";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=path%>/static/css/global.css">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1">
    <script type="text/javascript" src="<%=path%>/static/js/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="<%=path%>/static/js/common_util.js"></script>
    <script type="text/javascript" src="<%=path%>/static/js/convention.js"></script>
    <title>添加测试</title>
</head>
<body>
<h3>添加测试&nbsp;<a href="<%=path%>/test/list">列表</a>&nbsp; <a href="<%=path%>/search">首页</a></h3>
<div>
    <div>
        <form action="<%=path%>/test/${test.id}/update2" onsubmit="return test.checkAddTestForm(this)" method="post">
            <input type="hidden" name="id" value="${test.id}">
            <table style="width: 100%;" >
                <tr>
                    <td>
                        <textarea name="testcase" id="" style="width: 100%" rows="5">${test.testcase}</textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="submit" value="修改">&nbsp;&nbsp; <a href="javascript:history.back();">返回</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>