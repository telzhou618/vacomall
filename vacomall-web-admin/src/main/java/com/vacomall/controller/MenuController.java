package com.vacomall.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.vacomall.bean.Rest;
import com.vacomall.system.i.ISysMenuService;
import com.vacomall.system.model.SysMenu;
import com.vacomall.system.model.SysUser;

/**
 * 用户控制器
 * @author jameszhou
 *
 */
@Controller
@RequestMapping("/menu")
public class MenuController extends AdminController{

	@Autowired private ISysMenuService sysMenuService;
	
	/**
	 * 列表页视图
	 * @return
	 */
	@RequestMapping("/list")
	public String list(){
		return "menu/menu-list";
	}
	
	/**
	 * 列表页数据
	 * @param page
	 * @param size
	 * @param search
	 * @param model
	 * @return
	 */
	@RequiresPermissions("menu:list")
	@ResponseBody
	@RequestMapping("/json")
	public Rest json (
			@RequestParam(value="page",defaultValue="1") Integer page,
			@RequestParam(value="limit",defaultValue="10") Integer size,
			@RequestParam(value="search",required=false) String search,
			Model model) {
		
		EntityWrapper<SysMenu> ew = new EntityWrapper<SysMenu>();
		ew.orderBy("code");
		if(StringUtils.isNotBlank(search)){
			ew.like("text", search);
		}
		Page<SysMenu> pageData = sysMenuService.selectPage(new Page<SysMenu>(page, size),ew);
		for(SysMenu menu : pageData.getRecords()){
			menu.setText(StringUtils.repeat("&nbsp;&nbsp;",menu.getCode().length()-2)+"┠"+menu.getText());
		}
		return Rest.okCountData(pageData.getTotal(),pageData.getRecords());
	}
	
	/**
	 * 新增菜单视图
	 * @param sysMenu
	 * @return
	 */
	@RequiresPermissions("menu:add")
	@RequestMapping("/add")
	public String add(Model model){
		List<SysMenu> list = sysMenuService.selectList(new EntityWrapper<SysMenu>().le("deep",2).orderBy("code"));
		for(SysMenu menu : list){
			menu.setText(StringUtils.repeat("&nbsp;&nbsp;",menu.getCode().length()-2)+"┠"+menu.getText());
		}
		model.addAttribute("menuList",list);
		return "menu/menu-add";
	}
	
	/**
	 * 执行新增菜单
	 * @param sysMenu
	 * @return
	 */
	@RequiresPermissions("menu:add")
	@ResponseBody
	@RequestMapping("/doAdd")
	public Rest doAdd(SysMenu sysMenu){
		sysMenuService.insert(sysMenu);
		return Rest.ok();
	}
	
	/**
	 * 编辑菜单视图
	 * @param id
	 * @param model
	 * @return
	 */
	@RequiresPermissions("menu:edit")
	@RequestMapping("/edit")
	public String edit(String id,Model model){
		model.addAttribute("sysMenu", sysMenuService.selectById(id));
		return "menu/menu-edit";
	}
	
	/**
	 * 执行菜单编辑
	 * @param id
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("menu:edit")
	@RequestMapping("/doEdit")
	public Rest doEdit(SysMenu sysMenu){
		sysMenuService.updateById(sysMenu);
		return Rest.ok();
	}
	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("menu:delete")
	@RequestMapping("/delete")
	public Rest delete(@RequestParam("ids[]") String[] ids){
		if(ArrayUtils.isEmpty(ids)){
			return Rest.failure("客户端传入对象id为空");
		}
		sysMenuService.deleteBatchIds(Arrays.asList(ids));
		return Rest.ok();
	}
	
	/**
	 * 加载当前用户的菜单
	 * @return
	 */
	@RequestMapping("/leftmenus")
	public Rest leftmenus(){
		Subject subject = SecurityUtils.getSubject();
		if(subject != null){
			SysUser sysUser = (SysUser) subject.getPrincipal();
			List<Map<String, Object>> list = sysMenuService.selectMenuByUid(sysUser.getId(),"0");
			return Rest.okCountData(list.size(), list);
		}else{
			return Rest.failure("会话过期");
		}
	}
	
	/**
	 * 获取全部菜单数据
	 * @return
	 */
	@RequestMapping("/treelist")
	public List<Map<String, Object>> treelist(){
		List<Map<String, Object>> list = sysMenuService.selectMenuByPid("0");
		return list;
	}
}
