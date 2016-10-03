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
    <script type="text/javascript" src="<%=path%>/static/js/ajaxfileupload.js" ></script>
    <script type="text/javascript" src="<%=path%>/static/js/common_util.js"></script>
    <script type="text/javascript" src="<%=path%>/static/js/page.js"></script>
    <script type="text/javascript" src="<%=path%>/static/js/convention.js"></script>
    <title>记录日记</title>
    <script type="text/javascript">
/*
各手机浏览器的状况:
火狐:<br>
聚焦时第一次计算的高度不对,再次点击时,高度才正确.
chrome自动就拥有这项功能:软键盘弹出时,自动上移
*/
        var uploadStatus=0;//初始状态:0;  选择了图片但未上传:1;  上传成功:2
        var ajaxUploadFile = function (self) {
            var $this=$(self);
            ajaxUploadFileCommon($this,$('textarea[name=content]'),function () {
                $('textarea[name=content]').focus();
            });
        };
        var adapterScrollTop=120;
        /*if(navigator.userAgent.indexOf("OppoBrowser")==-1){
            adapterScrollTop=170;
        }else{
            adapterScrollTop=160;
        }*/
        $(function () {
            //预览图片,没有真正上传
            com.whuang.hsj.previewLocalDiskImage($('#pic-file'), $("#previewImage"),function () {
                if(uploadStatus==0) {//只要ajax上传成功一次,则不再校验.防止点击了选择图片,忘了ajax上传图片的情况
                    uploadStatus=1;
                }
            },6/*单位是M*/);
            var footerIE8Throttle=throttle3(function () {
                if(getInner().height<=293) {//说明软键盘弹出来了
                    $(window).scrollTop(adapterScrollTop);
                }

            },200);//200
            $('textarea[name=content]').focus().focus(footerIE8Throttle).click(footerIE8Throttle);
            //加载完成之后,文本框聚焦,因为弹出软键盘有一定延迟,所以需要使用定时器
            setTimeout(function () {
                if(getInner().height<=293) {//说明软键盘弹出来了
                    $(window).scrollTop(adapterScrollTop);
                }
            },180);
        });
        var insertContent=function (txt) {
            var $textara=$('textarea[name=content]');
            insertAfterText($textara[0],"abc");
        }
    </script>
</head>
<body>
<jsp:include page="../public/top_admin.jsp"/>
<div class="tips">
    <span class="success">${message}</span>
</div>
<div>
    <h4>【${diary.createTime}】</h4>
    <a href="<%=path%>/diary/getCurrent">今日日记</a>&nbsp; <a href="<%=path%>/diary/list">日记列表</a>
    &nbsp;
    <div id="add_convention">

            <table style="width: 100%;" >
                <tr>
                    <td>
                        <form action="<%=path%>/diary/${diary.id}/update?targetView2=redirect%3A%2Fdiary%2F${diary.id}%2Fedit2" method="post">
                            <input type="hidden" name="testBoyId" value="${diary.id}">
                            <%--<input type="hidden" name="testcase" value="${test.testcase}">--%>
                            <textarea name="content" id="" style="width:100%"  rows="9"  placeholder="请填写日记" >${diary.content}</textarea>
                        </form>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom:20px">
                        <form action="/image/upload" id="pic-form"  method="post" enctype="multipart/form-data" >
                            <input type="file" id="pic-file" name="image223" > <br><br>
                            <input type="button" onclick="ajaxUploadFile(this)" id="upload_pic" value="ajax上传图片" > <span  id="upload_result_tip" ></span>
                        </form>
                        <br>
                        <input type="button" class="submit" value="添加">
                            <div style="width: 100%;" >
                            <img style="max-width: 100%;" alt="暂无预览图片" id="previewImage" >
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>

                        &nbsp;&nbsp;<a href="javascript:history.back();">返回</a>
                        &nbsp;&nbsp;<a href="javascript:selectAllTxt($('#add_convention textarea'));">全选</a>
                        &nbsp;&nbsp;<a href="javascript:enlargeTxt($('#add_convention textarea'));">放大</a>
                        &nbsp;&nbsp; <select  id="font_select">
                        <options>
                            <option value="red">红色</option>
                            <option value="bold">加粗</option>
                            <option value="red_bold">红色并加粗</option>
                        </options>
                    </select>
                        <input type="button" value="插入" onclick="insertContent()" >
                    </td>
                </tr>
            </table>

    </div>
    <p class="preview">${diary.formatContent}</p>
</div>
</body>
</html>