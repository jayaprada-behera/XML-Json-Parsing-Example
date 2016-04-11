//
//  XMLParser.m
//  FAQ
//
//  Created by jayaprada on 05/04/16.
//  Copyright © 2016 Aravind. All rights reserved.
//

#import "XMLParser.h"
#define XML_URL_STRING @"http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=75/xml"

//#define XML_URL_STRING @"http://images.apple.com/main/rss/hotnews/hotnews.rss#sthash.TyhRD7Zy.dpuf"

@implementation XMLParser

-(void)startXML{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:XML_URL_STRING]];
    parser.delegate = self;
    if ([parser parse]) {
        [parser parse];
    }else{
        NSLog(@"There is some error while parsing");
    }
}

#pragma Mark --  NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    if ([elementName isEqualToString:@"feed"]) {
        self.dataArray =[[NSMutableArray alloc] init];//will initialise array after getting my xml main tag
    }
    if ([elementName isEqualToString:@"entry"]) {
        model = [[DataModel alloc] init];
    }
    
}
// sent when the parser finds an element start tag.
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    
    if ([elementName isEqualToString:@"title"]) {
        model.itemtTitle =  xmlStr;
    }else  if ([elementName isEqualToString:@"updated"]){
        model.desc = xmlStr;
    }else  if ([elementName isEqualToString:@"im:image"]){
        model.imgURLString = xmlStr;
    }else if ([elementName isEqualToString:@"entry"]){
        
        [self.dataArray addObject:model];
    }
    
}

// sent when an end tag is encountered. The various parameters are supplied as above.
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    xmlStr = string;
}

@end
