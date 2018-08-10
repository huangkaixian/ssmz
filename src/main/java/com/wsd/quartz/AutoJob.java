package com.wsd.quartz;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * Created by tm on 2018/8/7.
 * 程序启动后自动执行类
 */
public class AutoJob implements ApplicationContextAware {
    @Autowired
    Quartz sj;
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
            System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
            sj.start();
    }

}
