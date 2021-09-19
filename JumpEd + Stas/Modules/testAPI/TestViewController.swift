//
//  TestViewController.swift
//  JumpEd + Stas
//
//  Created by Антон Воронов on 05.09.2021.
//

import UIKit



enum ApiError: Error {
    case noData
}


class TestViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var newRandomButton: UIButton!
    
    var pageForParse = 120
    
    var parsedPlayers = [PlayerNBA](){
        didSet{
//            print(parsedPlayers.first?.firstName)
//            print(parsedPlayers.first?.lastName)
            print(parsedPlayers)
            cardCollectionView.reloadData()
        }
    }
    
    var parsedTeam = [Teams](){
        didSet{
            print(parsedTeam) //вроде работает
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        setupButtons()
        setupCollection()
    }
    
    private func setupButtons() {
        newRandomButton.layer.cornerRadius = 12
        newRandomButton.backgroundColor = .orange
        newRandomButton.setTitleColor(.white, for: .normal)
        startButton.addTarget(self, action: #selector(parseDataFromServer), for: .touchUpInside)
        newRandomButton.addTarget(self, action: #selector(randomize), for: .touchUpInside)
        
        
    }
    
    
    @objc private func parseDataFromServer(){
        getPlayers { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let players):
                    self.parsedPlayers = players
                    
                case .failure:
                    self.parsedPlayers = []
                    print("ОУ ЧЕРТ У НАС ПРОИЗОШЛА ОШИБО4КА")
                }
            }
        }
    }

    @objc private func randomize(){
        pageForParse = Int.random(in: 1...150)
        parseDataFromServer()
        print("ЗДЕСЬ ЗДЕСЬ ЗДЕСЬ ЗДЕСЬ")
    }
    
    func getPlayers(completion: @escaping (Result<[PlayerNBA], Error>) -> Void){
        
        let session = URLSession.shared
        guard let url = URL(string: "https://www.balldontlie.io/api/v1/players?page=\(pageForParse)") else {return}
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ObjDataNBA.self, from: data)
                completion(.success(response.data))
            } catch(let error) {
                print(error)
                completion(.failure(error))
            }
        }
        )
        dataTask.resume()
    }
    private func setupCollection() {
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        cardCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        cardCollectionView.isPagingEnabled = true
        cardCollectionView.isHidden = false
        cardCollectionView.showsHorizontalScrollIndicator = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.cardCollectionView.collectionViewLayout = layout
        
        ОФИШЕТЬ ЭТО ТЕСТОВАЯ ВЕТКА В ГИТ Я МОГУ ТВОРИТЬ ЧЕ ЗАХОЧУ
        ОФИШЕТЬ ЭТО ТЕСТОВАЯ ВЕТКА В ГИТ Я МОГУ ТВОРИТЬ ЧЕ ЗАХОЧУ
        ОФИШЕТЬ ЭТО ТЕСТОВАЯ ВЕТКА В ГИТ Я МОГУ ТВОРИТЬ ЧЕ ЗАХОЧУ
м        ОФИШЕТЬ ЭТО ТЕСТОВАЯ ВЕТКА В ГИТ Я МОГУ ТВОРИТЬ ЧЕ ЗАХОЧУ

        ОФИШЕТЬ ЭТО ТЕСТОВАЯ ВЕТКА В ГИТ Я МОГУ ТВОРИТЬ ЧЕ ЗАХОЧУ
        ОФИШЕТЬ ЭТО ТЕСТОВАЯ ВЕТКА В ГИТ Я МОГУ ТВОРИТЬ ЧЕ ЗАХОЧУ

        ОФИШЕТЬ ЭТО ТЕСТОВАЯ ВЕТКА В ГИТ Я МОГУ ТВОРИТЬ ЧЕ ЗАХОЧУ

        ОФИШЕТЬ ЭТО ТЕСТОВАЯ ВЕТКА В ГИТ Я МОГУ ТВОРИТЬ ЧЕ ЗАХОЧУ

    }
   }

extension TestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 15, height: collectionView.frame.height - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        parsedPlayers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let players = parsedPlayers
        if let cell = cell as? CardCollectionViewCell {
            let fullName = players[indexPath.item].firstName + " " + players[indexPath.item].lastName
            cell.setupData(name: fullName, team: players[indexPath.item].playerTeam.fullName, pos: players[indexPath.item].playerPosition)
            cell.backView.backgroundColor = .gray
        }
    }
    
}
