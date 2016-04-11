//
//  XMLParser.h
//  FAQ
//
//  Created by jayaprada on 05/04/16.
//  Copyright © 2016 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface XMLParser : NSObject<NSXMLParserDelegate>{
    

NSString *xmlStr;
DataModel *model;
}
@property(strong,nonatomic)NSMutableArray *dataArray;
-(void)startXML;

@end
