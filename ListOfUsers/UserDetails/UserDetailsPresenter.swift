//
//  UserDetailsPresenter.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

enum UserDetailCellType: Int, CaseIterable {
    case age            = 0
    case eyeColor       = 1
    case company        = 2
    case email          = 3
    case phone          = 4
    case address        = 5
    case location       = 6 // latitude, longitude
    case balance        = 7
    case registered     = 8
    case favoriteFruit  = 9
    case about          = 10
    case tags           = 11
    case friends        = 12
}

class UserDetailsPresenter: UserDetailsPresenterProtocol {
    
    weak var view: UserDetailsViewProtocol!
    var interactor: UserDetailsInteractorProtocol!
    var router: UserDetailsRouterProtocol!
    
    required init(view: UserDetailsViewProtocol) {
        self.view = view
    }
    
    private var navigationItemTitle: String {
        return interactor.navigationItemTitleFor(userId: view.userId)
    }
    private var navigationBarBackItemTitle: String { return interactor.navigationBarBackItemTitle }
    private var numberOfFriends: Int { return self.interactor.getUser(withUserId: self.view.userId).friends.count }
    
    // MARK: - UserDetailsPresenterProtocol methods
    
    func configureView() {
        self.view.setNavigationItemTitle(with: self.navigationItemTitle)
        self.view.setNavigationBarBackItemTitle(with: self.navigationBarBackItemTitle)
        self.view.register(cellClass: UserDetailCellStyleValue2.self, forCellReuseIdentifier: "cellStyleValue2")
        self.view.register(cellClass: UserDetailEyeColorCell.self, forCellReuseIdentifier: "eyeColorCell")
        self.view.register(cellClass: UserDetailAboutCell.self, forCellReuseIdentifier: "aboutCell")
        self.view.register(cellClass: UserDetailTagCell.self, forCellReuseIdentifier: "tagCell")
        self.view.register(cellClass: UsersListCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.interactor.getUsersList()
    }
    
    func getNumberOfSections() -> Int {
        return self.numberOfFriends > 0 ? 2 : 1
    }
    
    func getTitleForHeader(InSection section: Int) -> String? {
        return (self.numberOfFriends > 0 && section == 1) ? "Friends" : nil
    }
    
    func getNumberOfRows(InSection section: Int) -> Int {
        switch section {
        case 0: return UserDetailCellType.allCases.count - 1
        default: return self.numberOfFriends
        }
    }
    
    private func configureCellStyleValue2(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellStyleValue2", for: indexPath) as? UserDetailCellStyleValue2,
            let cellType = UserDetailCellType(rawValue: indexPath.row)
            else { return UITableViewCell(frame: CGRect.zero) }
        cell.configureWith(
            user: self.interactor.getUser(withUserId: self.view.userId),
            andCellType: cellType)
        return cell
    }
    
    private func configureEyeColorCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "eyeColorCell", for: indexPath) as? UserDetailEyeColorCell
        else { return UITableViewCell(frame: CGRect.zero) }
        cell.user = self.interactor.getUser(withUserId: self.view.userId)
        return cell
    }
    
    private func configureAboutCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath) as? UserDetailAboutCell
            else { return UITableViewCell(frame: CGRect.zero) }
        cell.user = self.interactor.getUser(withUserId: self.view.userId)
        return cell
    }
    
    private func configureTagCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath) as? UserDetailTagCell
            else { return UITableViewCell(frame: CGRect.zero) }
        cell.user = self.interactor.getUser(withUserId: self.view.userId)
        return cell
    }
    
    private func getFriendForRow(_ row: Int) -> User? {
        let friendsList = self.interactor.getUser(withUserId: self.view.userId).friends
        guard let friendId = friendsList[row]["id"] else { return nil }
        return self.interactor.getUser(withUserId: friendId)
    }
    
    private func cellForFriendsCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? UsersListCell,
            let friend = self.getFriendForRow(indexPath.row)
        else { return UITableViewCell(frame: CGRect.zero) }
        cell.user = friend
        return cell
    }
    
    func cellForUsersList(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            return self.cellForFriendsCell(tableView, cellForRowAt: indexPath)
        }
        switch indexPath.row {
        case 1:
            return self.configureEyeColorCell(tableView, cellForRowAt: indexPath)
        case 10:
            return self.configureAboutCell(tableView, cellForRowAt: indexPath)
        case 11:
            return self.configureTagCell(tableView, cellForRowAt: indexPath)
        default:
            return self.configureCellStyleValue2(tableView, cellForRowAt: indexPath)
        }
    }
    
    func didSelectIndexPath(_ indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let friend = self.getFriendForRow(indexPath.row) else { return }
            if friend.isActive {
                self.router.showUserDetails(ForId: friend.id)
            }
            return
        }
        guard let cellType = UserDetailCellType(rawValue: indexPath.row) else { return }
        let user = self.interactor.getUser(withUserId: self.view.userId)
        switch cellType {
        case .email: self.router.sendEmailTo(user: user)
        case .phone: self.router.makeCallTo(user: user)
        case .location: self.router.openMapWithLocationOf(user: user)
        default: return
        }
    }
}
