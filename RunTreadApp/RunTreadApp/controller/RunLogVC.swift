//
//  SecondViewController.swift
//  RunTreadApp
//
//  Created by Apple on 02/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class RunLogVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        }
}

extension RunLogVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRun()?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: "RunLogCell", for: indexPath) as? RunLogCell {
            guard let run = Run.getAllRun()?[indexPath.row] else{
                return RunLogCell()
            }
            cell.configure(run: run)
            return cell
        }else{
            return RunLogCell()
        }
    }
}

