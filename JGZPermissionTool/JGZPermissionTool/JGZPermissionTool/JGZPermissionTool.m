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
#import <Speech/Speech.h>//语音识别


@interface JGZPermissionTool()

@end

@implementation JGZPermissionTool
+(void)permissionToolWithPermissionType:(JGZPermissionType)permissionType jumpToSetting:(BOOL)jump customBlock:(handleBlock)block{
    JGZAuthorizationStatus Status;
    switch (permissionType) {
        case PermissionType_PhPhoto:
        {
            Status=[self isPhPhotoAuthority];
            
        }
            break;
        case PermissionType_Video:
        {
            Status=[self isVideo_AudioAuthorityWith:AVMediaTypeVideo];
        }
            break;
        case PermissionType_Audio:
        {
            Status=[self isVideo_AudioAuthorityWith:AVMediaTypeAudio];
            
        }
            break;
        case PermissionType_Location_WhenInuse:
        {
            Status=[self isLocationAuthorityWith:PermissionType_Location_WhenInuse];

        }
            break;
        case PermissionType_Audio_Always:
        {
            Status=[self isLocationAuthorityWith:PermissionType_Audio_Always];
        }
            break;
        default:
            break;
    }
    [self operationWithStatus:Status jump:jump Block:block];

   
}
+(void)operationWithStatus:(JGZAuthorizationStatus)Status jump:(BOOL)jump Block:(handleBlock)block{
    if (Status==JGZAuthorizationStatusDenied||Status==JGZAuthorizationStatusRestricted) {
        if (jump) {
            [JGZPermissionTool jumpSetting];
        }
    }
    if (block) {
        block(Status);
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
static  CLLocationManager *LocationManager;
+(JGZAuthorizationStatus)isLocationAuthorityWith:(JGZPermissionType)permissionType{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
        //定位功能可用
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            if (!LocationManager) {
              LocationManager=[[CLLocationManager alloc] init];
            }
            
            if (permissionType==PermissionType_Location_WhenInuse) {
                [LocationManager requestWhenInUseAuthorization];
            }else{
                [LocationManager requestAlwaysAuthorization];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(180 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                LocationManager=nil;
            });
           return JGZAuthorizationStatusNotDetermined;
        }
        return JGZAuthorizationStatusAuthorized;
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        //定位不能用
      return JGZAuthorizationStatusDenied;
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusRestricted){
      return JGZAuthorizationStatusRestricted;
    }
    
    return JGZAuthorizationStatusAuthorized;
    
}
+(void)jumpSetting{
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}
@end
