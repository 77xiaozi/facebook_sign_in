//
//  ViewController.m
//  facebook
//
//  Created by tqwang on 2019/5/13.
//  Copyright © 2019 tqwang. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithReadPermissions:@[@"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        //NSLog(@"result=%@",result);
        //result.token.userID
        [self getUserInfoWithResult:result];
    }];
}

//获取用户信息 picture用户头像
- (void)getUserInfoWithResult:(FBSDKLoginManagerLoginResult *)result
{
    NSDictionary*params= @{@"fields":@"id,name,email,age_range,first_name,last_name,link,gender,locale,picture,timezone,updated_time,verified"};
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:result.token.userID
                                  parameters:params
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        NSLog(@"%@",result);
        
        // 下边的部分 是我获取到的信息，剩下的信息可能是因为没有申请到权限吧
        // 现阶段用的开发者账号还是自己的，更多的可能性讲需要注册下来公司的账户，并开通相应的权限
        
//        {
//            "first_name" = Qingfeng;
//            id = 429690791177412;
//            "last_name" = Li;
//            name = "Qingfeng Li";
//            picture =     {
//                data =         {
//                    height = 50;
//                    "is_silhouette" = 0;
//                    url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=429690791177412&height=50&width=50&ext=1560396740&hash=AeQrpS9VqOZQ9-cK";
//                    width = 50;
//                };
//            };
//        }
    }];
}

/*
 {
 "age_range" =     {
 min = 21;
 };
 "first_name" = "\U6dd1\U5a1f";
 gender = female;
 id = 320561731689112;
 "last_name" = "\U6f58";
 link = "https://www.facebook.com/app_scoped_user_id/320561731689112/";
 locale = "zh_CN";
 name = "\U6f58\U6dd1\U5a1f";
 picture =     {
 data =         {
 "is_silhouette" = 0;
 url = "https://fb-s-c-a.akamaihd.net/h-ak-fbx/v/t1.0-1/p50x50/18157158_290358084709477_3057447496862917877_n.jpg?oh=01ba6b3a5190122f3959a3f4ed553ae8&oe=5A0ADBF5&__gda__=1509731522_7a226b0977470e13b2611f970b6e2719";
 };
 };
 timezone = 8;
 "updated_time" = "2017-04-29T07:54:31+0000";
 verified = 1;
 }
 */


@end
