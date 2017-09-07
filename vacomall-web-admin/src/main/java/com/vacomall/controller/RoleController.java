package com.vacomall.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.BooleanUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.vacomall.bean.Rest;
import com.vacomall.system.i.ISysRoleMenuService;
import com.vacomall.system.i.ISysRoleService;
import com.vacomall.system.i.ISysUserRoleService;
import com.vacomall.system.model.SysRole;
import com.vacomall.system.model.SysRoleMenu;
import com.vacomall.system.model.SysUserRole;

/**
 * 角色控制器
 * @author jameszhou
 *
 */
@Controller
@RequestMapping("/role")
public class RoleController extends AdminController{

	@Autowired private ISysRoleService sysRoleService;
	@Autowired private ISysRoleMenuService sysRoleMenuService;
	@Autowired private ISysUserRoleService sysUserRoleService;
	
	/**
	 * 列表视图
	 * @return
	 */
	@RequestMapping("/list")
	public String list () {
		return "role/role-list";
	}
	
	/**
	 * 
	 * @param page
	 * @param size
	 * @param search
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("role:list")
	@RequestMapping("/json")
	public Rest json (
			@RequestParam(value="page",defaultValue="1") Integer page,
			@RequestParam(value="limit",defaultValue="10") Integer size,
			@RequestParam(value="key[search]",required=false) String search,
			Model model) {
		
		EntityWrapper<SysRole> ew = new EntityWrapper<SysRole>();
		if(StringUtils.isNotBlank(search)){
			ew.like("roleName", search);
		}
		Page<SysRole> pageData = sysRoleService.selectPage(new Page<SysRole>(page, size),ew);
		return Rest.okCountData(pageData.getTotal(),pageData.getRecords());
	}
	
	/**
	 * 新增
	 * @param sysRole
	 * @return
	 */
	@RequiresPermissions("role:add")
	@RequestMapping("/add")
	public String add(SysRole sysRole){
		return "role/role-add";
	}
	
	/**
	 * 新增
	 * @param sysRole
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("role:add")
	@RequestMapping("/doAdd")
	public Rest doAdd(SysRole sysRole,Boolean state){
		sysRole.setCreateTime(new Date());
		if(BooleanUtils.isTrue(state)){
			sysRole.setRoleState(1);
		}else{
			sysRole.setRoleState(0);
		}
		sysRoleService.insert(sysRole);
		return Rest.ok();
	}
	
	
	/**
	 * 编辑视图
	 * @param id
	 * @param model
	 * @return
	 * @throws InterruptedException 
	 */
	@RequiresPermissions("role:edit")
	@RequestMapping("/edit")
	public String edit(String id,Model model){
		model.addAttribute("sysRole",sysRoleService.selectById(id));
		return "role/role-edit";
	}
	
	
	/**
	 * 执行编辑
	 * @param id
	 * @param model
	 * @return
	 * @throws InterruptedException 
	 */
	@ResponseBody
	@RequiresPermissions("role:edit")
	@RequestMapping("/doEdit")
	public Rest doEdit(SysRole sysRole,Boolean state){
		if(BooleanUtils.isTrue(state)){
			sysRole.setRoleState(1);
		}else{
			sysRole.setRoleState(0);
		}
		sysRoleService.updateById(sysRole);
		return Rest.ok();
	}
	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("role:delete")
	@RequestMapping("/delete")
	public Rest delete(@RequestParam("ids[]") String[] ids){
		if(ArrayUtils.isEmpty(ids)){
			return Rest.failure("客户端传入对象id为空");
		}
		sysRoleService.deleteBatchIds(Arrays.asList(ids));
		return Rest.ok();
	}
	
	/**
	 * 获取指定角色的权限
	 */
	@RequestMapping("/menulist")
	public List<Map<String, Object>> menulist(String rid){
		if(StringUtils.isBlank(rid)){
			throw new RuntimeException("客户端传入的角色ID为空");
		}
		List<Object> list = sysRoleMenuService.selectObjs(new EntityWrapper<SysRoleMenu>().setSqlSelect("menuId").eq("roleId", rid));
		return sysRoleMenuService.selectAuthByRidAndPid("0",list);
	}
	
	/**
	 * 执行分配权限
	 * @param rid
	 * @param menuIds
	 * @return
	 */
	@RequiresPermissions("role:auth")
	@RequestMapping("/doAuth")
	public Rest doAuth(String rid, String[] menuIds){
		sysRoleMenuService.updateAuth(rid,menuIds);
		return Rest.ok();
	}
	
	/**
	 * 获取当前用户的的角色
	 * @param uid
	 * @return
	 */
	@RequestMapping("/treelist")
	public List<Map<String, Object>> treelist(String uid){
		
		List<Object> roleIdList = new ArrayList<Object>();
		if(StringUtils.isNotBlank(uid)){
			roleIdList = sysUserRoleService.selectObjs(new EntityWrapper<SysUserRole>().setSqlSelect("roleId").eq("userId",uid));
		}
		
		List<Map<String, Object>> list = sysRoleService.selectMaps(new EntityWrapper<SysRole>().orderBy("createTime"));
		
		for(Map<String, Object> map : list){
			map.put("checked",roleIdList.contains(MapUtils.getString(map, "id")) ? true : false);
			map.put("leaf",true);
		}
		
		return list;
	}
 }
