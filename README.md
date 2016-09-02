
---
#PYMapKit
-------------

> 封装了高德腾讯百度地图提供统一的接口,让它们一键切换,kit内部使用的是火星坐标.

####示例:  
>Demo使用的是百度地图Demo简化版(侵删)


###使用方法
首先需要修改*PYMapConfigure.h*文件中宏,选择需要使用的地图和搜索信息提供商.
>地图

``` 
//开启地图服务
id mapManager = [PYMapFactory start];   
//创建地图
id<PYMapProtocal> map = [PYMapFactory createMap];
//获取地图视图添加到需要的地方
UIView* mapView = [_map mapView];
...
//根据需求通过PYMap.h文件中的协议方法调用map
...
//停止地图服务
[PYMapFactory end:mapManager];
```
>地图信息搜索

```
//开始搜索服务   
[PYMapSearchServiceFactory start];
//创建搜索服务对象
id<PYMapSearcherProtocal> mapSearcher = [PYMapSearchServiceFactory createSearcher];
//根据需求通过PYMapSearchService.h文件中的协议方法调用mapSearcher
...
```
 

### 注意事项
Kit内部使用的是火星坐标,切记.***PYCoordCover***提供火星坐标-百度坐标-GPS坐标的转换方法.
