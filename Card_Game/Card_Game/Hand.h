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
- (Hand*) init: (NSString*) card1
              card2:(NSString*) card2
              card3:(NSString*) card3
              card4:(NSString*) card4
              card5:(NSString*) card5;
@end
