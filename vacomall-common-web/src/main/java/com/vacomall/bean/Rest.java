package com.vacomall.bean;
/**
 * @author GaoJun.Zhou
 * @Time：2017年9月6日 下午1:29:08
 * @version 1.0
 */
public class Rest {

	private long code = 0;
	
	private long count = 0;
	
	private Object data;
	
	private String msg;

	public long getCode() {
		return code;
	}

	public void setCode(long code) {
		this.code = code;
	}

	public long getCount() {
		return count;
	}

	public void setCount(long count) {
		this.count = count;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public Rest() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Rest(long code, long count, Object data, String msg) {
		super();
		this.code = code;
		this.count = count;
		this.data = data;
		this.msg = msg;
	}

	public static Rest ok(){
		return new Rest(200,0,null,"ok");
	}
	
	public static Rest okCountData(long count,Object data){
		return new Rest(0,count,data,"ok");
	}

	public static Rest failure(String msg) {
		// TODO Auto-generated method stub
		 return new Rest(500,0,null,msg);
	}
}
