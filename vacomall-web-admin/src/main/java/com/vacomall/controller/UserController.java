package com.vacomall.controller;

import java.util.Arrays;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.BooleanUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.entity.Column;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.vacomall.bean.Rest;
import com.vacomall.common.util.BaseUtil;
import com.vacomall.system.i.ISysRoleService;
import com.vacomall.system.i.ISysUserRoleService;
import com.vacomall.system.i.ISysUserService;
import com.vacomall.system.model.SysUser;
import com.vacomall.system.model.SysUserRole;

/**
 * 用户控制器
 * @author jameszhou
 *
 */
@Controller
@RequestMapping("/user")
public class UserController extends AdminController{

	@Autowired private ISysUserService sysUserService;
	@Autowired private ISysRoleService sysRoleService;
	@Autowired private ISysUserRoleService sysUserRoleService;
	
	/**
	 * 列表视图
	 * @return
	 */
	@RequestMapping("/list")
	public String list () {
		return "user/user-list";
	}

	/**
	 * Json 分页查询JSON数据
	 * @param page
	 * @param size
	 * @param search
	 * @param userState
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/json")
	public Rest json (
			@RequestParam(value="page",defaultValue="1") Integer page,
			@RequestParam(value="limit",defaultValue="10") Integer size,
			@RequestParam(value="search",required=false) String search,
		@RequestParam(value="userState",required=false) Integer userState) {
		
		EntityWrapper<SysUser> ew = new EntityWrapper<SysUser>();
		ew.orderBy("createTime", false);
		if(StringUtils.isNotBlank(search)){
			ew.like("userName", search);
		}
		if(userState!=null){
			ew.eq("userState", userState);
		}
		Page<SysUser> pageData = sysUserService.selectPage(new Page<SysUser>(page, size),ew);
		return Rest.okCountData(pageData.getTotal(),pageData.getRecords());
	}
	
	/**
	 * 新增视图
	 * @return
	 */
	@RequestMapping("/add")
	public String add(){
		return "user/user-add";
	}
	
	/**
	 * 执行新增
	 * @param sysUser
	 * @param confPassword
	 * @param state
	 * @param rids
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/doAdd")
	public Rest doAdd(SysUser sysUser,String confPassword,Boolean state, String[] rids){
		if(!confPassword.equals(sysUser.getPassword())){
			return Rest.failure("两次输入的密码不一致");
		}
		if(sysUserService.selectCount(new EntityWrapper<SysUser>().eq("userName", sysUser.getUserName())) > 0){
			return Rest.failure("用户名["+sysUser.getUserName()+"]已存在");
		}
		if(BooleanUtils.isTrue(state)){
			sysUser.setUserState(SysUser._1);
		}else{
			sysUser.setUserState(SysUser._0);
		}
		sysUser.setCreateTime(new Date());
		sysUser.setPassword(BaseUtil.md51024Pwd(sysUser.getPassword(), sysUser.getUserName()));
		sysUserService.addUser(sysUser, rids);
		return Rest.ok();
	}
	
	/**
	 * 执行删除
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("user:delete")
	@RequestMapping("/delete")
	public Rest delete(@RequestParam("ids[]") String[] ids){
		if(ArrayUtils.isEmpty(ids)){
			return Rest.failure("客户端传入对象id为空");
		}
		sysUserService.deleteBatchIds(Arrays.asList(ids));
		return Rest.ok();
	}
	
	/**
	 * 编辑视图
	 * @param id
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user:edit")
	@RequestMapping("/edit")
	public String edit(String id,Model model){
		model.addAttribute("sysUser", sysUserService.selectById(id));
		return "user/user-edit";
	}
	
	/**
	 * 执行编辑
	 * @param sysUser
	 * @param state
	 * @param rids
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/doEdit")
	public Rest doEdit(SysUser sysUser,Boolean state,String[] rids){
		if(BooleanUtils.isTrue(state)){
			sysUser.setUserState(SysUser._1);
		}else{
			sysUser.setUserState(SysUser._0);
		}
		sysUserService.updateUser(sysUser, rids);
		return Rest.ok();
	}
	
	/**
	 * 重置密码
	 * @param id
	 * @param pwd
	 * @return
	 */
	@RequiresPermissions("user:restpwd")
	@RequestMapping("/repwd")
	public Rest repwd(String id,String pwd){
		if(StringUtils.isBlank(id)){
			return Rest.failure("客户端传入对象id为空");
		}
		if(StringUtils.isBlank(pwd)){
			return Rest.failure("新密码不能为空");
		}
		SysUser sysUser =sysUserService.selectById(id);
		if(sysUser== null){
			return Rest.failure("用户不存在");
		}
		sysUser.setPassword(BaseUtil.md51024Pwd(pwd, sysUser.getUserName()));
		sysUserService.updateById(sysUser);
		return Rest.ok();
	}
	
	@RequestMapping("/auth")
	public String auth(Model model,String id){
		
		model.addAttribute("sysUser",sysUserService.selectById(id));
		model.addAttribute("roleList",sysRoleService.selectList(null));
		model.addAttribute("hasRoleIdList",sysUserRoleService.selectObjs(new EntityWrapper<SysUserRole>().setSqlSelect(new Column().column("roleId")).eq("userId", id)));
		return "user/user-auth";
	}
	
	@ResponseBody
	@RequestMapping("/doAuth")
	public String doAuth(Model model,String id,String[] roleId){
		sysUserRoleService.delete(new EntityWrapper<SysUserRole>().eq("userId", id));
		if(ArrayUtils.isNotEmpty(roleId)){
			for(String rid : roleId){
				SysUserRole ur = new SysUserRole();
				ur.setUserId(id);
				ur.setRoleId(rid);
				sysUserRoleService.insert(ur);
			}
		}
		return "OK!";
	}
}
