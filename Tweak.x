#import "Header.h"

%hook IGQuizStickerView

- (void)_refreshAddCell {
    self.shouldRenderAddCell = self.editingQuestion && [self _optionsComplete];
}

%end

%hook IGQuizStickerOptionIndexAccessoryView

- (void)setIndex:(NSInteger)index {
    if (index > 3) {
        UILabel *placeholderIndexLabel = [self valueForKey:@"_placeholderIndexLabel"];
        UILabel *normalGradientMaskLabel = [self valueForKey:@"_normalGradientMaskLabel"];
        UILabel *filledGradientLabel = [self valueForKey:@"_filledGradientLabel"];
        NSString *alphabet = [NSString stringWithFormat:@"%c", (int)(index + 'A')];
        placeholderIndexLabel.text = alphabet;
        normalGradientMaskLabel.text = alphabet;
        filledGradientLabel.text = alphabet;
        [placeholderIndexLabel sizeToFit];
        [normalGradientMaskLabel sizeToFit];
        [filledGradientLabel sizeToFit];
        [self setNeedsLayout];
        return;
    }
    %orig;
}

%end

%hook IGQuizStickerSummaryOptionView

- (void)setIndex:(NSInteger)index {
    if (index > 3) {
        UILabel *indexLabel = [self valueForKey:@"_indexLabel"];
        indexLabel.text = [NSString stringWithFormat:@"%c", (int)(index + 'A')];
        [indexLabel sizeToFit];
        return;
    }
    %orig;
}

%end

// Poll doesn't work if items > 4 for some reasons

// %hook IGPollStickerV2View

// - (id)initWithFrame:(CGRect)frame {
//     self = %orig;
//     if (self) {
//         NSMutableArray <IGPollStickerV2OptionView *> *optionViews = [[self valueForKey:@"_optionViews"] mutableCopy];
//         NSString *placeholderText = [optionViews lastObject].placeholderText;
//         for (int i = 0; i < 10; ++i) {
//             IGPollStickerV2OptionView *option = [[%c(IGPollStickerV2OptionView) alloc] initWithIsPlaceholderValidFallbackText:NO placeholderText:placeholderText];
//             [optionViews addObject:option];
//             [self addSubview:option];
//             option.delegate = self;
//         }
//         [self setValue:optionViews.copy forKey:@"_optionViews"];
//         [self updateViewState];
//     }
//     return self;
// }

// - (void)pollStickerV2OptionViewDidUpdatePlaceholderState:(id)arg1 {
//     NSArray <IGPollStickerV2OptionView *> *optionViews = [self valueForKey:@"_optionViews"];
//     __block int visible = 0;
//     __block int discardable = 0;
//     [optionViews enumerateObjectsUsingBlock:^(IGPollStickerV2OptionView *option, NSUInteger idx, BOOL *stop) {
//         if (option.alpha) {
//             ++visible;
//             if ([option isInDiscardableState])
//                 ++discardable;
//         }
// 	}];
//     if (discardable > 1 || discardable == 0) {
//         [self.delegate pollStickerV2ViewDidChangeNumberOfVisiblePlaceholders:self];
//     }
// }

// %end