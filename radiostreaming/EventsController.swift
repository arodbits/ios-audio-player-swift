//
//  EventsController.swift
//  radiostreaming
//
//  Created by Anthony Rodriguez on 5/8/15.
//  Copyright (c) 2015 capitalofcode. All rights reserved.
//

import Foundation
import UIKit

class EventsController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var promotions: NSArray = NSArray()

    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var eventsCount: UILabel!
    
    @IBOutlet weak var viewActivity: UIActivityIndicatorView!
    var backgroundImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewActivity.hidesWhenStopped = true
        self.viewActivity.startAnimating()
        
        myTableView.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        myTableView.backgroundView = blurEffectView
        myTableView.backgroundView?.addSubview(UIImageView(image: self.backgroundImage))
        
        let promotionService = PromotionService()
        promotionService.all { (result, error) -> Void in
            let result = NSJSONSerialization.JSONObjectWithData(result!, options: nil, error: nil) as! NSDictionary
            self.promotions = result["promotions"] as! NSArray
            if (self.promotions.count > 0) {
                self.refresh()
            }
        }
    }
    
    @IBAction func backPressed(sender: UIButton) {
        self.performSegueWithIdentifier("backToPlayer", sender: self)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func refresh(){
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
           self.myTableView.reloadData()
           self.eventsCount.text = String(stringInterpolationSegment: self.promotions.count)
           self.viewActivity.stopAnimating()
        })
    }
    
    func getNameDayOfWeek(day: Int)->String?{
        let nameOfDayOfWeek = [
            1 : "Sunday",
            2 : "Monday",
            3 : "Tuesday",
            4 : "Wednesday",
            5 : "Thursday",
            6 : "Friday",
            7 : "Saturday"
        ]
        return nameOfDayOfWeek[day]
    }
    
    func getNameOfMonth(month: Int)->String?{
        let nameOfMonths = [
            1 : "JAN",
            2 : "FEB",
            3 : "MAR",
            4 : "APR",
            5 : "MAY",
            6 : "JUN",
            7 : "JUL",
            8 : "AUG",
            9 : "SEP",
            10 : "OCT",
            11 : "NOV",
            12 : "DEC"
        ]
        return nameOfMonths[month]
    }
    
    func getDayOfWeek(date: String)->Int{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDay = formatter.dateFromString(date)
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let calendarComponent = calendar?.components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: formattedDay!)
        let weekday = calendarComponent!.weekday
        return weekday
    }
    //Refactor this function later
    func getMonth(date: String)->Int{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDay = formatter.dateFromString(date)
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let calendarComponent = calendar?.components(NSCalendarUnit.MonthCalendarUnit, fromDate: formattedDay!)
        let month = calendarComponent!.month
        return month
    }
    
    //Refactor this function later
    func getDay(date: String)->Int{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDay = formatter.dateFromString(date)
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let calendarComponent = calendar?.components(NSCalendarUnit.DayCalendarUnit, fromDate: formattedDay!)
        let day = calendarComponent!.day
        return day
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.promotions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.myTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventsCells;
        var promotions: NSDictionary = self.promotions[indexPath.row] as! NSDictionary

        cell.name.text = String(stringInterpolationSegment: promotions["title"]!)
        cell.address.text = String(stringInterpolationSegment: promotions["address"]!)
        cell.hour.text = String(stringInterpolationSegment: promotions["time"]!)
        let dayweek = self.getNameDayOfWeek(self.getDayOfWeek(String(stringInterpolationSegment: promotions["date"]!)))
        let month = self.getNameOfMonth(self.getMonth(String(stringInterpolationSegment: promotions["date"]!)))
        let day = self.getDay(String(stringInterpolationSegment: promotions["date"]!))
        cell.dayWeek.text = dayweek
        cell.month.text = month
        cell.day.text = String(stringInterpolationSegment: day)
        return cell
    }

}
