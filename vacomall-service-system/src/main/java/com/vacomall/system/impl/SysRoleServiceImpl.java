package com.vacomall.system.impl;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vacomall.system.i.ISysRoleService;
import com.vacomall.system.mapper.SysRoleMapper;
import com.vacomall.system.model.SysRole;

/**
 * <p>
 * 角色表 服务实现类
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-06-30
 */
@Service
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements ISysRoleService {
	
}
