//
//  Deck.h
//  Card_Game
//
//  Created by Matt Perl on 4/16/17.
//  Copyright © 2017 Matt Perl & Joe Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (Deck *) init;
- (void) addCardToDeck: (Card *) card;
- (void) removeCardFromDeck: (int) index;
- (void) clearDeck;
- (void) remakeDeck;
- (void) shuffleDeck;

@property (nonatomic, strong) NSMutableArray *cardArr;

@end
