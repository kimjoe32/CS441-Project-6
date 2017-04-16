//
//  Deck.m
//  Card_Game
//
//  Created by Matt Perl on 4/16/17.
//  Copyright © 2017 Matt Perl & Joe Kim. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@implementation Deck

-(Deck *) init{
    
    int currentCard;
    NSString *currentCardStr;
    for(int i = 0; i < 4; ++i){
        
        for(int j = 0; j < 13; j++){
            currentCard = j+2;
            
            //clubs
            if(i == 0){
                
                if(j == 8){ //ten
                    currentCardStr = @"TC";
                }
                else if(j == 9){ //jack
                    currentCardStr = @"JC";
                }
                else if(j == 10){ //queen
                    currentCardStr = @"QC";
                }
                else if(j == 11){ //king
                    currentCardStr = @"KC";
                }
                else if(j == 12){ //ace
                    currentCardStr = @"AC";
                }
                else{ //number cards
                    currentCardStr = [NSString stringWithFormat:@"%iC", currentCard];
                }
                Card *newCard = [[Card alloc] init:currentCardStr];
                [self addCardToDeck:newCard];
            }
            else if(i == 1){ //spades
                
                if(j == 8){ //ten
                    currentCardStr = @"TS";
                }
                else if(j == 9){ //jack
                    currentCardStr = @"JS";
                }
                else if(j == 10){ //queen
                    currentCardStr = @"QS";
                }
                else if(j == 11){ //king
                    currentCardStr = @"KS";
                }
                else if(j == 12){ //ace
                    currentCardStr = @"AS";
                }
                else{ //number cards
                    currentCardStr = [NSString stringWithFormat:@"%iS", currentCard];
                }
                Card *newCard = [[Card alloc] init:currentCardStr];
                [self addCardToDeck:newCard];
            }
            else if(i == 2){ //hearts
                
                if(j == 8){ //ten
                    currentCardStr = @"TH";
                }
                else if(j == 9){ //jack
                    currentCardStr = @"JH";
                }
                else if(j == 10){ //queen
                    currentCardStr = @"QH";
                }
                else if(j == 11){ //king
                    currentCardStr = @"KH";
                }
                else if(j == 12){ //ace
                    currentCardStr = @"AH";
                }
                else{ //number cards
                    currentCardStr = [NSString stringWithFormat:@"%iH", currentCard];
                }
                Card *newCard = [[Card alloc] init:currentCardStr];
                [self addCardToDeck:newCard];
            }
            else{ //diamonds
                
                if(j == 8){ //ten
                    currentCardStr = @"TD";
                }
                else if(j == 9){ //jack
                    currentCardStr = @"JD";
                }
                else if(j == 10){ //queen
                    currentCardStr = @"QD";
                }
                else if(j == 11){ //king
                    currentCardStr = @"KD";
                }
                else if(j == 12){ //ace
                    currentCardStr = @"AD";
                }
                else{ //number cards
                    currentCardStr = [NSString stringWithFormat:@"%iD", currentCard];
                }
                Card *newCard = [[Card alloc] init:currentCardStr];
                [self addCardToDeck:newCard];
            }
        }
    }
    
    return self;
}

- (void) addCardToDeck: (Card *) card{
    [[self cardArr] addObject:card];
}

- (void) removeCardFromDeck: (int) index{
    [[self cardArr] removeObjectAtIndex:index];
}

- (void) shuffleCards{
    
}

@end
