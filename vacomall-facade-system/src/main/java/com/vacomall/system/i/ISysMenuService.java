package com.vacomall.system.i;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.service.IService;
import com.vacomall.system.model.SysMenu;

/**
 * <p>
 * 菜单表 服务类
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-06-30
 */
public interface ISysMenuService extends IService<SysMenu> {
	
	/**
	 * 分配权限
	 * @param roleId
	 * @param menuIds
	 */
	void updateAuth(String roleId, String menuIds);
	
	/**
	 * 查询用户菜单
	 * @param uid 用户ID
	 * @param pid 上级菜单ID
	 * @return
	 */
	List<Map<String, Object>> selectMenuByUid(String uid, String pid);
	
	/**
	 * 获取当前用户的权限资源
	 * @param uid
	 * @return
	 */
	List<String> selectResourceByUid(String uid);
	/**
	 * 
	 * @param string
	 * @return
	 */
	List<Map<String, Object>> selectMenuByPid(String pid);
	
}
