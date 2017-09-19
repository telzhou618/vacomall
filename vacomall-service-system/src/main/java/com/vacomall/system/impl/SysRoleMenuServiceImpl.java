package com.vacomall.system.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.entity.Column;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vacomall.system.i.ISysRoleMenuService;
import com.vacomall.system.mapper.SysMenuMapper;
import com.vacomall.system.mapper.SysRoleMenuMapper;
import com.vacomall.system.model.SysMenu;
import com.vacomall.system.model.SysRoleMenu;

/**
 * <p>
 * 角色菜单关联表 服务实现类
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-06-30
 */
@Service
public class SysRoleMenuServiceImpl extends ServiceImpl<SysRoleMenuMapper, SysRoleMenu> implements ISysRoleMenuService {

	@Autowired private SysRoleMenuMapper sysRoleMenuMapper;
	
	@Autowired private SysMenuMapper sysMenuMapper;
	 
	@Override
	public List<Map<String, Object>> selectAuthByRoleId(String id) {
		// TODO Auto-generated method stub
		return sysRoleMenuMapper.selectAuthByRoleId(id);
	}

	@Override
	public Set<String> findMenusByUid(String id) {
		// TODO Auto-generated method stub
		
		List<String> list =  sysMenuMapper.selectResourceByUid(id);
		return new HashSet<>(list);
	}

	/**
	 * 获取指定角色的菜单，并标明是否有权限
	 * @param pid //上级菜单ID
	 * @param menuIds //角色权限集合
	 * @return
	 */
	@Override
	public List<Map<String, Object>> selectAuthByRidAndPid(String pid, List<Object> menuIds) {
		// TODO Auto-generated method stub
		
		Column[] columns = { 
				new Column().column("id"),
				new Column().column("text"),
				new Column().column("pid"),
				new Column().column("deep"),
				new Column().column("resource")
		};
		List<Map<String, Object>> list = sysMenuMapper.selectMaps(new EntityWrapper<SysMenu>().setSqlSelect(columns).eq("pid",pid).orderBy("code"));
		for(Map<String, Object> map : list){
			if(MapUtils.getIntValue(map, "deep") < 3){
				map.put("children",selectAuthByRidAndPid(map.get("id").toString(),menuIds));
			}
			map.put("checked",menuIds.contains(map.get("id"))?"checked":"");
		}
		return list;
	}

	/**
	 * 分配权限
	 */
	@Override
	public void updateAuth(String rid, String[] menuIds) {
		// TODO Auto-generated method stub
		
		sysRoleMenuMapper.delete(new EntityWrapper<SysRoleMenu>().eq("roleId", rid));
		if(!ArrayUtils.isEmpty(menuIds)){
			for(String mid : menuIds){
				SysRoleMenu sysRoleMenu = new SysRoleMenu();
				sysRoleMenu.setMenuId(mid);
				sysRoleMenu.setRoleId(rid);
				sysRoleMenuMapper.insert(sysRoleMenu);
			}
		}
	}
	
}
