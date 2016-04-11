//
//  DataModel.h
//  FAQ
//
//  Created by jayaprada on 05/04/16.
//  Copyright © 2016 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataModel : NSObject
@property(strong,nonatomic)NSString *title;
@property(strong,nonatomic)NSString *desc;
@property(strong,nonatomic)NSString *itemtTitle;
@property(strong,nonatomic)NSString *imgURLString;
@property(strong,nonatomic)UIImage *modelImg;
 @end
