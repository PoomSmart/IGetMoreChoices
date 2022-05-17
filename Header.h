#import <UIKit/UIKit.h>

@interface IGQuizStickerOptionIndexAccessoryView : UIView
@end

@interface IGQuizStickerSummaryOptionView : UIView
@end

@protocol IGPollStickerV2ViewDelegate
- (void)pollStickerV2ViewDidChangeNumberOfVisiblePlaceholders:(UIView *)delegate;
@end

@protocol IGPollStickerV2OptionViewDelegate
- (void)updateViewState;
@end

@interface IGPollStickerV2View : UIView <IGPollStickerV2OptionViewDelegate>
@property (nonatomic, weak, readwrite) NSObject <IGPollStickerV2ViewDelegate> *delegate;
@end

@interface IGPollStickerV2OptionView : UIView
- (instancetype)initWithIsPlaceholderValidFallbackText:(BOOL)valid placeholderText:(NSString *)placeholderText;
@property (nonatomic, weak, readwrite) UIView <IGPollStickerV2OptionViewDelegate> *delegate;
- (NSString *)placeholderText;
- (BOOL)isInDiscardableState;
@end

@interface IGQuizStickerView : UIView
@property (nonatomic, assign, readwrite) BOOL shouldRenderAddCell;
@property (nonatomic, assign, readwrite, getter=isEditingQuestion) BOOL editingQuestion;
- (BOOL)_optionsComplete;
@end
