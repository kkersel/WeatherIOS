//
//  detailVC.swift
//  weather4.0
//
//  
//

import UIKit
import SwiftyJSON
import Alamofire

class detailVC: UIViewController {

    var cityName = ""
    
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temp_c: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var DayOfWeekLabel: UILabel!
    
    override func viewDidLoad() {
        
        CurrentDate()
        currentWeather(city: cityName)
        
        let colorTOP = UIColor(displayP3Red: 89 / 255, green: 156 / 255, blue: 169 / 255, alpha: 1.0).cgColor
        let colorBOTTOM = UIColor(displayP3Red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1.0).cgColor
        
        let GradientLaeyr = CAGradientLayer()
        GradientLaeyr.frame = self.view.bounds
        GradientLaeyr.colors = [colorTOP, colorBOTTOM]
        GradientLaeyr.startPoint = CGPoint(x: 0.0, y: 0.0)
        GradientLaeyr.endPoint = CGPoint(x: 0.0, y: 1.0)
        self.view.layer.insertSublayer(GradientLaeyr, at: 0)
    }
    
    func CurrentDate(){
        let date = Date()
        let MonthFormat = DateFormatter()
        MonthFormat.dateFormat = "MM-dd-yyyy"
        let Month = MonthFormat.string(from: date)

        let DayYearFormat = DateFormatter()
        DayYearFormat.dateFormat = "MM-dd-yyyy"
        let DayYear = DayYearFormat.string(from: date)
        let DateArgument = (Month + "\n" + DayYear)
        DateLabel.text = DateArgument
    }
    
    func DayOfWeek() {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        var otherweekdayStrings: [String] = []
        for i in 1...6 {
            let timeIntervalToAdd = TimeInterval(i * 86400)
            otherweekdayStrings.append(formatter.string(from: today.addingTimeInterval(timeIntervalToAdd)))
        }
    }
    
    func currentWeather(city: String) {
        
        let url = "https://api.weatherapi.com/v1/current.json?key=a7143f14ce0c46668ee115803202410&q=\(city)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let name = json["location"]["name"].stringValue
                let temp = json["current"]["temp_c"].doubleValue
                let country = json["location"]["country"].stringValue
                let weatherURLSting = "https:\(json["location"][0]["icon"].stringValue)"
                
                self.cityNameLabel.text = name
                self.temp_c.text = String(temp)
                self.countryLabel.text = country

                let weatherURL = URL(string: weatherURLSting)
                if let data = try? Data(contentsOf: weatherURL!) {
                    self.imageWeather.image = UIImage(data: data)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
