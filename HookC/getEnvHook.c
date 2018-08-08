//
//  getEnvHook.c
//  HookC
//
//  Created by fanyin on 2018/8/6.
//  Copyright © 2018 fanyin. All rights reserved.
//

#include "getEnvHook.h"

#import <dlfcn.h>
#import <assert.h>
#import <stdio.h>
#import <dispatch/dispatch.h>
#import <string.h>



char * getenv(const char *name) {
    static void* handle;
    static char* (*fgetEnv)(char*);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = dlopen("/usr/lib/system/libsystem_c.dylib", RTLD_NOW);
        assert(handle);
        fgetEnv = dlsym(handle, "getenv");
        printf("Real getenv: %p\nFake getenv: %p\n", fgetEnv, getenv);
//        fgetEnv f = real_getenv;
       
    });
     printf(fgetEnv("HOME"));
//    void *handle = dlopen("/usr/lib/system/libsystem_c.dylib", RTLD_NOW);
//    assert(handle);
//    void *real_getenv = dlsym(handle, "getenv");
//    printf("Real getenv: %p\nFake getenv: %p\n", real_getenv, getenv);
//    fgetEnv f = real_getenv;
//    printf(f("HOME"));
    return "YAY!";
}
