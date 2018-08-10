<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/8/8
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/tags" prefix="date"%>

<html>
<head>
    <title>任务列表</title>
    <link rel="stylesheet" type="text/css" href="../statics/plugins/boostrap/css/bootstrap.css"/>
    <style>
    </style>
</head>
<body>
    <%--列表样式--%>
    <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
            <caption>
                <button type="button" class="btn btn-primary" onclick="addJob()">新增</button>
            </caption>
            <thead>
                <tr class="active">
                    <th>序号</th>
                    <th>调度器名称</th>
                    <th>触发器组</th>
                    <th>触发器名称</th>
                    <th>作业组</th>
                    <th>作业名称</th>
                    <th>任务优先级</th>
                    <th>触发器状态</th>
                    <th>作业开始时间</th>
                    <th>作业结束时间</th>
                    <th>是否并发执行</th>
                    <th>作业类名</th>
                    <th>触发器执行次数</th>
                    <th>作业执行间隔</th>
                    <th>作业重复执行次数</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${ not empty jobs && jobs.size() > 0}">
                <c:forEach items="${jobs}" var="var" varStatus="status">
                    <tr>
                        <td>${status.index}</td>
                        <td>${var.schedName}</td>
                        <td>${var.triggerName}</td>
                        <td>${var.triggerGroup}</td>
                        <td>${var.jobName}</td>
                        <td>${var.jobGroup}</td>
                        <td>${var.prirority}</td>
                        <c:if test="${var.triggerState == 'ACQUIRED'}">
                            <td>正在执行</td>
                        </c:if>
                        <c:if test="${var.triggerState == 'WAITING'}">
                            <td>正在等待</td>
                        </c:if>
                        <c:if test="${var.triggerState == 'PAUSED'}">
                            <td>已暂停</td>
                        </c:if>
                        <c:if test="${var.triggerState == 'BLOCKED'}">
                            <td>发生阻塞</td>
                        </c:if>
                        <c:if test="${var.triggerState == 'ERROR'}">
                            <td>发生错误</td>
                        </c:if>
                        <td>
                            <date:date value ="${var.startTime} "/>
                        </td>
                        <td>${var.endTime}</td>
                        <td>${var.isNonconcurrent}</td>
                        <td>${var.jobClassName}</td>
                        <td>${var.timesTriggered}</td>
                        <td>${var.repeatInterval}</td>
                        <td>${var.repeatCount}</td>
                        <td>
                            <button type="button" class="btn btn-danger btn-xs" onclick="updateJob('${var.jobName}','${var.jobGroup}','${var.triggerName}','${var.triggerGroup}','${var.jobClassName}','${var.repeatInterval}')">修改</button>
                            <button type="button" class="btn btn-warning btn-xs" onclick="removeJob('${var.jobName}','${var.jobGroup}','${var.triggerName}','${var.triggerGroup}')">删除</button>
                            <button type="button" class="btn btn-info btn-xs" onclick="pauseJob('${var.jobName}','${var.jobGroup}')">暂停</button>
                            <button type="button" class="btn btn-success btn-xs" onclick="resumeJob('${var.jobName}','${var.jobGroup}')">开始</button>
                        </td>
                    </tr>
                </c:forEach>
                </c:when>
            </c:choose>
            </tbody>
        </table>
    </div>

    <%--模态框--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form class="form-horizontal" role="form" id="form">
                        <div class="form-group">
                            <label for="triggerGroup" class="col-sm-2 control-label">TriggerGroup</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="triggerGroup" id="triggerGroup" placeholder="请输入TriggerGroup名称">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="triggerName" class="col-sm-2 control-label">triggerName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="triggerName" id="triggerName" placeholder="请输入Trigger名称">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="jobGroup" class="col-sm-2 control-label">JobGroup</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="jobGroup" id="jobGroup" placeholder="请输入Job组名称">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="jobName" class="col-sm-2 control-label">jobName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="jobName" id="jobName" placeholder="请输入Job名称">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="jobClassName" class="col-sm-2 control-label">jobClassName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="jobClassName" id="jobClassName" placeholder="请输入Job类路径">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="jobInterval" class="col-sm-2 control-label">jobInterval</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="jobInterval" id="jobInterval" placeholder="请输入Job执行间隔">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        关闭
                    </button>
                    <button type="button" class="btn btn-primary" onclick="ok();">
                        提交
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="../statics/plugins/jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="../statics/plugins/boostrap/js/bootstrap.js"></script>
    <script>
        var url = "${pageContext.request.contextPath}"; //请求根路径
        var flag = false;  //addJob()事件选择标志
        var oldTriggerName = '';  //保存原始数据，用于更新
        var oldTriggerGroup = '';
        var oldJobName = '';
        var oldJobGroup = '';

        /*暂停*/
        function pauseJob(jobName, jobGroup) {
            $.post(url+'/quartz/pauseJob',{"jobName":jobName,"jobGroup":jobGroup},function (data) {
                var json = JSON.parse(data);
                console.log(json.status)
                if(json.status == 'success'){
                    window.location.reload();
                }else{
                    alert("操作失败，请刷新重试！");
                }
            })
        }

        /*重启*/
        function resumeJob(jobName, jobGroup) {
            $.post(url+'/quartz/resumeJob',{"jobName":jobName,"jobGroup":jobGroup},function (data) {
                var json = JSON.parse(data);
                console.log(json.status)
                if(json.status == 'success'){
                    window.location.reload();
                }else{
                    alert("操作失败，请刷新重试！");
                }
            })
        }

        /*删除*/
        function removeJob(jobName, jobGroup, triggerName, triggerGroup) {
            $.post(url+'/quartz/removeJob',{"jobName":jobName,"jobGroup":jobGroup,"triggerName":triggerName,"triggerGroup":triggerGroup},function (data) {
                var json = JSON.parse(data);
                console.log(json.status)
                if(json.status == 'success'){
                    window.location.reload();
                }else{
                    alert("操作失败，请刷新重试！");
                }
            })
        }

        /*添加*/
        function addJob(){
            $('#myModal').modal('show');  //显示弹框
            flag = false;  //修改标志
        }

        /*修改*/
        function updateJob(jobName, jobGroup, triggerName, triggerGroup, jobClassName, repeatInterval){
            /*表单赋值*/
            $('#jobName').val(jobName);
            $('#jobGroup').val(jobGroup);
            $('#triggerName').val(triggerName);
            $('#triggerGroup').val(triggerGroup);
            $('#jobClassName').val(jobClassName);
            $('#jobInterval').val(repeatInterval);
            $('#myModal').modal('show');
            flag = true;
            /*保存表单原始值*/
            oldTriggerName = triggerName;
            oldTriggerGroup = triggerGroup;
            oldJobName = jobName;
            oldJobGroup = jobGroup;
        }

        /*修改/添加提交*/
        function ok() {
            //执行添加
            if(!flag){
                $.post(url+'/quartz/addJob',$("#form").serialize(),function (data) {
                    var json = JSON.parse(data);
                    console.log(json.status)
                    if(json.status == 'success'){
                        window.location.reload();
                    }else{
                        alert("操作失败，请刷新重试！");
                    }
                })
            }
            //执行修改
            else{
                var jobName = $('#jobName').val();
                var jobGroup = $('#jobGroup').val();
                var triggerName = $('#triggerName').val();
                var triggerGroup = $('#triggerGroup').val();
                var jobClassName = $('#jobClassName').val();
                var jobInterval = $('#jobInterval').val();
                var params = {
                    "jobName": jobName,
                    "jobGroup": jobGroup,
                    "triggerName": triggerName,
                    "triggerGroup": triggerGroup,
                    "jobClassName": jobClassName,
                    "jobInterval": (jobInterval / 1000),
                    "oldTriggerName": oldTriggerName,
                    "oldTriggerGroup": oldTriggerGroup,
                    "oldJobName": oldJobName,
                    "oldJobGroup": oldJobGroup
                };
                console.log(params);
                $.post(url+'/quartz/updateJob',params,function (data) {
                    var json = JSON.parse(data);
                    console.log(json.status)
                    if(json.status == 'success'){
                        window.location.reload();
                    }else{
                        alert("操作失败，请刷新重试！");
                    }
                })
            }
        }
    </script>
</body>
</html>
