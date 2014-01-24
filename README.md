##明道iOS 版本的SDK，包含了移动应用SSO授权


***

##1、SSO授权功能介绍

使用明道登录的第三方Android、iOS应用可通过明道官方客户端快速完成OAuth2.0授权登录。
##2、SSO授权优势

不需要重复输入明道用户名、密码，只需要一步操作，直接点击授权按钮即可完成授权，增强了操作简便性及帐号安全性。

目前支持SSO的客户端版本（SDK会进行版本识别并以WebView方式向下兼容）

1、iPhone版明道客户端3.0及以上

2、iPad版明道客户端暂不支持

##3、接入流程
1、下载并导入明道官方SDK。

Android平台：https://github.com/meihua-info/api_android

iOS平台：https://github.com/meihua-info/api_ios

2、参照SDK中所提供的Sample，仔细阅读SDK说明文档。

3、参照说明文档，修改应用信息（包括AppKey、App Secret、Redirect Url），并完成第三方应用中的一些开发工作。

注明：第三方也可根据自身需要，对SDK进行二次开发。


##4、创建应用
公有云请到明道开放平台创建应用 <http://open.mingdao.com> 私有部署请联系管理员创建应用并获取令牌

具体开发指南请见《[明道开放平台指南](http://open.mingdao.com/md_develop_tread.html)》
##5、iOS平台接入说明文档

1、此源码是已经嵌入了iOS的Demo，开发者可以根据此Demo将SDK嵌入到自己的项目中。

2、使用前请配置SDK中涉及到的Appkey、App Secret、Redirect Url。

3、具体流程

（1）添加MingdaoSDK资源文件

![image](https://raw2.github.com/meihua-info/api_ios/master/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E6%8C%87%E5%8D%97/1.jpeg)

（2）添加URLScheme 
    注: iPhone/iPod URLScheme为mingdaoApp'AppKey', 
        iPad URLScheme为mingdaoAppHD'AppKey',
        明道会优先将回调信息回传到iPad版应用,
        引号内内容创建应用时获取的AppKey, 不包括引号

![image](https://raw2.github.com/meihua-info/api_ios/master/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E6%8C%87%E5%8D%97/3.jpeg)

（3）添加调用代码

![image](https://raw2.github.com/meihua-info/api_ios/master/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E6%8C%87%E5%8D%97/2.jpeg)

（4）接收返回的accesstoken结果

![image](https://raw2.github.com/meihua-info/api_ios/master/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E6%8C%87%E5%8D%97/4.jpeg)

（5）示例

![image](https://raw2.github.com/meihua-info/api_ios/master/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E6%8C%87%E5%8D%97/5.png)

***