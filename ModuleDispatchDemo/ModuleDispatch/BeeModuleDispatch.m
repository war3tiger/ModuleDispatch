//
//  BeeModuleDispatch.m
//  Modules
//
//  Created by zyh on 2019/1/23.
//  Copyright © 2019年 Bee. All rights reserved.
//
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>
#include <mach-o/ldsyms.h>
#include <string.h>

#import "BeeModuleDispatch.h"

BeeModuleNode_T *beeModuleHead = NULL;
BeeModuleNode_T *beeModuleTail = NULL;

#pragma mark - Public Methods
void bee_execute_for_stage(const char *stage) {
    @autoreleasepool {
        BeeModuleNode_T *p = beeModuleHead;
        while (p) {
            if (strcmp(p->key, stage) == 0) {
                p->fp();
            }
            p = p->next;
        }
    }
}

#pragma mark - Private Methods
static void bee_dyld_callback(const struct mach_header *mhp, intptr_t vmaddr_slide)
{
    unsigned long size = 0;
#ifndef __LP64__
    BeeModuleNode_T *memory = (BeeModuleNode_T *)getsectiondata(mhp, SEG_DATA, BEE_SEGMENT, &size);
#else
    const struct mach_header_64 *mhp64 = (const struct mach_header_64 *)mhp;
    BeeModuleNode_T *memory = (BeeModuleNode_T *)getsectiondata(mhp64, SEG_DATA, BEE_SEGMENT, &size);
#endif
    if (size <= 1) {
        return;
    }
    unsigned long counter = size/sizeof(BeeModuleNode_T);
    if (!beeModuleHead) {
        beeModuleHead = memory;
        beeModuleTail = memory;
    }
    for(int idx = 1; idx < counter; ++idx){
        beeModuleTail->next = memory + idx;
        beeModuleTail = beeModuleTail->next;
        beeModuleTail->next = NULL;
    }
}

__attribute__((constructor))
static void bee_set_dyld_image_callback(void) {
    _dyld_register_func_for_add_image(bee_dyld_callback);
}
