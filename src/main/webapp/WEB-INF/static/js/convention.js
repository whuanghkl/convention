/**
 * Created by Administrator on 2015/12/27.
 */
var server_url = "http://" + location.host//+"/convention";
$(function () {
    $('.test-list li img[data-id]').click(function () {
        var $progress = $('img.progress');
        var $imgDetail = $(this);
        var offset = $imgDetail.offset();


        var $next = $imgDetail.next();
        var detail = $next.next();
        //console.log(detail);
        var id = $imgDetail.data('id');
        if (detail.length === 0) {
            $progress.css('top', offset.top + 'px');
            $progress.css('left', offset.left + 'px');
            $progress.show();
            $next.after('<div id="answer_' + id + '"  ></div>');
            ajaxHtml(server_url + "/test/" + id + "?targetView=test/detail_common&random22=" + Math.random()/*+"&sort="+newsSort*/,
                $('#answer_' + id), null, function () {
                    $progress.hide('normal');
                });//page.js
        } else {
            $('#answer_' + id).toggle('toggleClass');
        }

    });
    //add answer
    var $add_convention = $('#add_convention');
    $add_convention.find('.btn').click(function () {
        var answer = $add_convention.find('textarea').val();
        if (answer) {
            return true;
        } else {
            alert("请输入内容");
            return false;
        }
    });
    var $test_detail = $('.test-detail');
    var $titleSpan = $test_detail.find('>span');
    $test_detail.find('>img').click(function () {
        $titleSpan.toggle('toggleClass');
    });
    $titleSpan.click(function () {
        $titleSpan.hide('normal');
    })
});//onload
var deleteConvention = function (conventionId) {
    var isDel = confirm("确定要删除么");
    //alert(conventionId+":"+isDel)
    if (isDel) {
        var options = {
            url: server_url + "/convention/" + conventionId + "/delete2/json",
            type: "POST",
            dataType: 'json',
            success: function (json2) {
                if (json2.result) {
                    $('li.answer-list[data-id=' + conventionId + ']').html('');
                } else {
                    alert("失败")
                }
            },
            error: function (er) {
                console.log(er)
            }
        };
        $.ajax(options);
    }
};
var test = {};
test.query = function () {
    var $form = $('#form_page');
    $form.action = server_url + "/test/list";
    $form.submit();
};
test.checkAddTestForm = function (form) {
    var $ta = $(form).find('textarea[name=testcase]');
    if ($ta.val()) {
        return true;
    } else {
        alert("请输入");
        return false;
    }
};
var selectAllTxt = function ($txt) {
    $txt.select();
};
var enlargeTxt = function ($txt) {
    var cols = $txt.attr('cols');
    var rows = $txt.attr('rows');
    $txt.attr('cols', (Number(cols) + 8));
    $txt.attr('rows', (Number(rows) + 3));
};
test.list_menu = function (imgSelf, testId) {
    //alert(getInner().width)
    console.log(testId);
    var $menu = $('#list-menu_' + testId);
    if ($menu && $menu.length) {
        $menu.toggle('toggleClass');
    } else {
        var $self = $(imgSelf);
        var offset2 = $self.offset();
        var left = Number(offset2.left) + 20;
        var delta = left + 50 - getInner().width;
        if (delta > 0) {
            left = left - delta;
        }
        var html = '<ul id="list-menu_' + testId + '" class="list-menu" style="top: ' + (Number(offset2.top))
            + 'px;left: ' + left + 'px;">' +
            '<li> <a href="' + server_url + '/test/' + testId + '/edit?targetView=test/edit">修改</a> </li>' +
            '<li> <a href="' + server_url + '/test/' + testId + '/delete" onclick="return confirm(\'确认删除吗\')">删除</a> </li>' +
            '<li> <a href="' + server_url + '/convention/add_answer?testBoyId=' + testId + '">添加答案</a> </li>' +
            '</ul>';

        $('body div.draft').append(html);
    }

};
var crlf = '\r\n';
var enedit4copy = function (conventionId) {
    console.log(conventionId);
    $conventionDiv = $('#answer-detail_' + conventionId);
    var $textarea = $conventionDiv.find('>textarea');
    if ($textarea.length == 0) {
        console.log('create textarea');
        var content = $conventionDiv.html();
        $conventionDiv.data("content", content);
        $conventionDiv.html('<textarea   cols="40" rows="5"  >' + content.replace(/<br>/g, crlf) + '</textarea>')
    }
    if ($textarea.length == 0) {
        $textarea = $conventionDiv.find('>textarea');
    }
    $textarea.select();
};
var deedit4copy = function (conventionId) {
    $conventionDiv = $('#answer-detail_' + conventionId);
    var $textarea = $conventionDiv.find('>textarea');
    if ($textarea.length == 1) {
        $conventionDiv.html($conventionDiv.data("content"));
    }
};