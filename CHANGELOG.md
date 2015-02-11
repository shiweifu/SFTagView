###v0.4
Support to set bgImg,borderColor,borderWidth.

###v0.3
Use block to handle tag's click event.
```objc
//SKTagView
@property (nonatomic, copy) void (^didClickTagAtIndex)(NSUInteger index);
```

###v0.2

Add new methods:
```objc
- (void)insertTag:(SKTag *)tag atIndex:(NSUInteger)index;
- (void)removeTag:(SKTag *)tag;
- (void)removeTagAtIndex:(NSUInteger)index;
- (void)removeAllTags;
```
