//
//  SingletonClass.h
//  Share_Car_iOS
//
//  Created by Wissem Rezgui on 01/12/2014.
//  Copyright (c) 2014 Wissem Rezgui. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SingletonClass : NSObject {
    NSString *url;

    
}
@property (nonatomic, retain) NSString *url;


+ (id)sharedURL;


@end
