package com.vacomall.controller.system;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.vacomall.bean.Rest;
import com.vacomall.system.i.ISysLogService;
import com.vacomall.system.model.SysLog;

/**
 * @author GaoJun.Zhou
 * @Time：2017年9月5日 上午10:37:54
 * @version 1.0
 */
@Controller
@RequestMapping("/log")
public class LogController {

	@Autowired private ISysLogService sysLogService;
	
	/**
	 * 列表视图
	 * @return
	 */
	@RequestMapping("/list")
	public String list () {
		return "log/log-list";
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
			@RequestParam(value="search",required=false) String search) {
		
		EntityWrapper<SysLog> ew = new EntityWrapper<SysLog>();
		ew.orderBy("logTime", false);
		if(StringUtils.isNotBlank(search)){
			ew.like("userName", search).or()
			.like("logTitle", search).or()
			.like("logContent", search).or()
			.like("requestParams", search);
		}
		Page<SysLog> pageData = sysLogService.selectPage(new Page<SysLog>(page, size),ew);
		return Rest.okCountData(pageData.getTotal(),pageData.getRecords());
	}
	
	@ResponseBody
	@RequestMapping("/detail")
	public String detail(String id){
		SysLog sysLog = sysLogService.selectById(id);
		if(sysLog == null){
			return "NULL";
		}
		return sysLog.getRequestParams();
	}
}
