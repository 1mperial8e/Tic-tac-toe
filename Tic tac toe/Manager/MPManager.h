//
//  ATStartViewController.h
//  Test
//
//  Created by Stas Volskyi on 22.04.14.
//  Copyright (c) 2014 Anatoliy Dalekorey. All rights reserved.
//


@protocol MPLobbyDelegate <GPGRealTimeRoomDelegate>
- (void)readyToStartMultiPlayerGame;
- (void)multiPlayerGameWasCanceled;
- (void)showInviteViewController:(UIViewController *)vcToShow;
@end

@protocol TTMyDelegate <NSObject>
- (void)didReceiveValue:(NSInteger)value;
- (void)didReceiveMessage:(NSString *)message;
@end

@interface MPManager : NSObject <GPGRealTimeRoomDelegate>
@property (nonatomic, weak) id<MPLobbyDelegate> lobbyDelegate;
@property (nonatomic, readonly) GPGRealTimeRoom *roomToTrack;
@property (weak) id<TTMyDelegate> delegate;
@property (nonatomic, strong) GPGScore *myScore;

/**
 * Accessor method for the singleton instance
 */
+ (MPManager *)sharedInstance;
/**
 * Creates an invitation controller and tells the lobbyDelegate to display it
 *
 * @param minPlayers Minimum number of other opponents host is allowed to invite
 * @param maxPlayers Maximum number of other opponents host is allowed to invite
 */
- (void)startInvitationGameWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers;

/**
 * Sends your player's score to everybody else in the room
 *
 * @param score Total score up to this point
 * @param isFinal Is this the player's final score? 
 */
- (void)sendPlayersMyMessage:(NSString *) message instruction:(char)instruction;
/**
 * Safely leaves the room and alerts the other players. Typically called at the end of a 
 * match.
 */
- (void)leaveRoom;
/**
 * Find out if we have any invitations that are waiting our response
 *
 */
-(void)numberOfInvitesAwaitingResponse:(void (^)(int))returnBlock;

-(void)showIncomingInvitesScreen;

@end
