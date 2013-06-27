
#import "BattleFieldLayer.h"
#import "SimpleAudioEngine.h"
#import "Fighter.h"
#import "Enemy.h"


#define Z_BG 0
#define Z_FIGHT 90
#define Z_CLOUD 91
#define Z_PAD 96

#define TAG_ENEMY 1
#define TAG_BULLET 2

@implementation BattleFieldLayer

@synthesize fighter;

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	BattleFieldLayer *layer = [BattleFieldLayer node];
	[scene addChild: layer];
	return scene;
}

-(void)spriteMoveFinished:(id)sender {
	CCSprite *sprite = (CCSprite *)sender;
	if ( sprite.tag == TAG_ENEMY ) {
		[enemies removeObject:sprite];
	}
	else {
		[bullets removeObject:sprite];
	}
	[self removeChild:sprite cleanup:YES];
}

// 충돌 효과 - 스프라이트 시트 애니메이션 동작 후 삭제
-(void)explodeEnemy:(Enemy *)enemy {
	[enemy explode:explosionAni];
}

-(void)checkCollision {
	NSMutableArray *collidedBullets = [NSMutableArray array];
	
	for (CCSprite *bullet in bullets) {
		
		NSMutableArray *fallingEnemies = [NSMutableArray array];
		
		for (Enemy *enemy in enemies) {
			CGRect enemyRect;
			enemyRect.origin = ccp(enemy.position.x - enemy.contentSize.width / 2,enemy.position.y - enemy.contentSize.height / 2);
			enemyRect.size = enemy.contentSize;
			
			CGRect bulletRect;
			bulletRect.origin = ccp(bullet.position.x - bullet.contentSize.width / 2,bullet.position.y - bullet.contentSize.height / 2);
			bulletRect.size = bullet.contentSize;
			
			if ( CGRectContainsRect(enemyRect, bulletRect) ) {
				// 충돌
				[fallingEnemies addObject:enemy];
				[collidedBullets addObject:bullet];
			}
		}
		
		// 총알에 맞은 적이 있으면 적을 삭제
		if ( [fallingEnemies count] > 0 ) {
			for (Enemy *enemy in fallingEnemies) {
				[enemy explode:explosionAni];
			}
		}
	}
	
	// 총알 삭제
	if ( [collidedBullets count] > 0 ) {
		for (CCSprite *bullet in collidedBullets) {
			[self removeChild:bullet cleanup:YES];
			[bullets removeObject:bullet];
		}		
	}
}

// 총알 추가
-(void)shootTarget {	
	CCSprite *bullet = [CCSprite spriteWithFile:@"bullet.png"];
	bullet.tag = TAG_BULLET;
	
	// 처음 위치는 비행기 위치와 동일
	bullet.position = fighter.position;
	
	// 발사위치는 x좌표는 비행기 위치, y좌표는 화면 밖
	CGSize winsize = [[CCDirector sharedDirector] winSize];
	CGPoint dest = ccp(fighter.position.x, winsize.height + bullet.contentSize.height);
	
	[self addChild:bullet];
	[bullets addObject:bullet];
	
	// 발사-이동 액션과, 화면을 벗어나면 스프라이트 삭제 액션을 순차적으로 실행
	id actionFire = [CCMoveTo actionWithDuration:1.0 position:dest];
	id actionRemove = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
	[bullet runAction:[CCSequence actions:actionFire, actionRemove, nil]];
}

// 적 추가하기
-(void)addEnemy:(ccTime)dt {
	Enemy *enemy = [Enemy enemyIn:self];
	enemy.tag = TAG_ENEMY;
	[enemy move];
	
	[self addChild:enemy];
	[enemies addObject:enemy];
}

#define MAX_WIDTH 1024
#define MAX_HEIGHT 1024

// 배경 스크롤
-(void)scrollBy:(CGPoint)amount withSpeed:(int)speed {
//	NSLog(@"voidNode's contentsize : (%d,%d)", (int)backgroundLayer.contentSize.width, (int)backgroundLayer.contentSize.height);
//	NSLog(@"voidNode's positon : (%d,%d)", (int)backgroundLayer.position.x, (int)backgroundLayer.position.y);
//	if ( CGRectContainsPoint(CGRectMake(0, 0, MAX_WIDTH, MAX_HEIGHT), newPoint ) )
//		backgroundLayer.position = newPoint ;
	
	CCSprite *bgImage = (CCSprite *)[self getChildByTag:99];
	CGRect rectBG = CGRectMake(0, 0, bgImage.contentSize.width, bgImage.contentSize.height);
	CGPoint newPoint = ccpAdd(bgImage.position, amount);
	
	if ( CGRectContainsPoint(rectBG, newPoint) )
		bgImage.position = newPoint;
}

-(void)initSimpleBackground {
	CCSprite *bgImage = [CCSprite spriteWithFile:@"background.png"];
	bgImage.tag = 99;
	[self addChild:bgImage z:0];
}


// 1024 * 1024 의 배경 추가, 랜덤으로 섬들을 추가
-(void)initBackgroundLayer {
	voidNode = [[CCParallaxNode node] retain];
	[self addChild:voidNode];
	
	backgroundLayer = [CCLayerColor layerWithColor:ccc4(8, 54, 129, 255)];
	backgroundLayer.contentSize = CGSizeMake(1024, 1024);
	backgroundLayer.position = ccp(512, 512);
	backgroundLayer.anchorPoint = ccp(0.5,0.5);
	
	CCSprite *island;
	
	int number = arc4random() % 10 + 5;
	for (int i = 0; i < number; i++) {
		int islandIndex = arc4random() % 3;
		int x = arc4random() % (int)backgroundLayer.contentSize.width;
		int y = arc4random() % (int)backgroundLayer.contentSize.height;
		
		island = [CCSprite spriteWithFile:[NSString stringWithFormat:@"island%d.png", islandIndex]];
		island.position = ccp(x, y);
		[backgroundLayer addChild:island];
	}
	
	
	[self addChild:backgroundLayer];
}


-(void)prepareExplosionEffect {
	// 폭발 스프라이트 시트를 로딩, 캐싱함
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"explosion.plist"];
	NSMutableArray *explosionFrames = [NSMutableArray array];
	for(int i = 0 ; i < 7 ; i++ ) {
		NSString *frameName = [NSString stringWithFormat:@"explosion%d.png", i];
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
		[explosionFrames addObject:frame];
	}		
	
	// 스프라이트 시트를 이용한 애니메이션
	explosionAni = [[CCAnimation animationWithFrames:explosionFrames delay:0.1f] retain];		
	NSAssert(explosionAni, @"explosion animation should not be nil");	
}


// 전투기 이동, 적 추가, 충돌 체크 로직을 반복
-(void)repeatGameLogic {	
	[fighter schedule:@selector(move)];		
	[self schedule:@selector(addEnemy:) interval:1.0];
	[self schedule:@selector(checkCollision)];
	
}

// http://www.cocos2d-iphone.org/forum/topic/3414
-(id) init {
	if( (self=[super initWithColor:ccc4(8, 54, 129, 255)])) {	
		CGSize winsize = [[CCDirector sharedDirector] winSize];
		
		self.fighter = [Fighter fighterWithBackground:self];
		fighter.position = ccp(winsize.width /2 , winsize.height/4);
		[self addChild:fighter z:Z_FIGHT];		
		
		[self initSimpleBackground];
		[self initBackgroundLayer];
		
		// 폭발 스프라이트 시트
		[self prepareExplosionEffect];
		
		enemies = [[NSMutableArray alloc] init];
		bullets = [[NSMutableArray alloc] init];
		
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background_music.mp3"];
		
		[self repeatGameLogic];
	}
	return self;
}



- (void) dealloc {
	[voidNode release];
	[explosionAni release];
	[enemies release];
	[bullets release];
	[super dealloc];
}

@end