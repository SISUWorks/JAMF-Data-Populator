//
//  ViewController.swift
//  JAMF Data Populator
//
//  Created by SISU Works on 4/20/19.
//  Copyright © 2019 SISU Works. All rights reserved.
//

import Cocoa
import Alamofire

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}

class ViewController: NSViewController {

    @IBOutlet weak var jssURL: NSTextField!
    @IBOutlet weak var userName: NSTextField!
    @IBOutlet weak var password: NSSecureTextField!
    
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    var qualifiedUserName: String = ""
    var qualifiedPassword: String = ""
    var qualifiedJSSURL: String = ""

    var xmlString: String = ""
    var dataToUpload: Data?

    @IBOutlet weak var numRecords: NSTextField!
    @IBOutlet weak var slider: NSSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.slider.isContinuous = false
        self.progressIndicator.isHidden = true
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func sliderChange(_ sender: Any) {
        let total = self.slider.integerValue
        numRecords.stringValue = "\(total)"
    }
    
    @IBAction func createRecords(_ sender: Any) {
        
        self.progressIndicator.isHidden = false
        self.progressIndicator.startAnimation(self)
        self.progressIndicator.minValue = 0.0
        self.progressIndicator.maxValue = Double(self.slider.integerValue)
        
        self.qualifiedUserName = self.userName.stringValue
        self.qualifiedPassword = self.password.stringValue
        self.qualifiedJSSURL = self.jssURL.stringValue
        
        let fullJSSURL = "\(qualifiedJSSURL)" + "/JSSResource/computers/id/0"
        
        for i in 1...self.slider.integerValue {
            
            loadResource()
            self.progressIndicator.increment(by: 1.0)
       
            let loginData = String(format: "%@:%@", qualifiedUserName, qualifiedPassword).data(using: String.Encoding.utf8)!
            let base64LoginData = loginData.base64EncodedString()
            
            var request = URLRequest(url: URL(string: fullJSSURL)!)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("text/xml", forHTTPHeaderField: "Content-Type")
            
            //let base6baseString = "\(qualifiedUserName)" + ":" + "\(qualifiedPassword)"
            //let baseEncodedData = base6baseString.data(using: .utf8)?.base64EncodedString()
            
            request.addValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
            request.httpBody = dataToUpload
            
            Alamofire.request(request).responseString { (response) in
                //print(response)
            }
        }

        self.progressIndicator.doubleValue = 0.0
        self.progressIndicator.isHidden = true
    }
    
    func loadResource()
    {
        let newMacInfo = MachineObject()
        
        if let urlPath = Bundle.main.url(forResource: "jss_computer_record", withExtension: "xml") {
            // use path
            do {
                let xmlString = try String(contentsOf: urlPath, encoding: String.Encoding.utf8)
                //pre-setup
                let replaceString0 = xmlString.replacingOccurrences(of: "platform_string", with: "Mac")
                let replaceString00 = replaceString0.replacingOccurrences(of: "make_string", with: "Apple")
                let replaceString000 = replaceString00.replacingOccurrences(of: "os_name_string", with: "Mac OS X")

                let replaceString1 = replaceString000.replacingOccurrences(of: "udid_string", with: newMacInfo.macUUID)
                let replaceString2 = replaceString1.replacingOccurrences(of: "comp_name_string", with: newMacInfo.macname)
                let replaceString3 = replaceString2.replacingOccurrences(of: "ip_string", with: newMacInfo.macIP)
                let replaceString4 = replaceString3.replacingOccurrences(of: "serial_string", with: newMacInfo.macSerial)
                let replaceString5 = replaceString4.replacingOccurrences(of: "jamf_string", with: newMacInfo.macJAMFRev)
                let replaceString6 = replaceString5.replacingOccurrences(of: "mdm_capable_string", with: newMacInfo.macMDMCapable)
                let replaceString7 = replaceString6.replacingOccurrences(of: "model_string", with: newMacInfo.macmodel)
                let replaceString8 = replaceString7.replacingOccurrences(of: "model_id_string", with: newMacInfo.macmodelID)
                let replaceString9 = replaceString8.replacingOccurrences(of: "os_version_string", with: newMacInfo.macOS)
                let replaceString10 = replaceString9.replacingOccurrences(of: "os_build_string", with: newMacInfo.macosBuild)
                let replaceString11 = replaceString10.replacingOccurrences(of: "proc_type_string", with: newMacInfo.macProc)
                let replaceString12 = replaceString11.replacingOccurrences(of: "proc_speed_string", with: newMacInfo.macProcSpeed)
                let replaceString13 = replaceString12.replacingOccurrences(of: "proc_speed_mhz_string", with: newMacInfo.macProcSpeed)
                let replaceString14 = replaceString13.replacingOccurrences(of: "number_of_procs_string", with: newMacInfo.macNumberProcs)
                let replaceString15 = replaceString14.replacingOccurrences(of: "total_ram_string", with: newMacInfo.macTotalRam)
                let replaceString16 = replaceString15.replacingOccurrences(of: "total_ram_mb_string", with: newMacInfo.macTotalRamExpanded)
                let replaceString17 = replaceString16.replacingOccurrences(of: "mac_last_contact", with: newMacInfo.macLastContact)
                dataToUpload = replaceString17.data(using: .utf8)!
            } catch {
            }
        }
    }
    
    func alertTest() {
        let a: NSAlert = NSAlert()
        a.messageText = "Delete the document?"
        a.informativeText = "Are you sure you would like to delete the document?"
        a.addButton(withTitle: "Delete")
        a.addButton(withTitle: "Cancel")
        a.alertStyle = NSAlert.Style.warning
        
        guard let window = NSApplication.shared.mainWindow else { return }
        
        a.beginSheetModal(for: window , completionHandler: { (modalResponse: NSApplication.ModalResponse) -> Void in
            if(modalResponse == NSApplication.ModalResponse.alertFirstButtonReturn){
                print("Document deleted")
            }
        })
    }
    
    
}


