//
//  ViewController.swift
//  Networking
//
//  Created by lym on 2021/3/16.
//

import UIKit

let cellId = "cell"

class ViewController: UIViewController {
    var dataList = [String]()

    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.white
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
        let api = ExampleAPI.jsonOnline(long: 121.04925573429551, lat: 31.315590522490712)
        ExampleProvider.request(api, modelType: ExampleModel.self) {
            [weak self] result in
            switch result {
            case let .success(data):
                guard let self = self, let model = data else { return }

                    let country = (model.country ?? "") + (model.countrycode ?? "")
                    let province = (model.province ?? "") + (model.provinceadcode ?? "")
                    let city = (model.city ?? "") + (model.cityadcode ?? "")
                    let district = (model.district ?? "") + (model.districtadcode ?? "")

                    let str = country + province + city + district
                    self.dataList.append(str)

                    let list = model.poiList?.compactMap{($0.name ?? "") + ($0.address ?? "")} ?? [String]()
                    self.dataList.append(contentsOf: list)
                    self.tableView.reloadData()

            case let .failure(error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let str = dataList[indexPath.row]
        cell.textLabel?.text = str
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
