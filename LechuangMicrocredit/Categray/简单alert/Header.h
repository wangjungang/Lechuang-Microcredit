//
//  Header.h
//  ThreadDemo
//
//  Created by LiuTao on 16/6/7.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#ifndef ThreadDemo_Header_h
#define ThreadDemo_Header_h

/// 宏定义多行,宏定义传值
#define  test_view(view)      {view = [[UIView alloc] initWithFrame:CGRectZero];\
NSLog(@"test view");}


#ifndef SINGLETON_FOR_CLASS

/// oc 类,消息机制,都是runtime<运行时>实现的
#import <objc/runtime.h>

#define SINGLETON_FOR_CLASS_HEADER(__CLASSNAME__)	\
\
+ (__CLASSNAME__*) getInstance;	\
+ (void) purgeGetInstance;


#define SINGLETON_FOR_CLASS(__CLASSNAME__)	\
\
static __CLASSNAME__* _##__CLASSNAME__##_getInstance = nil;	\
\
+ (__CLASSNAME__*) getInstanceNoSynch	\
{	\
return (__CLASSNAME__*) _##__CLASSNAME__##_getInstance;	\
}	\
\
+ (__CLASSNAME__*) getInstanceSynch	\
{	\
@synchronized(self){	\
if(nil == _##__CLASSNAME__##_getInstance){	\
_##__CLASSNAME__##_getInstance = [[self alloc] init];	\
}else{	\
NSAssert2(1==0, @"SynthesizeSingleton: %@ ERROR: +(%@ *)getInstance method did not get swizzled.", self, self);	\
}	\
}	\
return (__CLASSNAME__*) _##__CLASSNAME__##_getInstance;	\
}	\
\
+ (__CLASSNAME__*) getInstance	\
{	\
return [self getInstanceSynch]; \
}	\
\
+ (id)allocWithZone:(NSZone*) zone	\
{	\
@synchronized(self){	\
if (nil == _##__CLASSNAME__##_getInstance){	\
_##__CLASSNAME__##_getInstance = [super allocWithZone:zone];	\
if(nil != _##__CLASSNAME__##_getInstance){	\
Method newGetInstanceMethod = class_getClassMethod(self, @selector(getInstanceNoSynch));	\
method_setImplementation(class_getClassMethod(self, @selector(getInstance)), method_getImplementation(newGetInstanceMethod));	\
}	\
}	\
}	\
return _##__CLASSNAME__##_getInstance;	\
}	\
\
+ (void)purgeGetInstance	\
{	\
@synchronized(self){	\
if(nil != _##__CLASSNAME__##_getInstance){	\
Method newSharedInstanceMethod = class_getClassMethod(self, @selector(getInstanceSynch));	\
method_setImplementation(class_getClassMethod(self, @selector(getInstance)), method_getImplementation(newSharedInstanceMethod));	\
_##__CLASSNAME__##_getInstance = nil;	\
}	\
}	\
}	\
\
- (id)copyWithZone:(NSZone *)zone	\
{	\
return self;	\
}

#endif



#endif
