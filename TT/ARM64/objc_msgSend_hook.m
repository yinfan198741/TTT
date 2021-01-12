//
//  HookMsgSend.m
//  ArmTest
//
//  Created by fanyin on 2020/10/14.
//



#import "objc_msgSend_hook.h"
#import "fishhook.h"
#include <dispatch/dispatch.h>
 

 
__unused static id (*orig_objc_msgSend)(id, SEL, ...);
 
#define call(b, value) \
__asm volatile ("stp x8, x9, [sp, #-16]!\n"); \
__asm volatile ("mov x12, %0\n" :: "r"(value)); \
__asm volatile ("ldp x8, x9, [sp], #16\n"); \
__asm volatile (#b " x12\n");

#define save() \
__asm volatile ( \
"stp x8, x9, [sp, #-16]!\n" \
"stp x6, x7, [sp, #-16]!\n" \
"stp x4, x5, [sp, #-16]!\n" \
"stp x2, x3, [sp, #-16]!\n" \
"stp x0, x1, [sp, #-16]!\n");

#define load() \
__asm volatile ( \
"ldp x0, x1, [sp], #16\n" \
"ldp x2, x3, [sp], #16\n" \
"ldp x4, x5, [sp], #16\n" \
"ldp x6, x7, [sp], #16\n" \
"ldp x8, x9, [sp], #16\n" );

#define link(b, value) \
__asm volatile ("stp x8, lr, [sp, #-16]!\n"); \
__asm volatile ("sub sp, sp, #16\n"); \
call(b, value); \
__asm volatile ("add sp, sp, #16\n"); \
__asm volatile ("ldp x8, lr, [sp], #16\n");

#define ret() __asm volatile ("ret\n");

void before_objc_msgSend(id self, SEL _cmd, uintptr_t lr) {
//	printf("before_objc_msgSend");
}

uintptr_t after_objc_msgSend() {
//	printf("after_objc_msgSend");
	return 0;
}

static long value = before_objc_msgSend;
__attribute__((__naked__))
static void hook_Objc_msgSend() {
	// Save parameters.
	save()
	
	__asm volatile ("mov x2, lr\n");
	__asm volatile ("mov x3, x4\n");
	
	// Call our before_objc_msgSend.
//	call(blr, &before_objc_msgSend)
	
	
	__asm volatile ("stp x8, x9, [sp, #-16]!\n"); \
	__asm volatile ("mov x12, %0\n" :: "r"(value)); \
	__asm volatile ("ldp x8, x9, [sp], #16\n"); \
	__asm volatile ("blr x12\n");
	
	
	// Load parameters.
	load()
	
	// Call through to the original objc_msgSend.
	call(blr, orig_objc_msgSend)
	
	// Save original objc_msgSend return value.
	save()
	
	// Call our after_objc_msgSend.
	call(blr, &after_objc_msgSend)
	
	// restore lr
	__asm volatile ("mov lr, x0\n");
	
	// Load original objc_msgSend return value.
	load()
	
	// return
	ret()
}
 
#pragma mark public
 
// 启动Hook 入口
void hookStart() {
	static dispatch_once_t onceToken;
 
	dispatch_once(&onceToken, ^{
		rebind_symbols((struct rebinding[6]){
			{
	   "objc_msgSend",
	   (void *)hook_Objc_msgSend,
	   (void **)&orig_objc_msgSend
	  },
		}, 1);
	});
}
