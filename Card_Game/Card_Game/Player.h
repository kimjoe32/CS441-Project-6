//
//  Player.h
//  Card_Game
//
//  Created by ETS Admin on 4/16/17.
//  Copyright © 2017 Matt Perl & Joe Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Hand.h"
@interface Player : NSObject
@property (strong, nonatomic) Hand* hand;
@property (nonatomic) float money;
@end
