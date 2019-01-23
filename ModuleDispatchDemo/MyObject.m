//
//  MyObject.m
//  ModuleDispatchDemo
//
//  Created by zyh on 2019/1/23.
//  Copyright © 2019年 Bee. All rights reserved.
//
#import "BeeModuleDispatch.h"

#import "MyObject.h"

bee_register_functions_start(myObjectLoad) {
    NSLog(@"MyObject load");
}
bee_register_functions_end(beeKeyStage1, myObjectLoad);

@implementation MyObject

@end
