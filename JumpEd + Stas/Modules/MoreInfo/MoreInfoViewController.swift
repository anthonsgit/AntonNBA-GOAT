//
//  MoreInfoViewController.swift
//  JumpEd + Stas
//
//  Created by Stanislav Frolov on 04.09.2021.
//

import UIKit

class MoreInfoViewController: UIViewController {

    @IBOutlet weak var infoTableView: UITableView?
    @IBOutlet weak var closeItButton: AppButton?
    
    let staticTexts = ["Playee's Name", "Team", "City", "Conference"]
    var valueTexts = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupButtons()
    }

    private func setupTableView(){
        infoTableView?.delegate = self
        infoTableView?.dataSource = self
        infoTableView?.rowHeight = 52
        infoTableView?.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
    }
    
    private func setupButtons(){
        closeItButton?.addTarget(self, action: #selector(closeMe), for: .touchUpInside)
    }
    
    @objc private func closeMe(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension MoreInfoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        staticTexts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
        
        cell.staticLabel?.text = staticTexts[indexPath.item]
        cell.valueLabel?.text = valueTexts[indexPath.item]
        return cell
    }
    
    
}
