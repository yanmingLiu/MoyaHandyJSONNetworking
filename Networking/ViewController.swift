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

        let json = """
        {\"status\":\"1\",\"data\":{\"code\":\"1\",\"message\":\"Successful.\",\"result\":\"true\",\"timestamp\":\"1667197858776\",\"version\":\"1.0\",\"country\":\"中国\",\"countrycode\":\"CN\",\"province\":\"江苏省\",\"provinceadcode\":\"320000\",\"city\":\"苏州市\",\"cityadcode\":\"320500\",\"tel\":\"0512\",\"areacode\":\"0512\",\"district\":\"昆山市\",\"districtadcode\":\"320583\",\"adcode\":\"320583\",\"desc\":\"江苏省,苏州市,昆山市\",\"poi_list\":[{\"address\":\"陆家浜北路21号\",\"childtype\":\"\",\"direction\":\"West\",\"distance\":\"160\",\"end_poi_extension\":\"29\",\"entrances\":[{\"latitude\":\"31.314931\",\"longitude\":\"121.047103\"}],\"latitude\":\"31.315495\",\"longitude\":\"121.047568\",\"name\":\"昆山市第四人民医院\",\"poiid\":\"B020007Y9K\",\"tel\":\"0512-57879719\",\"towards_angle\":\"\",\"type\":\"医疗保健服务;综合医院;综合医院\",\"typecode\":\"090100\",\"weight\":\"0\"},{\"address\":\"菉溪路22号\",\"childtype\":\"\",\"direction\":\"SouthWest\",\"distance\":\"124\",\"end_poi_extension\":\"29\",\"entrances\":[{\"latitude\":\"31.31441\",\"longitude\":\"121.048419\"}],\"latitude\":\"31.314873\",\"longitude\":\"121.048248\",\"name\":\"陆家镇人民政府\",\"poiid\":\"B020007YBU\",\"tel\":\"0512-57671003\",\"towards_angle\":\"153.10\",\"type\":\"政府机构及社会团体;政府机关;乡镇级政府及事业单位\",\"typecode\":\"130105\",\"weight\":\"0\"},{\"address\":\"昆山市\",\"childtype\":\"\",\"direction\":\"SouthWest\",\"distance\":\"139\",\"end_poi_extension\":\"1\",\"entrances\":[{\"latitude\":\"31.314401\",\"longitude\":\"121.048424\"}],\"latitude\":\"31.314539\",\"longitude\":\"121.048458\",\"name\":\"陆家镇\",\"poiid\":\"B02001CXOJ\",\"tel\":\"\",\"towards_angle\":\"\",\"type\":\"地名地址信息;普通地名;乡镇级地名\",\"typecode\":\"190106\",\"weight\":\"0\"},{\"address\":\"陆家镇镇北路21号昆山市第四人民医院内\",\"childtype\":\"307\",\"direction\":\"West\",\"distance\":\"129\",\"end_poi_extension\":\"1\",\"entrances\":[{\"latitude\":\"31.315655\",\"longitude\":\"121.04783\"}],\"latitude\":\"31.315690\",\"longitude\":\"121.047895\",\"name\":\"昆山市第四人民医院住院部\",\"poiid\":\"B0FFF9UNA8\",\"tel\":\"\",\"towards_angle\":\"\",\"type\":\"医疗保健服务;综合医院;综合医院\",\"typecode\":\"090100\",\"weight\":\"0\"},{\"address\":\"菉溪路与韩泾交叉口西北60米\",\"childtype\":\"\",\"direction\":\"South\",\"distance\":\"13\",\"end_poi_extension\":\"25\",\"entrances\":[{\"latitude\":\"31.315225\",\"longitude\":\"121.049637\"}],\"latitude\":\"31.315475\",\"longitude\":\"121.049283\",\"name\":\"江苏省好孩子科学育儿用品研究院\",\"poiid\":\"B0FFHCTJ0W\",\"tel\":\"\",\"towards_angle\":\"\",\"type\":\"科教文化服务;科研机构;科研机构\",\"typecode\":\"141300\",\"weight\":\"0\"}],\"road_list\":[{\"direction\":\"NorthWest\",\"distance\":\"79\",\"latitude\":\"31.3149\",\"level\":\"4\",\"longitude\":\"121.05\",\"name\":\"绿溪路\",\"roadid\":\"021H51F0090095172\",\"width\":\"8\"},{\"direction\":\"SouthEast\",\"distance\":\"141\",\"latitude\":\"31.3163\",\"level\":\"5\",\"longitude\":\"121.048\",\"name\":\"教堂路\",\"roadid\":\"021H51F009009619361\",\"width\":\"8\"},{\"direction\":\"West\",\"distance\":\"192\",\"latitude\":\"31.3158\",\"level\":\"5\",\"longitude\":\"121.051\",\"name\":\"联谊路\",\"roadid\":\"021H51F0090093035\",\"width\":\"8\"}],\"cross_list\":[{\"crossid\":\"021H51F0090093035--021H51F0090095172\",\"direction\":\"West\",\"distance\":\"192.113\",\"latitude\":\"31.315791\",\"level\":\"45000, 44000\",\"longitude\":\"121.051264\",\"name\":\"联谊路--绿溪路\",\"weight\":\"130\",\"width\":\"8, 8\"},{\"crossid\":\"021H51F0090094608--021H51F009009619361\",\"direction\":\"East\",\"distance\":\"258.263\",\"latitude\":\"31.315546\",\"level\":\"45000, 45000\",\"longitude\":\"121.046538\",\"name\":\"陆家浜北路--教堂路\",\"weight\":\"120\",\"width\":\"8, 8\"},{\"crossid\":\"021H51F0090093125--021H51F0090095172\",\"direction\":\"NorthEast\",\"distance\":\"272.251\",\"latitude\":\"31.313310\",\"level\":\"45000, 44000\",\"longitude\":\"121.048214\",\"name\":\"陆家浜南路--绿溪路\",\"weight\":\"130\",\"width\":\"8, 8\"}],\"hn\":\"20号\",\"sea_area\":{\"adcode\":\"\",\"name\":\"\"},\"pos\":\"在江苏省好孩子科学育儿用品研究院附近, 在教堂路旁边, 靠近联谊路--绿溪路路口\"}}
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let resData = try decoder.decode(ResponseData<ExampleModel>.self, from: data)
            guard let model = resData.data else {
                return
            }
            dLog("DefaultFalse: \(model.result)")
            dLog("LosslessValue: \(model.message)")
            dLog("DefaultEmptyArray: \(model.crossList)")
            dLog("LosslessValue: \(model.tel)")
            dLog("DefaultCodable: \(model.seaArea.name)")

        } catch {
            dLog(error)
        }

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

                let country = model.country + model.countrycode
                let province = model.province + model.provinceadcode
                let city = model.city + model.cityadcode
                let district = model.district + model.districtadcode

                let str = country + province + city + district
                self.dataList.append(str)

                let list = model.poiList.compactMap { ($0.name) + ($0.address) }
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
