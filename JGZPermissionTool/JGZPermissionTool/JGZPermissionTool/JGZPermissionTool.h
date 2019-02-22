//
//  JGZPermissionTool.h
//  JGZPermissionTool
//
//  Created by jgzhu on 2019/2/20.
//  Copyright © 2019 jgzhu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JGZAuthorizationStatus) {
    JGZAuthorizationStatusNotDetermined = 0,//用户尚未对该应用程序作出选择
    JGZAuthorizationStatusRestricted,//应用程序的权限被限制
    JGZAuthorizationStatusDenied,//拒绝获取
    JGZAuthorizationStatusAuthorized//允许获取
};
typedef void(^handleBlock)(JGZAuthorizationStatus status);

typedef NS_ENUM(NSUInteger, JGZPermissionType) {
    PermissionType_PhPhoto,//相册
    PermissionType_Video,//相机
    PermissionType_Audio,//麦克风
    PermissionType_Location_WhenInuse,//定位_使用时定位
    PermissionType_Audio_Always,//定位_一直定位
};



@interface JGZPermissionTool : NSObject
/*
 JGZPermissionType 权限类型
 jump              用户以前拒绝过应用权限或者权限被限制是否跳转到设置
 */
+(void)permissionToolWithPermissionType:(JGZPermissionType)permissionType jumpToSetting:(BOOL)jump customBlock:(handleBlock)block;
/*
 跳转到设置
 */
+(void)jumpSetting;
@end

