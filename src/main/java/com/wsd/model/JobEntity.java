package com.wsd.model;

import org.springframework.stereotype.Component;

/**
 * Created by tm on 2018/8/8.
 * job业务实体类
 */
@Component("jobEntity")
public class JobEntity {
    private String schedName;
    private String triggerName;
    private String triggerGroup;
    private String jobName;
    private String jobGroup;
    private  Long nextFireTime;
    private  Long prevFireTime;
    private  Integer prirority;
    private String triggerState;
    private  Long startTime;
    private  Long endTime;
    private  Short misfireInstr;
    private String isNonconcurrent;
    private String jobClassName;
    private  Long timesTriggered;
    private  Long repeatInterval;
    private  Long repeatCount;

    public String getSchedName() {
        return schedName;
    }

    public void setSchedName(String schedName) {
        this.schedName = schedName;
    }

    public String getTriggerName() {
        return triggerName;
    }

    public void setTriggerName(String triggerName) {
        this.triggerName = triggerName;
    }

    public String getTriggerGroup() {
        return triggerGroup;
    }

    public void setTriggerGroup(String triggerGroup) {
        this.triggerGroup = triggerGroup;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getJobGroup() {
        return jobGroup;
    }

    public void setJobGroup(String jobGroup) {
        this.jobGroup = jobGroup;
    }

    public Long getNextFireTime() {
        return nextFireTime;
    }

    public void setNextFireTime(Long nextFireTime) {
        this.nextFireTime = nextFireTime;
    }

    public Long getPrevFireTime() {
        return prevFireTime;
    }

    public void setPrevFireTime(Long prevFireTime) {
        this.prevFireTime = prevFireTime;
    }

    public Integer getPrirority() {
        return prirority;
    }

    public void setPrirority(Integer prirority) {
        this.prirority = prirority;
    }

    public String getTriggerState() {
        return triggerState;
    }

    public void setTriggerState(String triggerState) {
        this.triggerState = triggerState;
    }

    public Long getStartTime() {
        return startTime;
    }

    public void setStartTime(Long startTime) {
        this.startTime = startTime;
    }

    public Long getEndTime() {
        return endTime;
    }

    public void setEndTime(Long endTime) {
        this.endTime = endTime;
    }

    public Short getMisfireInstr() {
        return misfireInstr;
    }

    public void setMisfireInstr(Short misfireInstr) {
        this.misfireInstr = misfireInstr;
    }

    public String getIsNonconcurrent() {
        return isNonconcurrent;
    }

    public void setIsNonconcurrent(String isNonconcurrent) {
        this.isNonconcurrent = isNonconcurrent;
    }

    public String getJobClassName() {
        return jobClassName;
    }

    public void setJobClassName(String jobClassName) {
        this.jobClassName = jobClassName;
    }

    public Long getTimesTriggered() {
        return timesTriggered;
    }

    public void setTimesTriggered(Long timesTriggered) {
        this.timesTriggered = timesTriggered;
    }

    public Long getRepeatInterval() {
        return repeatInterval;
    }

    public void setRepeatInterval(Long repeatInterval) {
        this.repeatInterval = repeatInterval;
    }

    public Long getRepeatCount() {
        return repeatCount;
    }

    public void setRepeatCount(Long repeatCount) {
        this.repeatCount = repeatCount;
    }

    public JobEntity(String schedName, String triggerName, String triggerGroup, String jobName, String jobGroup, Long nextFireTime, Long prevFireTime, Integer prirority, String triggerState, Long startTime, Long endTime, Short misfireInstr, String isNonconcurrent, String jobClassName, Long timesTriggered, Long repeatInterval, Long repeatCount) {
        this.schedName = schedName;
        this.triggerName = triggerName;
        this.triggerGroup = triggerGroup;
        this.jobName = jobName;
        this.jobGroup = jobGroup;
        this.nextFireTime = nextFireTime;
        this.prevFireTime = prevFireTime;
        this.prirority = prirority;
        this.triggerState = triggerState;
        this.startTime = startTime;
        this.endTime = endTime;
        this.misfireInstr = misfireInstr;
        this.isNonconcurrent = isNonconcurrent;
        this.jobClassName = jobClassName;
        this.timesTriggered = timesTriggered;
        this.repeatInterval = repeatInterval;
        this.repeatCount = repeatCount;
    }

    public JobEntity() {
    }

    @Override
    public String toString() {
        return "JobEntity{" +
                "schedName='" + schedName + '\'' +
                ", triggerName='" + triggerName + '\'' +
                ", triggerGroup='" + triggerGroup + '\'' +
                ", jobName='" + jobName + '\'' +
                ", jobGroup='" + jobGroup + '\'' +
                ", nextFireTime=" + nextFireTime +
                ", prevFireTime=" + prevFireTime +
                ", prirority=" + prirority +
                ", triggerState='" + triggerState + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", misfireInstr=" + misfireInstr +
                ", isNonconcurrent='" + isNonconcurrent + '\'' +
                ", jobClassName='" + jobClassName + '\'' +
                ", timesTriggered=" + timesTriggered +
                ", repeatInterval=" + repeatInterval +
                ", repeatCount=" + repeatCount +
                '}';
    }
}
