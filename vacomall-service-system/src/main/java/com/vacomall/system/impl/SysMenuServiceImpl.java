package com.vacomall.system.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.entity.Column;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.google.common.base.Splitter;
import com.vacomall.common.util.BaseUtil;
import com.vacomall.system.i.ISysMenuService;
import com.vacomall.system.mapper.SysMenuMapper;
import com.vacomall.system.mapper.SysRoleMenuMapper;
import com.vacomall.system.model.SysMenu;
import com.vacomall.system.model.SysRoleMenu;

/**
 * <p>
 * 菜单表 服务实现类
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-06-30
 */
@Service
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements ISysMenuService {

	@Autowired
	private SysRoleMenuMapper sysRoleMenuMapper;
	@Autowired
	private SysMenuMapper sysMenuMapper;

	/**
	 * 分配权限
	 */
	@Override
	public void updateAuth(String roleId, String menuIds) {
		// TODO Auto-generated method stub

		sysRoleMenuMapper.delete(new EntityWrapper<SysRoleMenu>().eq("roleId", roleId));
		if (StringUtils.isNotBlank(menuIds)) {
			List<String> menuIdList = Splitter.on(",").splitToList(menuIds);
			for (String menuId : menuIdList) {
				SysRoleMenu roleMenu = new SysRoleMenu();
				roleMenu.setId(BaseUtil.uuid());
				roleMenu.setMenuId(menuId);
				roleMenu.setRoleId(roleId);
				sysRoleMenuMapper.insert(roleMenu);
			}
		}

	}

	@Override
	public List<Map<String, Object>> selectMenuByUid(String uid, String pid) {
		// TODO Auto-generated method stub
		List<Map<String, Object>> list = sysMenuMapper.selectMenuByUid(uid,pid);
		for (Map<String, Object> map : list) {
			if (MapUtils.getIntValue(map, "deep") < 2) {
				map.put("items", selectMenuByUid(uid, map.get("id").toString()));
			}
			map.put("leaf", true);
		}
		return list;
	}

	@Override
	public List<String> selectResourceByUid(String uid) {
		// TODO Auto-generated method stub
		return sysMenuMapper.selectResourceByUid(uid);
	}

	@Override
	public List<Map<String, Object>> selectMenuByPid(String pid) {
		// TODO Auto-generated method stub
		Column[] columns = {
				new Column().column("id"),
				new Column().column("text"),
				new Column().column("pid"),
				new Column().column("deep")
		};
		List<Map<String, Object>> list = sysMenuMapper.selectMaps(new EntityWrapper<SysMenu>().setSqlSelect(columns).eq("pid", pid).orderBy("sort"));
		for (Map<String, Object> map : list) {
			if (MapUtils.getIntValue(map, "deep") < 3) {
				map.put("children", selectMenuByPid(map.get("id").toString()));
			}
			map.put("leaf", MapUtils.getIntValue(map, "deep")<3 ? false : true);
		}
		return list;

	}

}
