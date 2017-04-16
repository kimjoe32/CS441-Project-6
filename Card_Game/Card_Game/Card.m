//
//  Card.m
//  Card_Game
//
//  Created by Matt Perl on 4/16/17.
//  Copyright © 2017 Matt Perl & Joe Kim. All rights reserved.
//

#import "Card.h"

@implementation Card

-(Card *) init: (NSString *) cardName{
    [self setCardString:cardName];
    
    //possible error here
    NSMutableString *imageName = [NSMutableString stringWithString:cardName];
    [imageName appendString:@".png"];
    
    [self setCardImg:[UIImage imageNamed:imageName]];
    return self;
}

@end
