//
//  ViewController.swift
//  JumpEd + Stas
//
//  Created by Stanislav Frolov on 30.08.2021.
//

import UIKit
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

class StartViewController: UIViewController {
    
    @IBOutlet weak var antonButton: UIButton?
    @IBOutlet weak var mainLogoImage: UIImageView?
    @IBOutlet weak var enterButton: AppButton?
    
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupButton()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    private func setupNavBar(){
        navigationController?.navigationBar.isHidden = true
        
    }
    
    private func setupButton(){
        enterButton?.setTitle("Jump!", for: .normal)
        enterButton?.addTarget(self, action: #selector(go2main), for: .touchUpInside)
        
        antonButton?.addTarget(self, action: #selector(go2testVC), for: .touchUpInside)
    }
    
    @objc private func go2testVC(){
        let vc = TestViewController()
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .crossDissolve
        navigation.navigationBar.isTranslucent = false
        present(navigation, animated: true, completion: nil)
    }
    
    @objc private func go2main(){
        if Connectivity.isConnectedToInternet {
            checkForFirstLaunch()
            presentMainWithNavigation() //If we connected to network
        } else {
            if !userDefaults.bool(forKey: "firstLaunch"){
                presentBadAlert() // We cant connect to network and launch app first time
                userDefaults.set(false, forKey: "firstLaunch")
            } else{
                checkForFirstLaunch()
                presentMainWithNavigation() // we cant connect to network but we launch app before
            }
        }
    }
    
    
    private func presentMainWithNavigation(){
        let vc = MainViewController()
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .crossDissolve
        navigation.navigationBar.isTranslucent = false
        present(navigation, animated: true, completion: nil)
    }
    
    private func presentBadAlert(){
        let alert = UIAlertController(title: "Ohh bro", message: "Надо включить интернет хотя бы раз и попробовать запустить аппу еще раз", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay :(", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    private func checkForFirstLaunch(){
        if userDefaults.bool(forKey: "firstLaunch"){
            userDefaults.set(true, forKey: "firstLaunch")  //First launch
        } else{
            userDefaults.set(true, forKey: "firstLaunch")  //During first launch
        }
    }
}

