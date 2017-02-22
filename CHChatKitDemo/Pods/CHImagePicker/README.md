[![CocoaPods](https://cocoapod-badges.herokuapp.com/v/CHNetworking/badge.svg)](http://www.cocoapods.org/?q=CHImagePicker)

# CHImagePicker
通过单例方法访问手机相册，获取用户选中的图片实现头像上传

# CHImagePicker安装

```
pod 'CHImagePicker'

```
# 使用方法
``` Demo
    [[CHImagePicker shareInstance]showWithController:self finish:^(UIImage *image) {
        NSLog(@"image=%@",image);
    } animated:YES];
    
```
