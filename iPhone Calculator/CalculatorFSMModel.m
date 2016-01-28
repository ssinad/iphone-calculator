//
//  CalculatorModel.m
//  iPhone Calculator
//
//  Created by SS D on 29/10/1394 AP.
//  Copyright © 1394 SS D. All rights reserved.
//

#import "CalculatorFSMModel.h"

@interface CalculatorFSMModel ()
@property CalculatorState state;
@property NSDecimalNumber * result;
@property CalculatorOperator lastOperator;
@property NSDecimalNumber * lastOperand;
//@property NSString * evalString;
@property EvaluationModel * evaluationModel;
//-(NSString *)evaluateWithOperand: operand;


@end

@implementation CalculatorFSMModel


-(void)resetAll{
    self.state = CalculatorStateInitial;
    self.result = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.lastOperand = nil;
    self.lastOperator = N;
    self.evaluationModel = [[EvaluationModel alloc]init];
//    self.evalString = @"";
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // superclass successfully initialized, further
        // initialization happens here ...
        [self resetAll];
    }
    return self;
}


-(void)addCharacter{
//    switch (self.state) {
//        case CalculatorStateInitial:
//            break;
//        case CalculatorStateEnteringFirstNumber:
//            break;
//        case CalculatorStateEnteringNumber:
//            break;
//        case CalculatorStateFirstOperatorSelected:
//            break;
//        case CalculatorStateOperatorSelected:
//            break;
//        case CalculatorStateEqual:
//            break;
//        default:
//            break;
//    }

    switch (self.state) {
        case CalculatorStateInitial:
            self.state = CalculatorStateEnteringFirstNumber;
            break;
        case CalculatorStateEnteringFirstNumber:
            self.state = CalculatorStateEnteringFirstNumber;
            break;
        case CalculatorStateEnteringNumber:
            self.state = CalculatorStateEnteringNumber;
            break;
        case CalculatorStateFirstOperatorSelected:
            self.state = CalculatorStateEnteringNumber;
            break;
        case CalculatorStateOperatorSelected:
            self.state = CalculatorStateEnteringNumber;
            break;
        case CalculatorStateEqual:
            self.state = CalculatorStateEnteringFirstNumber;
            self.evaluationModel = [[EvaluationModel alloc]init];
            break;
        default:
            break;
                }
}
-(NSString *)addOperator:(CalculatorOperator)calculatorOperator andLabelText: (NSNumber *) inputNumber{
    NSDecimalNumber * number = [NSDecimalNumber decimalNumberWithDecimal:[inputNumber decimalValue]];
    NSString * temporaryResult = [NSString stringWithFormat:@"%@", inputNumber];
//    NSLog(@"%@ %@ %@", temporaryResult, number, labelText);
    @try {
        switch (self.state) {
            case CalculatorStateInitial:
                //self.state = CalculatorStateInitial;
                self.state = CalculatorStateFirstOperatorSelected;
                self.lastOperand = number;
                [self.evaluationModel addOperand:number];
                //            self.result = number;
                [self.evaluationModel addCalculatorOperator:calculatorOperator];
                self.lastOperator = calculatorOperator;
                break;
                
            case CalculatorStateEnteringFirstNumber:
                self.state = CalculatorStateFirstOperatorSelected;
                self.lastOperand = number;
                [self.evaluationModel addOperand:number];
                //            self.result = number;
                [self.evaluationModel addCalculatorOperator:calculatorOperator];
                self.lastOperator = calculatorOperator;
                
                break;
                
            case CalculatorStateEnteringNumber:
                self.state = CalculatorStateOperatorSelected;
                self.lastOperand = number;
                [self.evaluationModel addOperand:number];
                //            temporaryResult = [self evaluateWithOperand: self.lastOperand];
                self.lastOperator = calculatorOperator;
                temporaryResult = [self.evaluationModel addCalculatorOperator:calculatorOperator];
                break;
                
            case CalculatorStateFirstOperatorSelected:
                self.state = CalculatorStateFirstOperatorSelected;
                //            self.lastOperand = number;
                self.lastOperator = calculatorOperator;
                [self.evaluationModel replaceOperator:calculatorOperator];
                break;
                
            case CalculatorStateOperatorSelected:
                self.state = CalculatorStateOperatorSelected;
                self.lastOperator = calculatorOperator;
                temporaryResult = [self.evaluationModel replaceOperator:calculatorOperator];
                break;
                
            case CalculatorStateEqual:
                self.state = CalculatorStateOperatorSelected;
                self.lastOperand = number;
                self.lastOperator = calculatorOperator;
                temporaryResult = [self.evaluationModel addCalculatorOperator:calculatorOperator];
                break;
                
            default:
                break;
        }
//        NSLog(@"%@", temporaryResult);
    }
    @catch (NSException *exception) {
        return @"Error";
    }
    
    
    return temporaryResult;
}


-(NSString *)equalEvaluateWithLabelText:(NSNumber *)inputNumber{
    NSDecimalNumber * number = [NSDecimalNumber decimalNumberWithDecimal:[inputNumber decimalValue]];
    NSString * temporaryResult = [NSString stringWithFormat:@"%@", inputNumber];
    //    NSLog(@"%@ %@ %@", temporaryResult, number, labelText);
    @try {
        switch (self.state) {
            case CalculatorStateInitial:
                self.state = CalculatorStateInitial;
                break;
                
            case CalculatorStateEnteringFirstNumber:
                self.state = CalculatorStateEnteringFirstNumber;
                
                break;
                
            case CalculatorStateEnteringNumber:
                self.state = CalculatorStateEqual;
                self.lastOperand = number;
                [self.evaluationModel addOperand:number];
                temporaryResult = [self.evaluationModel evaluateAll];
                //            temporaryResult = [self evaluateWithOperand: self.lastOperand];
                break;
                
            case CalculatorStateFirstOperatorSelected:
                self.state = CalculatorStateEqual;
                self.lastOperand = number;
                [self.evaluationModel addOperand:number];
                temporaryResult = [self.evaluationModel evaluateAll];
                //            temporaryResult = [self evaluateWithOperand: self.result];
                break;
                
            case CalculatorStateOperatorSelected:
                self.state = CalculatorStateEqual;
                self.lastOperand = number;
                [self.evaluationModel addOperand:number];
                temporaryResult = [self.evaluationModel evaluateAll];
                //            temporaryResult = [self evaluateWithOperand: self.result];
                break;
                
            case CalculatorStateEqual:
                //            self.lastOperand = number;
                //            temporaryResult = [self evaluateWithOperand: self.lastOperand];
                self.state = CalculatorStateEqual;
                [self.evaluationModel addOperand:self.lastOperand];
                [self.evaluationModel addCalculatorOperator:self.lastOperator];
                temporaryResult = [self.evaluationModel evaluateAll];
                //            self.lastOperand = number;
                break;
                
            default:
                break;
        }
        
//        NSLog(@"%@", temporaryResult);

    }
    @catch (NSException *exception) {
        return @"Error";
    }
    
    return temporaryResult;
}

//-(NSString *)evaluateWithOperand: (NSDecimalNumber *) operand{
//    NSLog(@"%ld %@ %@", (long)self.lastOperator, self.result, operand);
//    switch (self.lastOperator) {
//        case ADD:
//            self.result = [self.result decimalNumberByAdding:operand];
//            break;
//        case SUBTRACT:
//            self.result = [self.result decimalNumberBySubtracting:operand];
//            break;
//        case MULTIPLY:
//            self.result = [self.result decimalNumberByMultiplyingBy:operand];
//            break;
//        case DIVIDE:
//            if ([self.lastOperand compare:@(0)] == NSOrderedSame){
//                return @"Division By Zero";
//            }
//            self.result = [self.result decimalNumberByDividingBy:operand];
//            break;
//        default:
//            break;
//    }
//    return [NSString stringWithFormat:@"%@", self.result];
//}


@end
