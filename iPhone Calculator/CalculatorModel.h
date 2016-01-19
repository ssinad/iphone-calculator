//
//  CalculatorModel.h
//  iPhone Calculator
//
//  Created by SS D on 29/10/1394 AP.
//  Copyright © 1394 SS D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject
typedef NS_ENUM(NSUInteger, CalculatorState) {
    CalculatorStateInitial,
    CalculatorStateOperatorSelected,
    CalculatorStateEnteringNumber
};
@property (readonly) CalculatorState state;
@end
