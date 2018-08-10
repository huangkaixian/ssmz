package com.wsd.service;

import com.wsd.dao.QuartzDao;
import com.wsd.model.JobEntity;
import com.wsd.service.impl.QuartzImpl;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.quartz.JobBuilder.newJob;
import static org.quartz.SimpleScheduleBuilder.simpleSchedule;
import static org.quartz.TriggerBuilder.newTrigger;

/**
 * Created by tm on 2018/7/19.
 * 定时任务service类
 */
@Service
public class QuartzService implements QuartzImpl {

    @Autowired
    Scheduler scheduler;  //注入scheduler,需要在spring-config.xml配置

    @Autowired
    QuartzDao ud;  //注入dao

    /**
     * 获取job列表
     * @return
     */
    public List<JobEntity> queryJobs(){
        return ud.queryJobs();
    }

    /**
     * 暂停job
     * @param jobName job名称
     * @param jobGroup  jog组
     */
    public void pauseJob(String jobName, String jobGroup) {
        try {
            scheduler.pauseJob(JobKey.jobKey(jobName, jobGroup));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    /**
     * 恢复job
     * @param jobName job名称
     * @param jobGroup  jog组
     */
    public void resumeJob(String jobName, String jobGroup) {
        try {
            scheduler.resumeJob(JobKey.jobKey(jobName, jobGroup));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除job
     * @param jobName  job名称
     * @param jobGroup  job组
     * @param triggerName  trigger名称
     * @param triggerGroup  trigger组
     */
    public void removeJob(String jobName, String jobGroup, String triggerName, String triggerGroup) {
        Scheduler sched = scheduler;
        try {
            // 停止触发器
            sched.pauseTrigger(TriggerKey.triggerKey(triggerName,
                    jobGroup));
            // 移除触发器
            sched.unscheduleJob(TriggerKey.triggerKey(triggerName,
                    jobGroup));
            // 删除任务
            sched.deleteJob(JobKey.jobKey(jobName, jobGroup));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    /**
     * 添加job
     * @param jobName  job名称
     * @param jobGroup  job组
     * @param triggerName  trigger名称
     * @param triggerGroup  trigger组
     * @param jobClassName  job类路径
     * @param time  job执行间隔时间
     */
    public void addJob(String jobName, String jobGroup, String triggerName, String triggerGroup, String jobClassName, int time){
        try {
            Scheduler  sd = scheduler;
            //Trigger与Job的关系为1:N
            //定义一个Trigger
            Trigger trigger = newTrigger().withIdentity(triggerName, triggerGroup) //定义trigger的name/group
                    .startNow()
                    .withSchedule(simpleSchedule()  //使用SimpleTrigger
                            .withIntervalInSeconds(time)
                            .repeatForever())
                    .build();

            //定义一个JobDetail
            Class jobClass = Class.forName(jobClassName);
            JobDetail job = newJob(jobClass)
                    .withIdentity(jobName, jobGroup) //定义job的name/group
                    .build();

            //加入这个调度
            sd.scheduleJob(job, trigger);
            sd.start();
        } catch (SchedulerException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

}
