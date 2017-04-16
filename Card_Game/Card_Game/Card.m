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
    [self setCardImg:[UIImage imageNamed:cardName]];
    return self;
}

@end
