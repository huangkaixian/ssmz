package com.wsd.service.impl;

/**
 * Created by tm on 2018/8/9.
 * service接口
 */
public interface QuartzImpl {

    /**
     * 暂停job
     * @param jobName job名称
     * @param jobGroup  jog组
     */
    void pauseJob(String jobName,String jobGroup);

    /**
     * 恢复job
     * @param jobName job名称
     * @param jobGroup  jog组
     */
    void resumeJob(String jobName,String jobGroup);

    /**
     * 删除job
     * @param jobName  job名称
     * @param jobGroup  job组
     * @param triggerName  trigger名称
     * @param triggerGroup  trigger组
     */
    void removeJob(String jobName, String jobGroup, String triggerName, String triggerGroup);

    /**
     * 添加job
     * @param jobName  job名称
     * @param jobGroup  job组
     * @param triggerName  trigger名称
     * @param triggerGroup  trigger组
     * @param jobClassName  job类路径
     * @param time  job执行间隔时间
     */
    void addJob(String jobName, String jobGroup, String triggerName, String triggerGroup, String jobClassName, int time) throws ClassNotFoundException;

}
