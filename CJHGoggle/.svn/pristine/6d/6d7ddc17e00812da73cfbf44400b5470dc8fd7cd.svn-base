//

#import "HYAnnotationView.h"

@interface HYAnnotationView () {
    
    CGFloat width;
}

@property (nonatomic, strong) UIImageView *imageVew;

@property (nonatomic, strong) UILabel *label_title;

@end

@implementation HYAnnotationView

- (id)initWithAnnotation:(id <BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        CGRect frame = self.frame;
        frame.size = CGSizeMake(60.0, 35.0);
        self.frame = frame;
        self.contentMode = UIViewContentModeCenter;
        self.backgroundColor = [UIColor clearColor];
        self.enabled = YES;
        
        self.imageVew.frame = CGRectMake(0, 9, 30, 26);
        
        [self addSubview:self.imageVew];
        
        self.label_title.frame= CGRectMake(0, 0, 40, 9);
        
        [self addSubview:self.label_title];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    
    [super setImage:image];
    
    self.imageVew.image = [image dp_scaleToSize:CGSizeMake(30, 26)];
}

- (void)setAnnotation:(id <BMKAnnotation>)annotation {
    [super setAnnotation:annotation];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
//    UIImage *image = [self.image dp_scaleToSize:CGSizeMake(30.0, 26.0)];
//
//    [image drawInRect:CGRectMake((width - 30) / 2, 9.0, 30.0, 26.0)];
}

- (void)setTitle:(NSString *)title {
    
    self.label_title.text = title;
    
    if(title) {
        
        width = [title dp_widthWith:[UIFont systemFontOfSize:7.5]];
        
        if(width < 40) {
            
            width = 40;
        }
    }
    else {
        
        width = 40;
    }
    
    self.label_title.frame = CGRectMake((30 - width) / 2, 0, width, 9);
}

- (UILabel *)label_title {
    
    if(!_label_title) {
        
        _label_title = [[UILabel alloc] init];
        
        _label_title.backgroundColor = [UIColor clearColor];
        
        _label_title.font = [UIFont systemFontOfSize:7.5];
        
        _label_title.textColor = [UIColor darkTextColor];
        
        _label_title.textAlignment = NSTextAlignmentCenter;
    }
    
    return _label_title;
}

- (UIImageView *)imageVew {
    
    if (!_imageVew) {
        
        _imageVew = [[UIImageView alloc] init];
    }
    
    return _imageVew;
}

@end
