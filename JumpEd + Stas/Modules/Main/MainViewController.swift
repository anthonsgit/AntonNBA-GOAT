//
//  MainViewController.swift
//  JumpEd + Stas
//
//  Created by Stanislav Frolov on 01.09.2021.
//

import UIKit

class MainViewController: UIViewController, MainPresenterOutputDelegate {

    @IBOutlet weak var collectionOfPlayers: UICollectionView?
    
    var presenter: MainPresenterInputDelegate?
    var router: MainRouterInterface?
    var isOfflineMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        collectionOfPlayers?.isHidden = false
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let presenter = presenter {
            presenter.willShowController()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let presenter = presenter {
            presenter.willHideController()
        }
    }

    private func setupButtons(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Randomize", style: .done, target: self, action: #selector(generateBrandNew))
        if isOfflineMode{
            navigationItem.rightBarButtonItem = UIBarButtonItem()
        }
        
    }
    
    func setupCollection(){
        collectionOfPlayers?.isHidden = false
        collectionOfPlayers?.delegate = self
        collectionOfPlayers?.dataSource = self
        collectionOfPlayers?.register(UINib(nibName: "PlayerCell", bundle: nil), forCellWithReuseIdentifier: "PlayerCell")
        collectionOfPlayers?.reloadData()
    }
    
    @objc func generateBrandNew(){
        if isOfflineMode{
            presentBadAlert()
        } else {
            presenter?.generateRndPageForPlayersList()
        }
    }
    private func presentBadAlert(){
        let alert = UIAlertController(title: "Ohh bro", message: "Без инета в рандом никак, как ни крути нужно хоть чуть-чуть сети :(", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay :(", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.countOfPlayers() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlayerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PlayerCell else { return }
        guard let nbaPlayer = presenter?.getParsedPlayers()[indexPath.item] else { return }
        cell.nameLabel?.text = "\(nbaPlayer.name) \n \(nbaPlayer.lastName)"
        cell.teamLabel?.text = nbaPlayer.team.abbreviation
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3 - 16, height: collectionView.bounds.width / 3 - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.moreInfoAction(indexPath: indexPath.item)
    }
    
}
