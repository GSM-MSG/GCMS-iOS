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
        var editorialList: [ClubListSection]
        var freedomList : [ClubListSection]
    }
    
    var initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            clubList: [],
            editorialList: [],
            freedomList: []
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
            let majorList = lists.filter { $0.type == .major }
            newState.clubList = [ClubListSection.init(header: "major", items: majorList )]
            let editorialList = lists.filter { $0.type == .editorial }
            newState.editorialList = [ClubListSection.init(header: "editorial", items: editorialList)]
            let freedomList = lists.filter { $0.type == .autonomy }
            newState.freedomList = [ClubListSection.init(header: "Freedom", items: freedomList)]
        }
        return newState
    }
}


// MARK: - Method
private extension ManagementReactor{
    
    func viewDidLoad() -> Observable<Mutation> {
        
        return .just(.setClubList([
            .init(id: 0, bannerUrl: "https://images.unsplash.com/photo-1627483262092-9f73bdf005cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3000&q=80", title: "그냥 아무말", type: .autonomy),
            .init(id: 1, bannerUrl: "https://images.unsplash.com/photo-1627483262092-9f73bdf005cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3000&q=80", title: "그냥 아무말", type: .major),
            .init(id: 2, bannerUrl: "https://images.unsplash.com/photo-1627483262092-9f73bdf005cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3000&q=80", title: "그냥 아무말", type: .editorial),
            .init(id: 3, bannerUrl: "https://images.unsplash.com/photo-1627483262092-9f73bdf005cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3000&q=80", title: "그냥 아무말", type: .major),
        ]))
    }
}
