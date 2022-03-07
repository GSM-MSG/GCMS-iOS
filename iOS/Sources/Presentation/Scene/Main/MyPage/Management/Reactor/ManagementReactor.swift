//
//  SettingReactor.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa
import Service

final class ManagementReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case viewDidLoad
    }
    enum Mutation{
        case setClubList([ClubList])
    }
    struct State{
        var clubList: [ClubListSection]
    }
    
    var initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            clubList: []
        )
    }
    
}

// MARK: - Mutate
extension ManagementReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidLoad:
            return viewDidLoad()
        default:
            return .empty()
        }
    }
}

// MARK: - Reduce
extension ManagementReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setClubList(lists):
            newState.clubList = [ClubListSection(header: "", items: lists)]
        }
        return newState
    }
}


// MARK: - Method
private extension ManagementReactor{
    func viewDidLoad() -> Observable<Mutation> {
        
        return .just(.setClubList([
            .init(id: 0, bannerUrl: "https://avatars.githubusercontent.com/u/74440939?s=48&v=4", title: "대충 타이틀", type: .autonomy),
            .init(id: 1, bannerUrl: "https://avatars.githubusercontent.com/u/89921023?s=64&v=4", title: "ㅁㄴㅇㄹㅁㄴㅇㅁㄴㅇ", type: .major),
            .init(id: 2, bannerUrl: "https://i.ytimg.com/vi/Kkc8aJct6qQ/hq720.jpg?sqp=-oaymwEXCNAFEJQDSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLDIZTIWGHrxuF6NijuyVWUsKHi1fw", title: "ㅁㄴ", type: .editorial),
            .init(id: 3, bannerUrl: "https://avatars.githubusercontent.com/u/74440939?s=48&v=4", title: "대충 타이틀", type: .autonomy),
            .init(id: 4, bannerUrl: "https://avatars.githubusercontent.com/u/89921023?s=64&v=4", title: "ㅁㄴㅇㄹㅁㄴㅇㅁㄴㅇ", type: .major),
            .init(id: 5, bannerUrl: "https://user-images.githubusercontent.com/74440939/156344036-247e71ef-e020-40bb-bc4d-9553f0636e30.png", title: "ㄴㅁㅇㅁㄴㄹ", type: .editorial)
        ]))
    }
}
