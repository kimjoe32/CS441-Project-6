//
//  Player.m
//  Card_Game
//
//  Created by ETS Admin on 4/16/17.
//  Copyright © 2017 Matt Perl & Joe Kim. All rights reserved.
//
#import "Player.h"

@implementation Player
@synthesize hand;
@synthesize money;

-(Player*) init
{
    self = [super init];
    money = 500;
    hand = [[Hand alloc] init];
    return self;
}

- (void) receiveCards: (Card*) card1
                card2:(Card*) card2
                card3:(Card*) card3
                card4:(Card*) card4
                card5:(Card*) card5
{
    [hand addCardObjects:card1 card2:card2 card3:card3 card4:card4 card5:card5];
}

- (void) addMoney: (NSInteger) m label:(UILabel*) lbl;
{
    money += m;
    [lbl setText:[NSString stringWithFormat:@"%ld", m]];
}

- (void) subtractMoney: (NSInteger) m label:(UILabel*) lbl;
{
    money -= m;
    [lbl setText:[NSString stringWithFormat:@"%ld", m]];
}

- (void) clearHand
{
    [hand clearHand];
}

- (NSInteger) compareHandAgainst: (Player*) player2
{
    return [hand checkWinnerAgainst:player2.hand];
}

- (void) setStoryboardCardsToThisPlayerCards:(NSArray*) storyboardCards
{
    for (int i =0; i < 5; i++)
    {
        UIImageView* sbCard = (UIImageView*) [storyboardCards objectAtIndex:i];
        [sbCard setImage:[[hand.cardObjsInHand objectAtIndex:i] cardImg]];
    }
}
@end
