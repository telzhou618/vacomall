package com.vacomall.system.impl;

import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vacomall.common.util.BaseUtil;
import com.vacomall.system.i.ISysUserRoleService;
import com.vacomall.system.i.ISysUserService;
import com.vacomall.system.mapper.SysUserMapper;
import com.vacomall.system.model.SysUser;
import com.vacomall.system.model.SysUserRole;

/**
 * <p>
 * 用户表 服务实现类
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-06-30
 */
@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements ISysUserService {

	@Autowired private ISysUserRoleService sysUserRoleService;
	
	@Override
	public void addUser(SysUser sysUser, String[] roleIds) {
		// TODO Auto-generated method stub
		this.insert(sysUser);
		if(!ArrayUtils.isEmpty(roleIds)){
			for(String rid : roleIds){
				SysUserRole sur = new SysUserRole();
				sur.setRoleId(rid);
				sur.setUserId(sysUser.getId());
				sysUserRoleService.insert(sur);
			}
		}
	}

	@Override
	public void updateUser(SysUser user, String[] roleIds) {
		// TODO Auto-generated method stub
		this.updateById(user);
		sysUserRoleService.delete(new EntityWrapper<SysUserRole>().eq("userId",user.getId()));
		if(!ArrayUtils.isEmpty(roleIds)){
			for(String rid : roleIds){
				SysUserRole ur = new SysUserRole();
				ur.setRoleId(rid);
				ur.setId(BaseUtil.uuid());
				ur.setUserId(user.getId());
				sysUserRoleService.insert(ur);
			}
			
		}
		
	}
	
	@Override
	public void deleteUser(String[] id) {
		// TODO Auto-generated method stub
		if(!ArrayUtils.isEmpty(id)){
			for(String d : id){
				this.deleteById(d);
				sysUserRoleService.delete(new EntityWrapper<SysUserRole>().eq("userId",d));
			}
		}
	}
	
}
