package com.vacomall.system.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vacomall.system.i.ISysUserRoleService;
import com.vacomall.system.mapper.SysUserRoleMapper;
import com.vacomall.system.model.SysUserRole;

/**
 * <p>
 * 用户角色关联表 服务实现类
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-06-30
 */
@Service
public class SysUserRoleServiceImpl extends ServiceImpl<SysUserRoleMapper, SysUserRole> implements ISysUserRoleService {

	@Override
	public Set<String> findRolesByUid(String id) {
		// TODO Auto-generated method stub
		
		List<SysUserRole> list = this.selectList(new EntityWrapper<SysUserRole>().eq("userId", id));
		
		Set<String> set = new HashSet<String>();
		for(SysUserRole ur : list){
			set.add(ur.getRoleId());
		}
		return set;
	}
	
}
