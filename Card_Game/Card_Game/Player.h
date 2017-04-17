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
@property (nonatomic) NSInteger money;

-(Player*) init;

- (void) receiveCards: (Card*) card1
                card2:(Card*) card2
                card3:(Card*) card3
                card4:(Card*) card4
                card5:(Card*) card5;

- (void) addMoney: (NSInteger) m;
- (void) subtractMoney: (NSInteger) m;
- (void) clearHand;
- (NSInteger) compareHandAgainst: (Player*) player2;
- (void) setStoryboardCardsToThisPlayerCards:(NSArray*) storyboardCards;
@end
