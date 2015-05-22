###v0.6
Add support to set the font.

Fix bug when tag's title is too long.

###v0.5
Add support to set the userInteractionEnabled of tag.

###v0.4
Add support to set bgImg,borderColor,borderWidth.

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
