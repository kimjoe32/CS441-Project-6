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
    //need super init here??
    self = [super init];
    self.cardArr = [[NSMutableArray alloc] init];
    
    [self remakeDeck];
    //NSLog(@"%lu\n", (unsigned long)[[self cardArr] count]);
    return self;
}

- (void) addCardToDeck: (Card *) card{
    [[self cardArr] addObject:card];
}

- (Card *) removeCardFromDeck: (int) index{
    
    Card *ret = [[self cardArr] objectAtIndex:index];
    
    [[self cardArr] removeObjectAtIndex:index];
    
    return ret;
}

- (void) clearDeck{
    
    [[self cardArr] removeAllObjects];
}

- (void) remakeDeck{
    int currentCard;
    for(int i = 0; i < 4; ++i){
        
        for(int j = 0; j < 13; j++){
            NSString *currentCardStr;
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
                Card *newCard = [[Card alloc] init];
                [newCard setCardString:currentCardStr];
                [newCard setCardImg:[UIImage imageNamed:currentCardStr]];
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
                Card *newCard = [[Card alloc] init];
                [newCard setCardString:currentCardStr];
                [newCard setCardImg:[UIImage imageNamed:currentCardStr]];
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
                Card *newCard = [[Card alloc] init];
                [newCard setCardString:currentCardStr];
                [newCard setCardImg:[UIImage imageNamed:currentCardStr]];
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
                Card *newCard = [[Card alloc] init];
                [newCard setCardString:currentCardStr];
                [newCard setCardImg:[UIImage imageNamed:currentCardStr]];
                [self addCardToDeck:newCard];
            }
        }
    }
}

- (NSInteger) count
{
    return [_cardArr count];
}

- (void) shuffleDeck{
    
    int ind1 = 0;
    int ind2 = 0;
    NSInteger upperBound = ([[self cardArr] count])-1;
    for(int i = 0; i < 100; ++i){
        ind1 = 0;
        ind2 = 0;
        while(ind1 == ind2){
            ind1 = arc4random_uniform((u_int32_t)upperBound);
            ind2 = arc4random_uniform((u_int32_t)upperBound);
            //printf("%d, %d\n", ind1, ind2);
        }
        
        [[self cardArr] exchangeObjectAtIndex:ind1 withObjectAtIndex:ind2];
    }
}

@end
