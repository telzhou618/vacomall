# vacomall 
分布式电商平台，基于SpringMVC开发，其他相关技术，Mybatis（开源ORM框架），Mybatis-Plus（国产ORM辅助包），Dubbo（阿里巴巴开源分布式服务框架），Zookeeper（分布式协调），Redis（高效KV），ActiveMQ（消息队列），Disconf（百度分布式配置）,Nginx（LB负载均衡），Shiro（轻量级权限框架），SSO（单点登录），Solr（搜索引擎），文件存储（百度BOS，七牛云），Mail（邮件），SMS（短信），Maven Nexus(Maven私服)， Docker（虚拟化），Jenkins（持续集成）等。目前正在设计、搭建框架。
### 环境要求
<div>
<table border="0">
    <tr>
	    <th>服务</th>
      <th>版本</th>
	    <th>端口</th>
      <th>说明</th>
	  </tr>
  <tr>
	    <td>zookeeper1</td>
      <td>v3.3.6</td>
	    <td>127.0.0.1:2181</td>
      <td>--</th>
	  </tr>
	  <tr>
	    <td>zookeeper2</td>
      <td>v3.3.6</td>
	    <td>127.0.0.1:2182</td>
      <td>--</th>
	  </tr>
    <tr>
	    <td>zookeeper3</td>
      <td>v3.3.6</td>
	    <td>127.0.0.1:2183</td>
      <td>--</th>
	  </tr>
    <tr>
	    <td>redis1</td>
      <td>v3.2</td>
	    <td>127.0.0.1:6379</td>
      <td>--</th>
	  </tr>
  <tr>
	    <td>redis2</td>
      <td>v3.2</td>
	    <td>127.0.0.1:6380</td>
      <td>--</th>
	  </tr>
    <tr>
	    <td>nginx</td>
      <td>v1.9.3</td>
	    <td>127.0.0.1:80</td>
      <td>--</th>
	  </tr>
    <tr>
	    <td>disconf</td>
      <td>v2.6.36</td>
	    <td>127.0.0.1:8015</td>
      <td>使用Tomcat部署disconf</th>
	  </tr>
    <tr>
	    <td>apache-activemq</td>
      <td>v5.9.0</td>
	    <td>127.0.0.1:8161</td>
      <td>--</th>
	  </tr>
	</table>
  </div>

### 开发参考

1. disconf-web安装 http://disconf.readthedocs.io/zh_CN/latest/install/src/02.html
2. 开发依赖包 https://github.com/zhougaojun618/vacomall-server

### 快速开始
1. 启动两个Redis服务
```
 ./redis-server.exe //默认的端口6376
 ./redis-server.exe --port 6380 //指定端口6380
```
2. 启动三个ZooKeeper服务
```
 /zookeeper-3.3.6-1/bin/zkServer.cmd // port 2181
 /zookeeper-3.3.6-1/bin/zkServer.cmd // port 2182
 /zookeeper-3.3.6-1/bin/zkServer.cmd // port 2183
```
3. 部署disconf服务，官网下载disconf，部署在Tomcat容器下。
4. 下载nginx,依照disconf的要求配置好nginx，参考http://disconf.readthedocs.io/zh_CN/latest/install/src/02.html
5. 域名映射,修改本地host文件,加上一句
```
127.0.0.1 disconf.com
```
6. 运行服务项目
```
vacomall-service-system
vacomall-service-goods 直接执行DubboProvider.java中main方法
```
7. 运行Web项目
```
vacomall-web-admin项目，端口8081，上下文"/"
vacomall-web-shop项目，端口8080,上下文"/"
```
8. 访问前台:http://localhost:8080, 访问前台: http://localhost:8081

### 最终实现效果
![image](https://github.com/zhougaojun618/vacomall/blob/master/imgs/f.png)
![image](https://github.com/zhougaojun618/vacomall/blob/master/imgs/b.png)

### 开发进度
目前正在架构设计、框架搭建中...
