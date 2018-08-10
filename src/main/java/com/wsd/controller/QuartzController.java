package com.wsd.controller;

import com.alibaba.fastjson.JSONObject;
import com.wsd.service.QuartzService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by tm on 2018/7/19.
 * 定时任务controller类
 */
@Controller
@RequestMapping("/quartz")
public class QuartzController {

    @Autowired
    QuartzService qs;

    /**
     * job列表
     * @param model
     * @return
     */
    @RequestMapping(value = "/listJob")
    public String jobList(Model model){
        model.addAttribute("jobs",qs.queryJobs());
        return "listJob";
    }

    /**
     * 暂停job
     * @param jobName  job名称
     * @param jobGroup  job组
     * @return
     */
    @RequestMapping(value="/pauseJob",method=RequestMethod.POST)
    @ResponseBody
    public String pauseJob(@RequestParam("jobName") String jobName, @RequestParam("jobGroup") String jobGroup){
        JSONObject json = new JSONObject();
        System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxjob暂停了=>"+jobName+"<=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        if(StringUtils.isEmpty(jobName) || StringUtils.isEmpty(jobGroup)){
            json.put("status", "wrong");
        }else{
            qs.pauseJob(jobName, jobGroup);
            json.put("status", "success");
        }
        return json.toJSONString();
    }

    /**
     * 重启job
     * @param jobName  job名称
     * @param jobGroup  job组
     * @return
     */
    @RequestMapping(value="/resumeJob",method=RequestMethod.POST)
    @ResponseBody
    public String resumeJob(@RequestParam("jobName") String jobName, @RequestParam("jobGroup") String jobGroup){
        JSONObject json = new JSONObject();
        System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxjob重启了=>"+jobName+"<=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        if(StringUtils.isEmpty(jobName) || StringUtils.isEmpty(jobGroup)){
            json.put("status", "wrong");
        }else{
            qs.resumeJob(jobName, jobGroup);
            json.put("status", "success");
        }
        return json.toJSONString();
    }

    /**
     *  删除job
     * @param jobName
     * @param jobGroup
     * @param triggerName
     * @param triggerGroup
     * @return
     */
    @RequestMapping(value="/removeJob",method=RequestMethod.POST)
    @ResponseBody
    public String deleteJob(@RequestParam("jobName") String jobName,@RequestParam("jobGroup") String jobGroup,
                            @RequestParam("triggerName") String triggerName,@RequestParam("triggerGroup") String triggerGroup ){
        JSONObject json = new JSONObject();
        System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxjob删除了=>"+jobName+"<=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        if(StringUtils.isEmpty(jobName) || StringUtils.isEmpty(jobGroup) ||
                StringUtils.isEmpty(triggerName) || StringUtils.isEmpty(triggerGroup) ){
            json.put("status", "wrong");
        }else{
            qs.removeJob(jobName, jobGroup, triggerName, triggerGroup);
            json.put("status", "success");
        }
        return json.toJSONString();
    }

    /**
     *  新增job
     * @return
     */
    @RequestMapping(value="/addJob",method=RequestMethod.POST)
    @ResponseBody
    public String addJob(HttpServletRequest request){
        JSONObject json = new JSONObject();
        String triggerGroup = request.getParameter("triggerGroup");
        String triggerName = request.getParameter("triggerName");
        String jobGroup = request.getParameter("jobGroup");
        String jobName = request.getParameter("jobName");
        String jobClassName = request.getParameter("jobClassName");
        String jobInterval = request.getParameter("jobInterval");
        int interval = Integer.parseInt(jobInterval);

        System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxjob新增了=>"+jobName+"<=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        if(StringUtils.isEmpty(triggerGroup) || StringUtils.isEmpty(triggerName) ||
                StringUtils.isEmpty(jobGroup) || StringUtils.isEmpty(jobName) ||
                StringUtils.isEmpty(jobClassName) || StringUtils.isEmpty(jobInterval)){
            json.put("status", "wrong");
        }else{
            qs.addJob(jobName, jobGroup, triggerName, triggerGroup, jobClassName, interval);
            json.put("status", "success");
        }
        return json.toJSONString();
    }

    /**
     *  更新job
     * @return
     */
    @RequestMapping(value="/updateJob",method=RequestMethod.POST)
    @ResponseBody
    public String updateJob(@RequestParam("jobName") String jobName,@RequestParam("jobGroup") String jobGroup,
                            @RequestParam("triggerName") String triggerName,@RequestParam("triggerGroup") String triggerGroup,
                            @RequestParam("oldTriggerName") String oldTriggerName,@RequestParam("oldTriggerGroup") String oldTriggerGroup,
                            @RequestParam("oldJobName") String oldJobName,@RequestParam("oldJobGroup") String oldJobGroup,
                            @RequestParam("jobClassName") String jobClassName,@RequestParam("jobInterval") int jobInterval){
        JSONObject json = new JSONObject();

        System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxjob修改了=>"+jobName+"<=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

        if(StringUtils.isEmpty(oldTriggerName) || StringUtils.isEmpty(oldTriggerGroup) ||
                StringUtils.isEmpty(oldJobName) || StringUtils.isEmpty(oldJobGroup)||
                StringUtils.isEmpty(triggerGroup) || StringUtils.isEmpty(triggerName) ||
                StringUtils.isEmpty(jobGroup) || StringUtils.isEmpty(jobName) ||
                StringUtils.isEmpty(jobClassName) || StringUtils.isEmpty(jobInterval)){
            json.put("status", "wrong");
        }else{
            qs.removeJob(oldJobName, oldJobGroup, oldTriggerName, oldTriggerGroup);
            qs.addJob(jobName, jobGroup, triggerName, triggerGroup, jobClassName, jobInterval);
            json.put("status", "success");
        }
        return json.toJSONString();
    }
}
