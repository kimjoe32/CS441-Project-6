//
//  Hand.h
//  Card_Game
//
//  Created by ETS Admin on 4/16/17.
//  Copyright © 2017 Matt Perl & Joe Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Hand : NSObject  {
    
}

@property (weak) NSMutableArray* cardsInHand;
- (Hand*) init;
- (void) addCards: (NSString*) card1
              card2:(NSString*) card2
              card3:(NSString*) card3
              card4:(NSString*) card4
              card5:(NSString*) card5;
- (NSString*) checkHand;
- (NSInteger) checkWinnerAgainst: (Hand*) p2;
- (NSInteger) compare: (NSString*) s1
                   s2: (NSString*) s2;

@end
