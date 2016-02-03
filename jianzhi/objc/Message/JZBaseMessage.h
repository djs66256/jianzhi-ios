//
//  JZBaseMessage.h
//  jianzhi
//
//  Created by daniel on 16/2/3.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSQMessage.h>

@interface JZBaseMessage : NSObject <JSQMessageData>

@property (copy, nonatomic, readonly) NSString *senderId;
@property (copy, nonatomic, readonly) NSString *senderDisplayName;
@property (copy, nonatomic) NSDate *date;
@property (assign, nonatomic, readonly) BOOL isMediaMessage;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) id<JSQMessageMediaData> media;

@end
