package com.vacomall.controller.goods;

import java.util.Arrays;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.vacomall.bean.Rest;
import com.vacomall.goods.i.IBrandService;
import com.vacomall.goods.model.Brand;

/**
 * 品牌服务
 * Created by GaoJun.Zhou on 2017年9月8日.
 * @version 1.0  
 * Function: TODO
 */
@Controller
@RequestMapping("/brand")
public class BrandController {
	
	@Autowired private IBrandService brandService;
	
	/**
	 * 列表视图
	 * @return
	 */
	@RequestMapping("/list")
	public String list () {
		return "brand/brand-list";
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
			@RequestParam(value="search",required=false) String search){
		
		EntityWrapper<Brand> ew = new EntityWrapper<Brand>();
		ew.orderBy("sort_order", false);
		if(StringUtils.isNotBlank(search)){
			ew.like("brand_name", search);
		}
		Page<Brand> pageData = brandService.selectPage(new Page<Brand>(page, size),ew);
		return Rest.okCountData(pageData.getTotal(),pageData.getRecords());
	}
	
	/**
	 * 添加品牌视图
	 * @return
	 */
	@RequestMapping("/add")
	public String add () {
		return "brand/brand-add";
	}
	
	/**
	 * 执行添加品牌
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/doAdd")
	public Rest doAdd (Brand brand) {
		brandService.insert(brand);
		return Rest.ok();
	}
	
	
	/**
	 * 编辑品牌视图
	 * @return
	 */
	@RequestMapping("/edit")
	public String add (String id,Model model) {
		model.addAttribute("brand", brandService.selectById(id));
		return "brand/brand-edit";
	}
	
	/**
	 * 执行编辑品牌
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/doEdit")
	public Rest doEdit (Brand brand) {
		brandService.updateById(brand);
		return Rest.ok();
	}
	
	/**
	 * 删除品牌
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/delete")
	public Rest delete(@RequestParam("ids[]") String[] ids){
		if(ArrayUtils.isEmpty(ids)){
			return Rest.failure("客户端传入对象id为空");
		}
		brandService.deleteBatchIds(Arrays.asList(ids));
		return Rest.ok();
	}
}
