package com.vacomall.system.impl;


import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vacomall.system.i.ISysLogService;
import com.vacomall.system.mapper.SysLogMapper;
import com.vacomall.system.model.SysLog;

/**
 * <p>
 * 日志 服务实现类
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-06-30
 */
@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements ISysLogService {

}
