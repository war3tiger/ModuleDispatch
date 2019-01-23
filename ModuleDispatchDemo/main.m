//
//  main.m
//  ModuleDispatchDemo
//
//  Created by zyh on 2019/1/23.
//  Copyright © 2019年 Bee. All rights reserved.
//
#import "BeeModuleDispatch.h"

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    bee_execute_for_stage(beeKeyStage1);
    NSLog(@"main start");
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
