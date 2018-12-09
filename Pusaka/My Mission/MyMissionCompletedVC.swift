//
//  MyMissionCompletedVC.swift
//  Pusaka
//
//  Created by Steven Bong on 29/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit

class MyMissionCompletedVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.tableFooterView = UIView()
    }

}

extension MyMissionCompletedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyMissionCompletedCell
            cell.selectionStyle = .none
        return cell
    }
}
