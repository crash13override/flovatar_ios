//
//  AuthHelper.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 20.01.2022.
//

import Foundation
import FCLAuthSwift

final class AuthHelper {
    static let shared = AuthHelper()
        
    private var isLoading: Bool = false
    
    var address: String {
        if let address = UserDefaults.standard.string(forKey: Constant.loggedAddress) {
            return address
        }
        return ""
    }
    
    var isLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: Constant.isLoggedIn)
    }
    
    private init() {
        fcl.delegate = self
        
        fcl.config(
            appInfo: FCLAppInfo(
                title: "Flovatar",
                icon: URL(string: "https://flovatar.com/bar.png")!,
                location: URL(string: "https://flovatar.com")!
            ),
            // default provider is  [.dapper, .blocto]
            providers: [.blocto]
        )
    }
    
    func auth(provider: FCLProvider = .blocto, completion: @escaping (Result<String, Error>) -> Void) {
        fcl.authenticate(provider: provider) { [weak self] result in
                switch result {
                case let .success(data):
                    self?.setLoggedIn(with: data.address)
                    completion(.success(data.address))
                case let .failure(error):
                    self?.setLogOut()
                    print(#fileID, #line, "Error:", error.localizedDescription)
                    completion(.failure(error))
                }
        }
    }
    
    func logout() {
        self.setLogOut()
    }
    
    private func setLoggedIn(with address: String) {
        UserDefaults.standard.set(true, forKey: Constant.isLoggedIn)
        UserDefaults.standard.set(address, forKey: Constant.loggedAddress)
    }
    
    private func setLogOut() {
        UserDefaults.standard.set(false, forKey: Constant.isLoggedIn)
        UserDefaults.standard.set("", forKey: Constant.loggedAddress)
    }
}

extension AuthHelper: FCLAuthDelegate {
    func showLoading() {
        isLoading = true
    }
    
    func hideLoading() {
        isLoading = false
    }
}
