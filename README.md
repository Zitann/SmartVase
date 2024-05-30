

# 云瓶

2024物联网大赛前端

<img src="http://123.60.145.37:5000/favicon.ico"/>

  <h3 align="center">云瓶</h3>
  <p align="center">
    开始你的绿色之旅！
    <br />
    <a href="https://github.com/Narrao/SmartVase"><strong>探索本项目的文档 »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Narrao/SmartVase">查看项目</a>
    ·
    <a href="https://github.com/Narrao/SmartVase/issues">报告Bug</a>
    ·
    <a href="https://github.com/Narrao/SmartVase/issues">提出新特性</a>
  </p>
  
## 目录

- [上手指南](#上手指南)
- [主要文件目录说明](#主要文件目录说明)
- [开发的架构](#开发的架构)
- [部署](#部署)
- [使用到的框架](#使用到的框架)
- [版本控制](#版本控制)
- [作者](#作者)

### 上手指南

1. 安装<a href="https://contentcenter-vali-drcn.dbankcdn.cn/pvt_2/DeveloperAlliance_package_901_9/ee/v3/HqJ-6O2FQny86xtk_dg9HQ/devecostudio windows-4.1.0.400.zip?HW-CC-KV=V1&HW-CC-Date=20240409T033730Z&HW-CC-Expire=315360000&HW-CC Sign=BFA444BC43A041331E695AE2CFA9035A957AF107E06C97E793FD3D31D7096A0D">DevEco Studio 4.1.0</a>
3. 根据提示配置环境，本项目使用HarmonyOS 3.1.0(API 9)
4. 克隆本仓库

```sh
git clone https://github.com/Narrao/SmartVase.git
```

### 主要文件目录说明

```
entry
├─.preview    //预览器生成文件
├─build		  //构建Hap包生成文件
└─src
    ├─main
    │  ├─ets
    │  │  ├─common			//工具与数据定义
    │  │  ├─entryability	//入口文件
    │  │  ├─pages			//界面构造文件
    │  │  └─tabs			//组件构造文件
    │  └─resources
    │      ├─base
    │      │  ├─element		//字符串和其他数据
    │      │  ├─media		//图片
    │      │  └─profile		//页面注册
    │      ├─en_US
    │      └─zh_CN
    └─ohosTest
```





### 开发的架构 

前后端分离架构，实现应用-服务器-单片机多端互通

### 部署

暂无

### 使用到的框架

本项目使用的ArkUI开发框架是方舟开发框架的简称，它是一套构建 HarmonyOS / OpenHarmony 应用界面的声明式UI开发框架，它使用极简的UI信息语法、丰富的UI组件以及实时界面语言工具，帮助开发者提升应用界面开发效率 30%，开发者只需要使用一套 TS / JS API，就能在多个 HarmonyOS / OpenHarmony 设备上提供既丰富又流畅的用户界面体验。

### 版本控制

该项目使用Git进行版本管理。您可以在repository参看当前可用版本。

### 作者

- [Narrao (Jiang Zitan)](https://github.com/Narrao)
- [DoctorFishbo (Feng) ](https://github.com/DoctorFishbo)
