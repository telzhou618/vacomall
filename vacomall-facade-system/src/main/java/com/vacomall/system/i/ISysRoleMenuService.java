package com.vacomall.system.i;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.baomidou.mybatisplus.service.IService;
import com.vacomall.system.model.SysRoleMenu;

/**
 * <p>
 * 角色菜单关联表 服务类
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-06-30
 */
public interface ISysRoleMenuService extends IService<SysRoleMenu> {

	/**
	 * 获取当前角色权限
	 * @param id
	 * @return
	 */
	List<Map<String, Object>> selectAuthByRoleId(String id);

	Set<String> findMenusByUid(String id);

	/**
	 * 获取指定角色的菜单，并标明是否有权限
	 * @param pid //上级菜单ID
	 * @param menuIds //角色权限集合
	 * @return
	 */
	List<Map<String, Object>> selectAuthByRidAndPid(String pid, List<Object> menuIds);

	/**
	 * 执行分配权限
	 * @param rid
	 * @param menuIds
	 */
	void updateAuth(String rid, String[] menuIds);
	
}
