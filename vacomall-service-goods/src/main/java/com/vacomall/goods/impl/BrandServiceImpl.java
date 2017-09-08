package com.vacomall.goods.impl;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vacomall.goods.i.IBrandService;
import com.vacomall.goods.mapper.BrandMapper;
import com.vacomall.goods.model.Brand;

/**
 * <p>
 * 商品品牌信息记录表 服务实现类
 * </p>
 *
 * @author GaoJun.Zhou
 * @since 2017-09-08
 */
@Service
public class BrandServiceImpl extends ServiceImpl<BrandMapper, Brand> implements IBrandService {
	
}
