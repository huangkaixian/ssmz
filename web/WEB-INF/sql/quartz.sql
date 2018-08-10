/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : quartz

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2018-08-10 12:40:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'Quartz 实例名',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT 'Trigger名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT 'Trigger组',
  `BLOB_DATA` blob COMMENT '数据',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'Quartz 实例名',
  `CALENDAR_NAME` varchar(200) NOT NULL COMMENT '日历名称',
  `CALENDAR` blob NOT NULL COMMENT 'Blob calendar对象序列化后存入此字段',
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'Quartz 实例名',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT 'Trigger名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT 'Trigger组',
  `CRON_EXPRESSION` varchar(120) NOT NULL COMMENT 'Cron表达式',
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'Quartz 实例名',
  `ENTRY_ID` varchar(95) NOT NULL COMMENT 'InstanceId+系统当前毫秒',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT 'Trigger 名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT 'Trigger 组',
  `INSTANCE_NAME` varchar(200) NOT NULL COMMENT 'Quartz InstanceId 实例对象ID',
  `FIRED_TIME` bigint(13) NOT NULL COMMENT '触发时间（系统时间）',
  `SCHED_TIME` bigint(13) NOT NULL COMMENT '下次fire时间',
  `PRIORITY` int(11) NOT NULL COMMENT '任务优先级',
  `STATE` varchar(16) NOT NULL COMMENT '状态都是“ACQUIRED”',
  `JOB_NAME` varchar(200) DEFAULT NULL COMMENT 'jobdetail名字',
  `JOB_GROUP` varchar(200) DEFAULT NULL COMMENT 'Jobdetail 组',
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL COMMENT '同一任务是否并行执行',
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL COMMENT 'job是否恢复运行',
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
INSERT INTO `qrtz_fired_triggers` VALUES ('DefaultQuartzScheduler', 'NON_CLUSTERED1533631813333', 'trigger', 'group', 'NON_CLUSTERED', '1533631981466', '1533631982386', '5', 'ACQUIRED', null, null, '0', '0');
INSERT INTO `qrtz_fired_triggers` VALUES ('DefaultQuartzScheduler', 'NON_CLUSTERED1533631878265', 'tm_trigger', 'tm_trigger_group_name', 'NON_CLUSTERED', '1533631972741', '1533631973598', '5', 'ACQUIRED', null, null, '0', '0');

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'scheduler名称',
  `JOB_NAME` varchar(200) NOT NULL COMMENT 'job名称',
  `JOB_GROUP` varchar(200) NOT NULL COMMENT 'job数组组名称',
  `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT 'job描述',
  `JOB_CLASS_NAME` varchar(250) NOT NULL COMMENT 'job对应具体执行任务的类名',
  `IS_DURABLE` varchar(1) NOT NULL COMMENT '是否持久化',
  `IS_NONCONCURRENT` varchar(1) NOT NULL COMMENT '并发JOB @DisallowConcurrentExecution',
  `IS_UPDATE_DATA` varchar(1) NOT NULL COMMENT '持久jobDataMap@PersistJobDataAfterExecution',
  `REQUESTS_RECOVERY` varchar(1) NOT NULL COMMENT 'job是否恢复运行',
  `JOB_DATA` blob COMMENT 'Job的datamap里的数据',
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('quartzScheduler', '1', '1', null, 'com.wsd.quartz.Job2', '0', '0', '0', '0', 0x230D0A23467269204175672031302031313A31353A31302043535420323031380D0A);
INSERT INTO `qrtz_job_details` VALUES ('quartzScheduler', 'job', 'group', null, 'com.wsd.quartz.Job1', '0', '0', '0', '0', 0x230D0A23467269204175672031302031313A31303A34342043535420323031380D0A);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'Quartz 实例名',
  `LOCK_NAME` varchar(40) NOT NULL COMMENT '锁名称',
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('quartzScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'Quartz 实例名',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT 'Trigger 组',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'Quartz 实例名',
  `INSTANCE_NAME` varchar(200) NOT NULL COMMENT 'InstanceId',
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL COMMENT '最后一次检查时间',
  `CHECKIN_INTERVAL` bigint(13) NOT NULL COMMENT '检查周期',
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'Quartz 实例名',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT 'Trigger 名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT 'Trigger 组',
  `REPEAT_COUNT` bigint(7) NOT NULL COMMENT '重复执行次数',
  `REPEAT_INTERVAL` bigint(12) NOT NULL COMMENT '间隔时间',
  `TIMES_TRIGGERED` bigint(10) NOT NULL COMMENT '作业运行的次数',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------
INSERT INTO `qrtz_simple_triggers` VALUES ('quartzScheduler', '1', '1', '-1', '1000000', '1');
INSERT INTO `qrtz_simple_triggers` VALUES ('quartzScheduler', 'trigger', 'group', '-1', '1000', '721');

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'Quartz 实例名',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT 'Trigger 名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT 'Trigger 组	',
  `JOB_NAME` varchar(200) NOT NULL COMMENT 'Job 名称',
  `JOB_GROUP` varchar(200) NOT NULL COMMENT 'Job 组',
  `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT '描述',
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL COMMENT '下次触发时间 毫秒',
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL COMMENT '上次触发时间',
  `PRIORITY` int(11) DEFAULT NULL COMMENT '优先级',
  `TRIGGER_STATE` varchar(16) NOT NULL COMMENT '状态',
  `TRIGGER_TYPE` varchar(8) NOT NULL COMMENT '触发类型 cron ,simple,calendar',
  `START_TIME` bigint(13) NOT NULL COMMENT '开始运行时间',
  `END_TIME` bigint(13) DEFAULT NULL COMMENT '结束运行时间',
  `CALENDAR_NAME` varchar(200) DEFAULT NULL COMMENT '设置的calendar的名称',
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL COMMENT '-1:错过执行 0:正常',
  `JOB_DATA` blob COMMENT 'JOB的datamap,仓库ID存在此datamap里',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('quartzScheduler', '1', '1', '1', '1', null, '1533871910567', '1533870910567', '5', 'PAUSED', 'SIMPLE', '1533870910567', '0', null, '0', '');
INSERT INTO `qrtz_triggers` VALUES ('quartzScheduler', 'trigger', 'group', 'job', 'group', null, '1533871365214', '1533871364214', '5', 'PAUSED', 'SIMPLE', '1533870644214', '0', null, '0', '');
