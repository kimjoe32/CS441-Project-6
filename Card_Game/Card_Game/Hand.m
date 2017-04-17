//
//  Hand.m
//  Card_Game
//
//  Created by ETS Admin on 4/16/17.
//  Copyright © 2017 Matt Perl & Joe Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hand.h"
@implementation Hand
@synthesize cardsInHand;
@synthesize cardObjsInHand;

NSMutableDictionary * values;

- (void) initValues
{
    values = [NSMutableDictionary dictionaryWithCapacity:13];
    [values setObject:[NSNumber numberWithInt:1] forKey:@"2"];
    [values setObject:[NSNumber numberWithInt:2] forKey:@"3"];
    [values setObject:[NSNumber numberWithInt:3] forKey:@"4"];
    [values setObject:[NSNumber numberWithInt:4] forKey:@"5"];
    [values setObject:[NSNumber numberWithInt:5] forKey:@"6"];
    [values setObject:[NSNumber numberWithInt:6] forKey:@"7"];
    [values setObject:[NSNumber numberWithInt:7] forKey:@"8"];
    [values setObject:[NSNumber numberWithInt:8] forKey:@"9"];
    [values setObject:[NSNumber numberWithInt:9] forKey:@"T"];
    [values setObject:[NSNumber numberWithInt:10] forKey:@"J"];
    [values setObject:[NSNumber numberWithInt:11] forKey:@"Q"];
    [values setObject:[NSNumber numberWithInt:12] forKey:@"K"];
    [values setObject:[NSNumber numberWithInt:13] forKey:@"A"];
}

-(Hand*) init
{
    self = [super init];
    cardsInHand = [NSMutableArray arrayWithObjects:@"NoCard",@"NoCard",@"NoCard",@"NoCard",@"NoCard",nil];
    [self initValues];
    return self;
}

- (void) addCardObjects: (Card*) card1
            card2: (Card*) card2
            card3: (Card*) card3
            card4: (Card*) card4
            card5: (Card*) card5
{
    cardObjsInHand = [NSMutableArray arrayWithObjects:card1,card2,card3,card4,card5,nil];
    [self addCards:card1.cardString card2:card2.cardString card3:card3.cardString card4:card4.cardString card5:card5.cardString];
}

- (void) addCards: (NSString*) card1
         card2:(NSString*) card2
         card3:(NSString*) card3
         card4:(NSString*) card4
         card5:(NSString*) card5
{
    cardsInHand = [NSMutableArray arrayWithObjects:card1,card2,card3,card4,card5,nil];
    //sort strings based on card#
    [cardsInHand sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self sortAgain];
}

- (BOOL) checkSequentialCards
{
    NSString * dictKey0 = [[cardsInHand objectAtIndex:0] substringToIndex:1];
    NSString * dictKey1 = [[cardsInHand objectAtIndex:1] substringToIndex:1];
    NSString * dictKey2 = [[cardsInHand objectAtIndex:2] substringToIndex:1];
    NSString * dictKey3 = [[cardsInHand objectAtIndex:3] substringToIndex:1];
    NSString * dictKey4 = [[cardsInHand objectAtIndex:4] substringToIndex:1];
    return ([[values objectForKey:dictKey1] intValue] - [[values objectForKey:dictKey0] intValue] == 1 &&
            [[values objectForKey:dictKey2] intValue] - [[values objectForKey:dictKey1] intValue] == 1 &&
            [[values objectForKey:dictKey3] intValue] - [[values objectForKey:dictKey2] intValue] == 1 &&
            [[values objectForKey:dictKey4] intValue] - [[values objectForKey:dictKey3] intValue] == 1);
}

- (BOOL) checkSameSuit
{
    NSString * dictKey0 = [[cardsInHand objectAtIndex:0] substringFromIndex:1];
    NSString * dictKey1 = [[cardsInHand objectAtIndex:1] substringFromIndex:1];
    NSString * dictKey2 = [[cardsInHand objectAtIndex:2] substringFromIndex:1];
    NSString * dictKey3 = [[cardsInHand objectAtIndex:3] substringFromIndex:1];
    NSString * dictKey4 = [[cardsInHand objectAtIndex:4] substringFromIndex:1];
    
    return [dictKey0 isEqualToString:dictKey1] &&
    [dictKey1 isEqualToString:dictKey2] &&
    [dictKey2 isEqualToString:dictKey3] &&
    [dictKey3 isEqualToString:dictKey4];
}

- (NSString*) checkHand
{
    NSString* card0Num = [[cardsInHand objectAtIndex:0] substringToIndex:1];
    NSString* card1Num = [[cardsInHand objectAtIndex:1] substringToIndex:1];
    NSString* card2Num = [[cardsInHand objectAtIndex:2] substringToIndex:1];
    NSString* card3Num = [[cardsInHand objectAtIndex:3] substringToIndex:1];
    NSString* card4Num = [[cardsInHand objectAtIndex:4] substringToIndex:1];
    //royal flush
    if ([self checkSequentialCards] && [self checkSameSuit] &&
        [[[cardsInHand objectAtIndex:0] substringToIndex:1] isEqualToString:@"T"]) return @"RF";
    
    //straight flush
    if ([self checkSequentialCards] && [self checkSameSuit]) return @"SF";
    
    //4 of a kind
    if ([card0Num isEqualToString:card1Num] &&
        [card1Num isEqualToString:card2Num] &&
        [card2Num isEqualToString:card3Num])
    {
        return @"4K";
    }
    if ([card1Num isEqualToString:card2Num] &&
        [card2Num isEqualToString:card3Num] &&
        [card3Num isEqualToString:card4Num])
    {
        [cardsInHand exchangeObjectAtIndex:4 withObjectAtIndex:0];
        return @"4K";
    }
    //full house -- check for 2 + 3 or 3 + 2
    if (([card0Num isEqualToString:card1Num] &&[card1Num isEqualToString:card2Num]) &&
        [card3Num isEqualToString:card4Num])
    {
        return @"FH";
    }
    if (([card2Num isEqualToString:card3Num] &&[card3Num isEqualToString:card4Num]) &&
        [card0Num isEqualToString:card1Num])
    {
        [cardsInHand exchangeObjectAtIndex:4 withObjectAtIndex:0];
        [cardsInHand exchangeObjectAtIndex:1 withObjectAtIndex:3];
        return @"FH";
    }
    //flush
    if ([self checkSameSuit]) return @"F";
    
    //straight
    if ([self checkSequentialCards]) return @"S";
    
    //3 of a kind -- check first three or last 3 cards
    if ([card0Num isEqualToString:card1Num] &&
        [card1Num isEqualToString:card2Num] &&
        [card2Num isEqualToString:card3Num])
    {
        return @"3K";
    }
    if ([card1Num isEqualToString:card2Num] &&[card2Num isEqualToString:card3Num])
    {
        [cardsInHand exchangeObjectAtIndex:0 withObjectAtIndex:3];
        return @"3K";
    }
    if ([card2Num isEqualToString:card3Num] &&
        [card3Num isEqualToString:card4Num])
    {
        [cardsInHand exchangeObjectAtIndex:4 withObjectAtIndex:0];
        [cardsInHand exchangeObjectAtIndex:1 withObjectAtIndex:3];
        return @"3K";
    }
    
    //2 of a kind and two pair
    if ([card0Num isEqualToString:card1Num])
    {
        if ([card2Num isEqualToString:card3Num])
        {
            return @"2P";
        }
        if ([card3Num isEqualToString:card4Num])
        {
            [cardsInHand exchangeObjectAtIndex:2 withObjectAtIndex:4];
            return @"2P";
        }
        return @"P";
    }
    if ([card1Num isEqualToString:card2Num])
    {
        if ([card3Num isEqualToString:card4Num])
        {
            [cardsInHand exchangeObjectAtIndex:0 withObjectAtIndex:2];
            [cardsInHand exchangeObjectAtIndex:2 withObjectAtIndex:4];
            return @"2P";
        }
        [cardsInHand exchangeObjectAtIndex:0 withObjectAtIndex:2];
        return @"P";
    }
    if ([card2Num isEqualToString:card3Num])
    {
        [cardsInHand exchangeObjectAtIndex:0 withObjectAtIndex:2];
        [cardsInHand exchangeObjectAtIndex:1 withObjectAtIndex:3];
        return @"P";
    }
    if ([card3Num isEqualToString:card4Num])
    {
        [cardsInHand exchangeObjectAtIndex:0 withObjectAtIndex:3];
        [cardsInHand exchangeObjectAtIndex:1 withObjectAtIndex:4];
        return @"P";
    }
    
    //high card
    return @"HC";
}

- (NSInteger) compare: (NSString*) s1
                     s2: (NSString*) s2
{
    if ([values objectForKey:s1]  == [values objectForKey:s2])
        return -1;
    return ([values objectForKey:s1] < [values objectForKey:s2]);
}

-(NSInteger) checkWinnerAgainst: (Hand*) p2
{
    NSString* p1result = [self checkHand];  //NSLog(@"%@", p1result);
    NSString* p2result = [p2 checkHand];    //NSLog(@"%@", p2result);

//    NSLog(@"%@ %@ %@ %@ %@", [cardsInHand objectAtIndex:0], [cardsInHand objectAtIndex:1], [cardsInHand objectAtIndex:2], [cardsInHand objectAtIndex:3], [cardsInHand objectAtIndex:4] );
//    NSLog(@"%@ %@ %@ %@ %@", [p2.cardsInHand objectAtIndex:0], [p2.cardsInHand objectAtIndex:1], [p2.cardsInHand objectAtIndex:2], [p2.cardsInHand objectAtIndex:3], [p2.cardsInHand objectAtIndex:4] );
    
    NSString* p1card0Num = [[cardsInHand objectAtIndex:0] substringToIndex:1];
    NSString* p1card1Num = [[cardsInHand objectAtIndex:1] substringToIndex:1];
    NSString* p1card2Num = [[cardsInHand objectAtIndex:2] substringToIndex:1];
    NSString* p1card3Num = [[cardsInHand objectAtIndex:3] substringToIndex:1];
    NSString* p1card4Num = [[cardsInHand objectAtIndex:4] substringToIndex:1];

    NSString* p2card0Num = [[p2.cardsInHand objectAtIndex:0] substringToIndex:1];
    NSString* p2card1Num = [[p2.cardsInHand objectAtIndex:1] substringToIndex:1];
    NSString* p2card2Num = [[p2.cardsInHand objectAtIndex:2] substringToIndex:1];
    NSString* p2card3Num = [[p2.cardsInHand objectAtIndex:3] substringToIndex:1];
    NSString* p2card4Num = [[p2.cardsInHand objectAtIndex:4] substringToIndex:1];
    // 0 = p wins
    // 1 = p2 wins

    //royal flush
    if ([p1result isEqualToString: @"RF"]) return 1;
    if ([p2result isEqualToString: @"RF"]) return 0;

    //straight flush
    if ([p1result isEqualToString: @"SF"] && [p2result isEqualToString: @"SF"])
    {
        return [self compare:p1card0Num s2:p2card0Num];
    }

    if ([p1result isEqualToString: @"SF"]) return 1;
    if ([p2result isEqualToString: @"SF"]) return 0;

    //4 of a kind
    if (([p1result isEqualToString: @"4K"]) && ([p2result isEqualToString: @"4K"]))
    {
        NSInteger result = [self compare:p1card0Num s2:p2card0Num];
        if (result == -1)
        {
            return [self compare:p1card4Num s2:p2card4Num];
        }
        return result;
    }

    if ([p1result isEqualToString: @"4K"]) return 1;
    if ([p2result isEqualToString: @"4K"]) return 0;

    //full house
    if (([p1result isEqualToString: @"FH"]) && ([p2result isEqualToString: @"FH"]))
    {
        NSInteger result = [self compare:p1card0Num s2:p2card0Num];
        if (result == -1) 
        {
            return [self compare:p1card3Num s2:p2card3Num];
        }
        return result;
    }

    if ([p1result isEqualToString: @"FH"]) return 1;
    if ([p2result isEqualToString: @"FH"]) return 0;

    //flush
    if ([p1result isEqualToString: @"F"] && [p2result isEqualToString: @"F"])
    {
        NSInteger result = [self compare:p1card4Num s2:p2card4Num];
        if (result != -1) return result;
        
        result = [self compare:p1card3Num s2:p2card3Num];
        if (result != -1) return result;
        
        result = [self compare:p1card2Num s2:p2card2Num];
        if (result != -1) return result;
        
        result = [self compare:p1card1Num s2:p2card1Num];
        if (result != -1) return result;
        
        result = [self compare:p1card0Num s2:p2card0Num];
        if (result != -1) return result;
    }
    if ([p1result isEqualToString: @"F"]) return 1;
    if ([p2result isEqualToString: @"F"]) return 0;

    //straight
    if ([p1result isEqualToString: @"S"] && [p2result isEqualToString: @"S"])
    {
        return [self compare:p1card4Num s2:p2card4Num];
    }
    if ([p1result isEqualToString: @"S"]) return 1;
    if ([p2result isEqualToString: @"S"]) return 0;

    //3 of a kind
    if (([p1result isEqualToString: @"3K"]) && ([p2result isEqualToString: @"3K"]))
    {
        NSInteger result = [self compare:p1card4Num s2:p2card4Num];
        if (result == -1)
        {
            return [self compare:p1card3Num s2:p2card3Num];
        }
        return result;
    }

    if (([p1result isEqualToString: @"3K"] || [p1result isEqualToString: @"3K"])) return 1;
    if (([p2result isEqualToString: @"3K"] || [p2result isEqualToString: @"3K"])) return 0;

    if (([p1result isEqualToString: @"2P"]) && ([p2result isEqualToString: @"2P"]) )
    {
        NSInteger result = [self compare:p1card2Num s2:p2card2Num];
        if (result == -1)
        {
            result = [self compare:p1card0Num s2:p2card0Num];
            if (result == -1) return [self compare:p1card4Num s2:p2card4Num];
        }
        return result;
    }
    if ([p1result isEqualToString: @"2P"]) return 1;
    if ([p2result isEqualToString: @"2P"]) return 0;

    if (([p1result isEqualToString: @"P"]) && ([p2result isEqualToString: @"P"]))
    {
        NSInteger result = [self compare:p1card0Num s2:p2card0Num];
        if (result == -1){
            result = [self compare:p1card4Num s2:p2card4Num];
            if (result != -1) return result;
            
            result = [self compare:p1card3Num s2:p2card3Num];
            if (result != -1) return result;
            
            result = [self compare:p1card2Num s2:p2card2Num];
            if (result != -1) return result;
            
            result = [self compare:p1card1Num s2:p2card1Num];
            if (result != -1) return result;
        }
        return result;
    }

    if ([p1result isEqualToString: @"P"]) return 1;
    if ([p2result isEqualToString: @"P"]) return 0;    

    //high card
    NSInteger result = [self compare:p1card4Num s2:p2card4Num];
    if (result != -1) return result;
    
    result = [self compare:p1card3Num s2:p2card3Num];
    if (result != -1) return result;
    
    result = [self compare:p1card2Num s2:p2card2Num];
    if (result != -1) return result;
    
    result = [self compare:p1card1Num s2:p2card1Num];
    if (result != -1) return result;
    
    result = [self compare:p1card0Num s2:p2card0Num];
    if (result != -1) return result;

    return -1;
}

- (void) sortAgain
{
    for(int i = 0; i < 4; i++)
    {
        if ([[cardsInHand objectAtIndex:i] hasPrefix:@"T"])
        {
            for (int j = i; j< 4; j++)
            {
                if ([[[cardsInHand objectAtIndex:j] substringToIndex:1] isEqualToString:
                    [[cardsInHand objectAtIndex:j+1] substringToIndex:1]] && j+2 < 5)
                    //arr[j][0] == arr[j+1][0] && j+2 < 5)
                {
                    [cardsInHand exchangeObjectAtIndex:j withObjectAtIndex:j+2];
                }
                else
                    [cardsInHand exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    for(int i = 0; i < 4; i++)
    {
        if ([[cardsInHand objectAtIndex:i] hasPrefix:@"J"])
        {
            for (int j = i; j< 4; j++)
            {
                if ([[[cardsInHand objectAtIndex:j] substringToIndex:1] isEqualToString:
                     [[cardsInHand objectAtIndex:j+1] substringToIndex:1]] && j+2 < 5)
                {
                    [cardsInHand exchangeObjectAtIndex:j withObjectAtIndex:j+2];
                }
                else
                    [cardsInHand exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    for(int i = 0; i < 4; i++)
    {
        if ([[cardsInHand objectAtIndex:i] hasPrefix:@"Q"])
        {
            for (int j = i; j< 4; j++)
            {
                if ([[[cardsInHand objectAtIndex:j] substringToIndex:1] isEqualToString:
                     [[cardsInHand objectAtIndex:j+1] substringToIndex:1]] && j+2 < 5)
                {
                    [cardsInHand exchangeObjectAtIndex:j withObjectAtIndex:j+2];
                }
                else
                    [cardsInHand exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    for(int i = 0; i < 4; i++)
    {
        if ([[cardsInHand objectAtIndex:i] hasPrefix:@"K"])
        {
            for (int j = i; j< 4; j++)
            {
                if ([[[cardsInHand objectAtIndex:j] substringToIndex:1] isEqualToString:
                     [[cardsInHand objectAtIndex:j+1] substringToIndex:1]] && j+2 < 5)
                {
                    [cardsInHand exchangeObjectAtIndex:j withObjectAtIndex:j+2];
                }
                else
                    [cardsInHand exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    for(int i = 0; i < 4; i++)
    {
        if ([[cardsInHand objectAtIndex:i] hasPrefix:@"A"])
        {
            for (int j = i; j< 4; j++)
            {
                if ([[[cardsInHand objectAtIndex:j] substringToIndex:1] isEqualToString:
                     [[cardsInHand objectAtIndex:j+1] substringToIndex:1]] && j+2 < 5)
                {
                    [cardsInHand exchangeObjectAtIndex:j withObjectAtIndex:j+2];
                }
                else
                    [cardsInHand exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
}
@end

