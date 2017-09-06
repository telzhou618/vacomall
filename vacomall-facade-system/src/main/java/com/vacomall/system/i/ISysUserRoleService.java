package com.vacomall.system.i;

import java.util.Set;

import com.baomidou.mybatisplus.service.IService;
import com.vacomall.system.model.SysUserRole;

/**
 * <p>
 * 用户角色关联表 服务类
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-06-30
 */
public interface ISysUserRoleService extends IService<SysUserRole> {

	Set<String> findRolesByUid(String id);
	
}
