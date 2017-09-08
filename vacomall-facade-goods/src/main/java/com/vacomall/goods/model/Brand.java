package com.vacomall.goods.model;

import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 商品品牌信息记录表
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-09-08
 */
@TableName("ecs_brand")
public class Brand extends Model<Brand> {

    private static final long serialVersionUID = 1L;

    /**
     * 自增ID号
     */
	@TableId(value="brand_id", type= IdType.AUTO)
	private Integer brandId;
    /**
     * 品牌名称
     */
	@TableField("brand_name")
	private String brandName;
    /**
     * 上传的该品牌公司logo图片
     */
	@TableField("brand_logo")
	private String brandLogo;
    /**
     * 品牌描述
     */
	@TableField("brand_desc")
	private String brandDesc;
    /**
     * 品牌的网址
     */
	@TableField("site_url")
	private String siteUrl;
    /**
     * 品牌在前台页面的显示顺序，数字越大越靠后
     */
	@TableField("sort_order")
	private Integer sortOrder;
    /**
     * 该品牌是否显示，0，否；1，显示
     */
	@TableField("is_show")
	private Integer isShow;


	public Integer getBrandId() {
		return brandId;
	}

	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getBrandLogo() {
		return brandLogo;
	}

	public void setBrandLogo(String brandLogo) {
		this.brandLogo = brandLogo;
	}

	public String getBrandDesc() {
		return brandDesc;
	}

	public void setBrandDesc(String brandDesc) {
		this.brandDesc = brandDesc;
	}

	public String getSiteUrl() {
		return siteUrl;
	}

	public void setSiteUrl(String siteUrl) {
		this.siteUrl = siteUrl;
	}

	public Integer getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}

	public Integer getIsShow() {
		return isShow;
	}

	public void setIsShow(Integer isShow) {
		this.isShow = isShow;
	}

	@Override
	protected Serializable pkVal() {
		return this.brandId;
	}

}
