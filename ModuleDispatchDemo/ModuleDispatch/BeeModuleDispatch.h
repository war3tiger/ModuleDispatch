//
//  BeeModuleDispatch.h
//  Modules
//
//  Created by zyh on 2019/1/23.
//  Copyright © 2019年 Bee. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - stage key
/*
 这里可以根据需求自定义类型。
*/
#define beeKeyStage1 "stage1"

#pragma mark - type definition
typedef void (*beeModuleFunction)(void);

typedef struct BeeModuleNode {
    const char * const key;
    beeModuleFunction fp;
    struct BeeModuleNode *next;
} BeeModuleNode_T;

#define BEE_SEGMENT "BEE_SEGMENT"

#pragma mark - Methods
void bee_execute_for_stage(const char *stage);

/*
 functionName:函数名称
 stage:要在哪个阶段执行
 start、end必须配套使用!
*/
#define bee_register_functions_start(functionName) \
static void bee_##functionName(void)

#define bee_register_functions_end(stage, functionName) \
static BeeModuleNode_T bee_##functionName##_ptr __attribute__((used, section("__DATA" "," BEE_SEGMENT))) = \
{ \
stage, \
bee_##functionName, \
NULL, \
}
