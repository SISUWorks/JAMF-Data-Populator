//
//  MachineObject.swift
//  JAMF Data Populator
//
//  Created by SISU Works on 4/23/19.
//  Copyright © 2019 SISU Works. All rights reserved.
//

import Cocoa

class MachineObject: NSObject {
    
    var macname: String = ""
    var macmodel: String = ""
    var macmodelID: String = ""
    var macOS: String = ""
    var macIP: String = ""
    var macJAMFRev: String = ""
    var macMDMCapable: String = ""
    var macADBound: String = ""
    var macSerial: String = ""
    var macosBuild: String = ""
    var macUUID: String = ""
    var macProc: String = ""
    var macDate: String = ""
    var macNumberProcs: String = ""
    var macProcSpeed: String = ""
    var macTotalRam: String = ""
    var macTotalRamExpanded: String = ""
    var macLastContact: String = ""

    override init() {
        super.init()
        self.macname = machineName()
        self.macmodel = machineModel()
        self.macmodelID = machineModelIdentifier()
        self.macOS = machineOS()
        self.macIP = machineIPAddress()
        self.macJAMFRev = machineJamfVersion()
        self.macMDMCapable = machineIsMDMCapable()
        self.macADBound = machineIsBoundToAD()
        self.macSerial = machineSerialNumber()
        self.macosBuild = machineOSBuild()
        self.macUUID = machineUUIDGenerated()
        self.macProc = machineProcType()
        self.macDate = dateGenerated()
        self.macNumberProcs = machineNumProcs()
        self.macTotalRam = machineTotalRAM()
        self.macTotalRamExpanded = machineTotalRAM()
        self.macLastContact = machineLastContacttime()
    }
    
    func machineName() -> String
    {
        let compNames = ["Abe","Benny","Cinderella","Danny","Eric","Fannie","Germaine","Harold","Iggy","Jeremy","Kandice","Lenny","Mary","Nimoy","Oswald","Penny","Qbert","Regan","Schoun","Tuvok","Umbra","Victor","Williams","Xavier","Yolanda","Zara"]
        let randomChoice = (compNames.randomElement())!
        let finalName : String = "\(randomChoice)" + "\'s Mac"
        return finalName
    }

    func machineModel() -> String
    {
        
        let model_prefix = ["Macbook Air (","Macbook Pro (","iMac (","Mac Mini (","Mac Pro ("]
        let macbook_air_model_screen_size = ["11-inch ","13-inch "]
        let macbook_pro_model_screen_size = ["13-inch ","15-inch "]
        let imac_model_screen_size = ["21-inch ","27-inch "]
        let model_year_timing = ["Early ","Mid ","Late "]
        let model_year = ["2019)","2018)","2017)","2016)","2015)"]

        let random_choice_model = model_prefix.randomElement()!
        var random_choice_model_screen: String = ""
        
        if random_choice_model == "Macbook Air (" {
            random_choice_model_screen = macbook_air_model_screen_size.randomElement()!
        }
        if random_choice_model == "Macbook Pro (" {
            random_choice_model_screen = macbook_pro_model_screen_size.randomElement()!
        }
        if random_choice_model == "iMac (" {
            random_choice_model_screen = imac_model_screen_size.randomElement()!
        }
        
        if random_choice_model == "Mac Mini (" {
            random_choice_model_screen = ""
        }
        
        if random_choice_model == "Mac Pro (" {
            random_choice_model_screen = ""
        }
        
        let random_choice_season = model_year_timing.randomElement()!
        let random_choice_year = model_year.randomElement()!
        
        let finalString = "\(random_choice_model)" + "\(random_choice_model_screen)" + "\(random_choice_season)" + "\(random_choice_year)"
        
        //print("\(finalString)")
        
        return finalString
        
    }
    
    func machineModelIdentifier() -> String
    {
        let model_prefix = ["MacbookAir","MacbookPro","iMac","MacMini","MacPro"]
        let model_prefix_first_digit = Int.random(in: 0 ..< 15)
        let model_prefix_second_digit = Int.random(in: 0 ..< 15)
        
        let random_model_prefix = model_prefix.randomElement()!
        
        let finalString = "\(random_model_prefix)" + "\(model_prefix_first_digit)" + "," + "\(model_prefix_second_digit)"
        
        return finalString
    }
    
    func machineOS() -> String
    {
        let major_os_list = ["10.14.","10.13.","10.12.","10.11.","10.10."]
        let minor_os_suffix = Int.random(in: 0 ..< 7)
        let minor_os_suffix_asString = String(minor_os_suffix)
        let random_os_major = major_os_list.randomElement()!
        
        let finalString = "\(random_os_major)" + "\(minor_os_suffix_asString)"
        
        return finalString
    }
    
    func machineIPAddress() -> String
    {
        let first_octet = Int.random(in: 0 ... 255)
        let second_octet = Int.random(in: 0 ... 255)
        let third_octet = Int.random(in: 0 ... 255)
        let fourth_octet = Int.random(in: 0 ... 255)
        
        let finalString = "\(first_octet)." + "\(second_octet)." + "\(third_octet)." + "\(fourth_octet)"
        return finalString
    }
    
    func machineJamfVersion() -> String
    {
        let major_jamf_version = Int.random(in: 0 ... 9)
        let minor_jamf_version = Int.random(in: 0 ... 9)
        let finalString = "\(major_jamf_version)" + "\(minor_jamf_version)"
        return finalString
    }
    
    func machineIsMDMCapable() -> String
    {
        let mdmCapable = ["Yes", "No"]
        let finalChoice = mdmCapable.randomElement()!
        return finalChoice
    }
    
    func machineIsBoundToAD() -> String
    {
        let isBound = ["Not Bound", "FakeOrg.com"]
        let finalChoice = isBound.randomElement()!
        return finalChoice
    }
    
    func machineSerialNumber() -> String
    {
        let charSet: String  = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = 12
        let randomCharacters = (0..<length).map{_ in charSet.randomElement()!}
        let randomString = String(randomCharacters)
        return randomString
    }
    
    func machineOSBuild() -> String
    {
        let charSet: String  = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = 5
        let randomCharacters = (0..<length).map{_ in charSet.randomElement()!}
        let randomString = String(randomCharacters)
        return randomString
    }
    
    func machineUUIDGenerated() -> String
    {
        let uuidString = NSUUID.init().uuidString
        return uuidString
    }

    func machineProcType() -> String
    {
        let procType = ["Intel Core i7","Intel Core i5","Intel Core i3","Intel Core Duo","Intel Xeon","Intel Core 2 Duo"]
        let procTypeFinal = procType.randomElement()!
        return procTypeFinal
    }

    func generateRandomDate(daysBack: Int)-> Date?{
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = -Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
    }
    
    func dateGenerated() -> String
    {
        let tempDate = generateRandomDate(daysBack: 3000)!
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: tempDate) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
 
    func machineNumProcs() -> String
    {
        let numberProcs = ["1","2","4","6","8","12"]
        let randomChoice = (numberProcs.randomElement())!
        return randomChoice
    }
    
    func machineProcSpeed() -> String
    {
        let procSpeedsMajor = ["1.","2.","3.","4."]
        let procSpeedMinor = Int.random(in: 1 ... 9)
        let randomMajorChoice = (procSpeedsMajor.randomElement())!
        let finalString = "\(randomMajorChoice)" + "\(procSpeedMinor)"
        return finalString
    }
    
    func machineTotalRAM() -> String
    {
        let ramSpeedBase = Int.random(in: 1 ... 12)
        let finalString = "\(ramSpeedBase)"
        return finalString
    }
    
    func machineTotalRAMModded() -> String
    {
        let ramSpeedBase = Int.random(in: 1 ... 12)
        let ramSpeedModded = ramSpeedBase * 1024
        let finalString = "\(ramSpeedModded)"
        return finalString
    }
    
    func machineLastContacttime() -> String
    {
        let tempDate = generateRandomDate(daysBack: 90)!
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: tempDate) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
}
