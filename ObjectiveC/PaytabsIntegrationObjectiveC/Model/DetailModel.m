//
//  DetailModel.m
//  DemoPaytabsObjectiveC
//
//  Created by gipl on 11/06/20.
//  Copyright © 2020 gipl. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
-(id) initWithTitle:(NSString*)title andValue:(NSString *)value {
    
    if (self) {
        self.title = title;
        self.value = value;
    }
    return self;
}

@end
