//
//  JGZPermissionTool.h
//  JGZPermissionTool
//
//  Created by jgzhu on 2019/2/20.
//  Copyright © 2019 jgzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JGZPermissionType) {
    PermissionType_PhPhoto,//相册
    PermissionType_Video,//相机
    PermissionType_Audio,//麦克风
};

typedef NS_ENUM(NSInteger, JGZAuthorizationStatus) {
    JGZAuthorizationStatusNotDetermined = 0,
    JGZAuthorizationStatusRestricted,
    JGZAuthorizationStatusDenied,
    JGZAuthorizationStatusAuthorized
};

@interface JGZPermissionTool : NSObject
+(void)permissionToolWithPermissionType:(JGZPermissionType)permissionType jumpToSetting:(BOOL)jump customBlock:(void(^)(JGZAuthorizationStatus status))block;
+(void)jumpSetting;
@end

