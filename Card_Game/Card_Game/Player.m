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
@synthesize handType;
@synthesize money;

-(Player*) init
{
    self = [super init];
    money = 500;
    hand = [[Hand alloc] init];
    handType = @"noHand";
    return self;
}

- (void) receiveCards: (Card*) card1
                card2:(Card*) card2
                card3:(Card*) card3
                card4:(Card*) card4
                card5:(Card*) card5
{
    [hand addCardObjects:card1 card2:card2 card3:card3 card4:card4 card5:card5];
    [self hasHandType];
}

- (void) hasHandType
{
    if ([handType isEqualToString:@"noHand"])
    {
        handType = [hand checkHand];
        if ([handType isEqualToString: @"RF"])
            handType = @"Royal Flush";
        else if ([handType isEqualToString: @"SF"])
            handType = @"Straight Flush";
        else if ([handType isEqualToString: @"4K"])
            handType = @"Four of a Kind";
        else if ([handType isEqualToString: @"FH"])
            handType = @"Full House";
        else if ([handType isEqualToString: @"F"])
            handType = @"Flush";
        else if ([handType isEqualToString: @"S"])
            handType = @"Straight";
        else if ([handType isEqualToString: @"3K"])
            handType = @"Three of a Kind";
        else if ([handType isEqualToString: @"2P"])
            handType = @"Two Pair";
        else if ([handType isEqualToString: @"P"])
            handType = @"Pair";
        else if ([handType isEqualToString: @"HC"])
            handType = @"High Card";
    }
}

- (NSString*) getHandType
{
    [self hasHandType];
    return handType;
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

- (void) printCards
{
    [hand printCards];
}

- (void) clearHand
{
    [hand clearHand];
    handType = @"noHand";
}

- (NSInteger) compareHandAgainst: (Player*) player2
{
    [self hasHandType];
    [player2 hasHandType];
    return [hand checkWinnerAgainst:player2.hand
                           p1result:handType
                           p2result:player2.handType];
}

- (void) setStoryboardCardsToThisPlayerCards:(NSArray*) storyboardCards
{
    for (int i =0; i < 5; i++)
    {
        UIImageView* sbCard = (UIImageView*) [storyboardCards objectAtIndex:i];
        sbCard.alpha = 0;
        
        [UIView animateWithDuration:1
                         animations:^{
                             sbCard.alpha=1;
                         } completion:^(BOOL finished){
                             if (finished) {
                                 sbCard.alpha = 1;
                             }
                         }];
        [sbCard setImage:[[hand.cardObjsInHand objectAtIndex:i] cardImg]];
    }
}
@end
