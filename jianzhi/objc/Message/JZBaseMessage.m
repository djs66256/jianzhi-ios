//
//  JZBaseMessage.m
//  jianzhi
//
//  Created by daniel on 16/2/3.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

#import "JZBaseMessage.h"

@implementation JZBaseMessage

- (NSUInteger)messageHash {
    return _isMediaMessage ? _media.hash : _text.hash;
}

@end
