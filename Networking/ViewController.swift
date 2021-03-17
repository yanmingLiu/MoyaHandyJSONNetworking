//
//  ViewController.swift
//  Networking
//
//  Created by lym on 2021/3/16.
//

import UIKit

let cellId = "cell"

class ViewController: UIViewController {
    
    var dataList = [Posts]()

    var isGreater10000: Bool = false

    var isNoMoreData: Bool = false

    var pullDown: Bool = true
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 50
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.frame
    }

    
    func loadData() {
        PostsProvider.request(.recommendList(size: 10), modelType: ResponsePageData<Posts>.self) {[weak self] (succ, model, msg, code) in
            if !succ {
                return
            }
            
            guard let sself = self else { return }
            let array = model?.datas ?? []
            sself.isNoMoreData = array.count < 10
            sself.isGreater10000 = (model?.tc ?? 0) >= 10000

            if sself.pullDown {
                sself.dataList.insert(contentsOf: array, at: 0)

            } else {
                sself.dataList.append(contentsOf: array)
            }
            sself.tableView.reloadData()
        }

    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let model = dataList[indexPath.row]
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model = dataList[indexPath.row]
        model.title = "title for indexPath \(indexPath.row)"
        dataList[indexPath.row] = model
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
