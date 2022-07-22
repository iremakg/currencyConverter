//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by irem on 22.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getRatesClicked(_ sender: Any) {
        
        //!) request & Session (internete gidip istek yollamak )
        //2)Response & Data  (isteği almnak)
        //3)Parsing & JSON serialization (Datayı işlemek)
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: url!) { (data, respons, error ) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                
                self.present(alert , animated: true, completion: nil)
            }else{
                //2.
                if data != nil{
                    do{
                        let jsonResponse =   try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary< String, Any >
                           
                        
                        //ASYNC
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any] {
                                //print(rates)
                                
                                
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF: \(chf)"
                    
                                }
                                
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                
                                if let turkish = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY: \(turkish)"
                                }
                                    
                            }
                        }
                        
                    }catch{
                        print("error")
                    }
                
                }
            }
        }
        
        task.resume()
    }
    


}

