package com.vacomall.system.impl;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vacomall.system.i.ISysSettingService;
import com.vacomall.system.mapper.SysSettingMapper;
import com.vacomall.system.model.SysSetting;

/**
 * <p>
 * 系统设置表 服务实现类
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-06-30
 */
@Service
public class SysSettingServiceImpl extends ServiceImpl<SysSettingMapper, SysSetting> implements ISysSettingService {
	
}
