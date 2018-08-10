package com.wsd.dao;

import com.wsd.model.JobEntity;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by tm on 2018/7/19.
 * 定时任务dao接口
 */
@Repository
public interface QuartzDao {

    /**
     * 获取job列表
     * @return
     */
     List<JobEntity> queryJobs();
}
