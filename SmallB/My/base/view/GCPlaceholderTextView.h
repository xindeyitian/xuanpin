//
//  GCPlaceholderTextView.h
//  GCLibrary
//
//  Created by Guillaume Campagna on 10-11-16.
//  Copyright 2010 LittleKiwi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GCPlaceholderTextViewPasteDelegate <NSObject>

@optional

-(void)UITextViewPastClick;

@end


@interface GCPlaceholderTextView : UITextView 

@property(nonatomic,assign)id<GCPlaceholderTextViewPasteDelegate> pasteDelegate;
@property(nonatomic, retain) NSString *placeholder;


@end
