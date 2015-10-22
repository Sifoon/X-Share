//
//  SingletonClass.m
//  Share_Car_iOS
//
//  Created by Wissem Rezgui on 01/12/2014.
//  Copyright (c) 2014 Wissem Rezgui. All rights reserved.
//

#import "SingletonClass.h"

@implementation SingletonClass
@synthesize url;



#pragma mark Singleton Methods

+ (id)sharedURL {
    static SingletonClass *sharedURL = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedURL = [[self alloc] init];
    });
    return sharedURL;
}


- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
