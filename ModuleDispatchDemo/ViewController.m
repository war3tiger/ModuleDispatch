//
//  ViewController.m
//  ModuleDispatchDemo
//
//  Created by zyh on 2019/1/23.
//  Copyright © 2019年 Bee. All rights reserved.
//
#import "BeeModuleDispatch.h"

#import "ViewController.h"

bee_register_functions_start(viewControllerLoad) {
    NSLog(@"ViewController Load");
}
bee_register_functions_end(beeKeyStage1, viewControllerLoad);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
