//
//  SJSDateFormatter.swift
//  SJS+ Employee
//
//  Created by Yudha on 23/08/22.
//

import Foundation

class SJSDateFormatter {
    static let shared = SJSDateFormatter()
    
    ///News date string format: "yyyy-MM-dd hh:mm:ss"
    func createNewsDateText(dateString: String?) -> String {
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: "id")
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let postDate = df.date(from: dateString ?? "2000-01-01 00:00:00")
        
        let diffComponents = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: postDate ?? Date(), to: Date())
        let seconds = diffComponents.second ?? 0
        let minute = diffComponents.minute ?? 0
        let hour = diffComponents.hour ?? 0
        let day = diffComponents.day ?? 0
        let month = diffComponents.month ?? 0
        let year = diffComponents.year ?? 0
        
        var timeText = ""
        
        if year != 0 {
            timeText = "\(year) tahun yang lalu"
        } else if month != 0 {
            timeText = "\(month) bulan yang lalu"
        } else if day != 0 {
            timeText = "\(day) hari yang lalu"
        } else if hour != 0 {
            timeText = "\(hour) jam yang lalu"
        } else if minute != 0 {
            timeText = "\(minute) menit yang lalu"
        } else {
            timeText = "\(seconds) detik yang lalu"
        }
        
        return timeText
    }
    
    func createSlipGajiMonths() -> [String] {
        let df = DateFormatter()
        df.locale = Locale(identifier: "id")
        
        let diffComponents = Calendar.current.dateComponents([.year], from: Date())
        let monthsArray = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
        var array: [String] = []
        
        for item in monthsArray {
            array.append("\(item)" + " \(diffComponents.year ?? 1970)")
        }
        
        return array
    }
    
    ///Date format: "MMMM yyyy".
    func createMonthYearString(date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "id")
        df.dateFormat = "MMMM yyyy"
        
        return df.string(from: date)
    }
    
    ///Date Format: "MMMM yyyy".
    ///Returns M yyyy.
    func convertMonthYearString(str: String) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "id")
        df.dateFormat = "MMMM yyyy"
        
        let date = df.date(from: str)
        
        df.dateFormat = "M yyyy"
        return df.string(from: date ?? Date())
    }
}
