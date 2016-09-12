//
//  FaceBoard+EmojiHash.m
//  CSChatDemo
//
//  Created by XiaoSong on 15/12/15.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "FaceBoard+EmojiHash.h"

@implementation FaceBoard (EmojiHash)
- (void)configurationEmoji{
    self.emojiArray = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"emo_001"],
                   [UIImage imageNamed:@"emo_002"],
                   [UIImage imageNamed:@"emo_003"],
                   [UIImage imageNamed:@"emo_004"],
                   [UIImage imageNamed:@"emo_005"],
                   [UIImage imageNamed:@"emo_006"],
                   [UIImage imageNamed:@"emo_007"],
                   [UIImage imageNamed:@"emo_008"],
                   [UIImage imageNamed:@"emo_009"],
                   [UIImage imageNamed:@"emo_010"],
                   [UIImage imageNamed:@"emo_011"],
                   [UIImage imageNamed:@"emo_012"],
                   [UIImage imageNamed:@"emo_013"],
                   [UIImage imageNamed:@"emo_014"],
                   [UIImage imageNamed:@"emo_015"],
                   [UIImage imageNamed:@"emo_016"],
                   [UIImage imageNamed:@"emo_017"],
                   [UIImage imageNamed:@"emo_018"],
                   [UIImage imageNamed:@"emo_019"],
                   [UIImage imageNamed:@"emo_020"],
                   [UIImage imageNamed:@"emo_021"],
                   [UIImage imageNamed:@"emo_022"],
                   [UIImage imageNamed:@"emo_023"],
                   [UIImage imageNamed:@"emo_024"],
                   [UIImage imageNamed:@"emo_025"],
                   [UIImage imageNamed:@"emo_026"],
                   [UIImage imageNamed:@"emo_027"],
                   [UIImage imageNamed:@"emo_028"],
                   nil];
    
    self.symbolArray = [NSArray arrayWithObjects:
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F60A", //@"\ue056",
                    @"\U0001F603", //@"\ue057",
                    @"\u263A",     //@"\ue414",
                    @"\U0001F609", //@"\ue405",
                    @"\U0001F60D", //@"\ue106",
                    @"\U0001F618", //@"\ue418",
                    @"\U0001F61A", //@"\ue417",
                    @"\U0001F633", //@"\ue40d",
                    @"\U0001F60C", //@"\ue40a",
                    @"\U0001F601", //@"\ue404",
                    @"\U0001F61C", //@"\ue105",
                    @"\U0001F61D", //@"\ue409",
                    @"\U0001F612", //@"\ue40e",
                    @"\U0001F60F", //@"\ue402",
                    @"\U0001F613", //@"\ue108",
                    @"\U0001F614", //@"\ue403",
                    @"\U0001F61E", //@"\ue058",
                    @"\U0001F616", //@"\ue407",
                    @"\U0001F625", //@"\ue401",
                    @"\U0001F630", //@"\ue40f",
                    @"\U0001F628", //@"\ue40b",
                    @"\U0001F623", //@"\ue406",
                    @"\U0001F622", //@"\ue413",
                    @"\U0001F62D", //@"\ue411",
                    @"\U0001F602", //@"\ue412",
                    @"\U0001F632", //@"\ue410",
                    @"\U0001F631", //@"\ue107",
                    nil];
}
@end
