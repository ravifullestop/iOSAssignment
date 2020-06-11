//
//  DetailModel.h
//  DemoPaytabsObjectiveC
//
//  Created by gipl on 11/06/20.
//  Copyright © 2020 gipl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailModel : UIViewController
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *value;

-(id) initWithTitle: (NSString*)title andValue: (NSString *)value;

@end

NS_ASSUME_NONNULL_END
