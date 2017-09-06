package com.vacomall.controller;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.vacomall.bean.Rest;
import com.vacomall.common.util.BaseUtil;
import com.vacomall.system.i.ISysUserService;
import com.vacomall.system.model.SysUser;

/**
 * 用户控制器
 * @author jameszhou
 *
 */
@Controller
@RequestMapping("/user")
public class UserController extends AdminController{

	@Autowired private ISysUserService sysUserService;
	
	@RequestMapping("/list")
	public String list () {
		return "user/user-list";
	}
	
	/**
	 * JSON分页数据
	 * @param start
	 * @param size
	 * @param search
	 * @param sort
	 * @param order
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/json")
	public Rest json (
			@RequestParam(value="page",defaultValue="1") Integer page,
			@RequestParam(value="limit",defaultValue="10") Integer size,
			@RequestParam(value="key[search]",required=false) String search) {
		
		EntityWrapper<SysUser> ew = new EntityWrapper<SysUser>();
		if(StringUtils.isNotBlank(search)){
			ew.like("userName", search);
		}
		Page<SysUser> pageData = sysUserService.selectPage(new Page<SysUser>(page, size),ew);
		return Rest.okCountData(pageData.getTotal(),pageData.getRecords());
	}
	
	@RequestMapping("/add")
	public String add(){
		return "user/user-add";
	}
	
	/**
	 * 执行新增用户
	 * @param sysUser
	 * @return
	 * @throws InterruptedException 
	 */
	@ResponseBody
	@RequestMapping("/doAdd")
	public Rest doAdd(SysUser sysUser,String confPassword, String[] rids){
		if(!confPassword.equals(sysUser.getPassword())){
			return Rest.failure("两次输入的密码不一致");
		}
		if(sysUserService.selectCount(new EntityWrapper<SysUser>().eq("userName", sysUser.getUserName())) > 0){
			return Rest.failure("用户名["+sysUser.getUserName()+"]已存在");
		}
		sysUser.setCreateTime(new Date());
		sysUser.setPassword(BaseUtil.md51024Pwd(sysUser.getPassword(), sysUser.getUserName()));
		sysUserService.addUser(sysUser, rids);
		return Rest.ok();
	}
	/*
	*//**
	 * 执行编辑用户
	 * @param id
	 * @param model
	 * @return
	 * @throws InterruptedException 
	 *//*
	@RequiresPermissions("user:edit")
	@RequestMapping("/edit")
	public Rest edit(SysUser sysUser,String[] rids){
		sysUserService.updateUser(sysUser, rids);
		return Rest.ok();
	}
	
	*//**
	 * 删除
	 * @param id
	 * @return
	 *//*
	@RequiresPermissions("user:delete")
	@RequestMapping("/delete")
	public Rest delete(@RequestParam("ids") String[] ids){
		if(ArrayUtils.isEmpty(ids)){
			return Rest.failure("客户端传入对象id为空");
		}
		sysUserService.deleteBatchIds(Arrays.asList(ids));
		return Rest.ok();
	}
	
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
	
	*//**
	 * 获取当前用户
	 * @return
	 *//*
	@RequestMapping("/get/curuser")
	public Rest getCurUser(){
		
		Subject subject = SecurityUtils.getSubject();
		if(subject != null){
			SysUser sysUser = (SysUser) subject.getPrincipal();
			return Rest.okData(sysUser);
		}
		return Rest.failure("登录过期");
	}*/
	
	@ResponseBody
	@RequestMapping("/init")
	public String init(){
		for(int i=0;i<1000;i++){
			SysUser user = new SysUser();
			user.setCreateTime(new Date());
			user.setPassword("******");
			user.setUserDesc("测试描述_"+i);
			user.setUserName("testName_"+i);
			user.setUserState(1);
			sysUserService.insert(user);
		}
		return "ok";
	}
}
