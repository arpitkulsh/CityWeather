//
//  CityViewController.swift
//  CityWeather
//
//  Created by Arpit Kulshrestha on 05/04/23.
//

import UIKit

class CityViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    
    var cityItem: [String] = []
    var selectedState: String = ""
    @IBOutlet var cityTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource = self
        guard let path = Bundle.main.path(forResource: "CityList", ofType: "plist") else {return}

        let url = URL(fileURLWithPath: path)

        let data = try! Data(contentsOf: url)

        guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String:[String]] else {return}
        cityItem = plist[selectedState]!
        print(cityItem)
        cityTableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as? CityTableViewCell else {
            return UITableViewCell()
        }
        cell.cityText.text = cityItem[indexPath.row]
      // UserDefaults.standard.set(state, forKey: "State")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cityItem[indexPath.row]
        UserDefaults.standard.set(city, forKey: "City")
        self.navigationController?.popToRootViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
