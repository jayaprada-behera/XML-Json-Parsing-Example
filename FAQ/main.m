//
//  main.m
//  FAQ
//
//  Created by Aravind on 29/01/16.
//  Copyright © 2016 Aravind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#if DEBUG == 0
#define DebugLog(...)
#elif DEBUG == 1
#define DebugLog(...) NSLog(__VA_ARGS__)
#endif
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
