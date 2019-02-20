//
//  JGZPermissionTool.m
//  JGZPermissionTool
//
//  Created by jgzhu on 2019/2/20.
//  Copyright © 2019 jgzhu. All rights reserved.
//

#import "JGZPermissionTool.h"
#import <CoreLocation/CoreLocation.h>           //定位
#import <AddressBook/AddressBook.h>             //通讯录
#import <Photos/Photos.h>                       //获取相册状态权限
#import <AVFoundation/AVFoundation.h>           //相机麦克风权限
#import <EventKit/EventKit.h>                   //日历\备提醒事项权限
#import <Contacts/Contacts.h>                   //通讯录权限
#import <SafariServices/SafariServices.h>
#import <Speech/Speech.h>                       //语音识别
#import <HealthKit/HealthKit.h>                 //运动与健身
#import <MediaPlayer/MediaPlayer.h>             //媒体资料库
#import <UserNotifications/UserNotifications.h> //推送权限
#import <CoreBluetooth/CoreBluetooth.h>         //蓝牙权限
#import <Speech/Speech.h>                       //语音识别
@implementation JGZPermissionTool
+(void)permissionToolWithPermissionType:(JGZPermissionType)permissionType jumpToSetting:(BOOL)jump customBlock:(nonnull void (^)(JGZAuthorizationStatus status))block{
    switch (permissionType) {
        case PermissionType_PhPhoto:
        {
            JGZAuthorizationStatus Status=[self isPhPhotoAuthority];
            if (Status==JGZAuthorizationStatusDenied||Status==JGZAuthorizationStatusRestricted) {
                if (jump) {
                  [JGZPermissionTool jumpSetting];
                }
            }
            if (block) {
                block(Status);
            }
        }
            break;
        case PermissionType_Video:
        {
            JGZAuthorizationStatus Status=[self isVideo_AudioAuthorityWith:AVMediaTypeVideo];
            if (Status==JGZAuthorizationStatusDenied||Status==JGZAuthorizationStatusRestricted) {
                if (jump) {
                    [JGZPermissionTool jumpSetting];
                }
            }
            if (block) {
                block(Status);
            }
        }
            break;
        case PermissionType_Audio:
        {
            JGZAuthorizationStatus Status=[self isVideo_AudioAuthorityWith:AVMediaTypeAudio];
            if (Status==JGZAuthorizationStatusDenied||Status==JGZAuthorizationStatusRestricted) {
                if (jump) {
                    [JGZPermissionTool jumpSetting];
                }
            }
            if (block) {
                block(Status);
            }
        }
            break;
        default:
            break;
    }
   
}
+(JGZAuthorizationStatus)isPhPhotoAuthority{
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
        case PHAuthorizationStatusAuthorized:
            return JGZAuthorizationStatusAuthorized;
            break;
        case PHAuthorizationStatusDenied:
            return JGZAuthorizationStatusDenied;
            break;
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//                if (status == PHAuthorizationStatusAuthorized) {
//                }else{
//                   // NSLog(@"Denied or Restricted");
//                }
            }];
        }
            return JGZAuthorizationStatusNotDetermined;
            break;
        case PHAuthorizationStatusRestricted:
            return JGZAuthorizationStatusRestricted;
            break;
        default:
            break;
    }
}

+(JGZAuthorizationStatus)isVideo_AudioAuthorityWith:(AVMediaType)Type{
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:Type];
    switch (videoAuthStatus) {
        case AVAuthorizationStatusAuthorized:
            return JGZAuthorizationStatusAuthorized;
            break;
        case AVAuthorizationStatusDenied:
            return JGZAuthorizationStatusDenied;
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:Type completionHandler:^(BOOL granted) {
//                if (granted){// 用户同意授权
//
//                }else {// 用户拒绝授权
//
//                }
            }];
        }
            return JGZAuthorizationStatusNotDetermined;
            break;
        case AVAuthorizationStatusRestricted:
            return JGZAuthorizationStatusRestricted;
            break;
        default:
            break;
    }
    
}
+(void)jumpSetting{
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}
@end
