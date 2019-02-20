//
//  ViewController.m
//  JGZPermissionTool
//
//  Created by jgzhu on 2019/2/20.
//  Copyright © 2019 jgzhu. All rights reserved.
//

#import "ViewController.h"
#import "JGZPermissionTool/JGZPermissionTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self photoPermisson];
            break;
        case 1:
            [self cameraPermisson];
            break;
        case 2:
            [self audioPermisson];
            break;
        default:
            break;
    }
}
-(void)photoPermisson{
    [JGZPermissionTool permissionToolWithPermissionType:PermissionType_PhPhoto jumpToSetting:NO customBlock:^(JGZAuthorizationStatus status) {
        NSLog(@"%ld",(long)status);
    }];
}

-(void)cameraPermisson{
    [JGZPermissionTool permissionToolWithPermissionType:PermissionType_Video jumpToSetting:YES customBlock:^(JGZAuthorizationStatus status) {
        NSLog(@"%ld",(long)status);
    }];
}
-(void)audioPermisson{
    [JGZPermissionTool permissionToolWithPermissionType:PermissionType_Audio jumpToSetting:YES customBlock:^(JGZAuthorizationStatus status) {
        NSLog(@"%ld",(long)status);
    }];
}
@end
