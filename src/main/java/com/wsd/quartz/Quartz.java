package com.wsd.quartz;

import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.stereotype.Component;

import static org.quartz.JobBuilder.newJob;
import static org.quartz.SimpleScheduleBuilder.simpleSchedule;
import static org.quartz.TriggerBuilder.newTrigger;

/**
 * Created by tm on 2018/8/6.
 */
@Component("quartz")
public class Quartz {

    public void start(){
    //创建scheduler
    try {
        Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();

        //定义一个Trigger
        Trigger trigger = newTrigger().withIdentity("trigger", "group") //定义name/group
                .startNow()//一旦加入scheduler，立即生效
                .withSchedule(simpleSchedule() //使用SimpleTrigger
                        .withIntervalInSeconds(1) //每隔一秒执行一次
                        .repeatForever()) //一直执行
                .build();


        //定义一个JobDetail
        JobDetail job = newJob(Job1.class) //定义Job类为HelloQuartz类，这是真正的执行逻辑所在
                .withIdentity("job", "group") //定义name/group
                .build();

        //加入这个调度
        scheduler.scheduleJob(job, trigger);

        //启动
        scheduler.start();

    } catch (SchedulerException e) {
        e.printStackTrace();
    }
}
}
