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

- (Hand*) init: (NSString*) card1
         card2:(NSString*) card2
         card3:(NSString*) card3
         card4:(NSString*) card4
         card5:(NSString*) card5
{
    self = [super init];
    cardsInHand = [NSMutableArray arrayWithObjects:card1,card2,card3,card4,card5,nil];
    //sort strings based on card#
    [cardsInHand sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *object1 = (NSString*)obj1;
        NSString *object2 = (NSString*)obj2;
        return [object1 compare:object2];
    }];
    [self sortAgain:cardsInHand];
    [self initValues];
    return self;
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
    NSString* card1Num = [[cardsInHand objectAtIndex:0] substringToIndex:1];
    NSString* card2Num = [[cardsInHand objectAtIndex:0] substringToIndex:1];
    NSString* card3Num = [[cardsInHand objectAtIndex:0] substringToIndex:1];
    NSString* card4Num = [[cardsInHand objectAtIndex:0] substringToIndex:1];
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
    return ([values objectForKey:s1] > [values objectForKey:s2]) ? 1 : 0;
}

- (void) sortAgain: (NSMutableArray*) arr
{
    for(int i = 0; i < 4; i++)
    {
        if ([[cardsInHand objectAtIndex:i] hasPrefix:@"T"])
        {
            for (int j = i; j< 4; j++)
            {
                if (arr[j][0] == arr[j+1][0] && j+2 < 5)
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
                if (arr[j][0] == arr[j+1][0] && j+2 < 5)
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
                if (arr[j][0] == arr[j+1][0] && j+2 < 5)
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
                if (arr[j][0] == arr[j+1][0] && j+2 < 5)
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
                if (arr[j][0] == arr[j+1][0] && j+2 < 5)
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

