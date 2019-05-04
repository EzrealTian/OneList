//
//  MainPageViewController.swift
//  OneList
//
//  Created by 田逸昕 on 2019/4/24.
//  Copyright © 2019 Ezreal. All rights reserved.
//

import UIKit

let weekdayList = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
class MainPageViewController: UIViewController {

    @IBOutlet weak var leftMenuWidthConstraints: NSLayoutConstraint!
    @IBOutlet weak var selectDateConstraints: NSLayoutConstraint!
    @IBOutlet weak var datePickerBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var selectViewBottomConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var visualEffectView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startYear: UILabel!
    @IBOutlet weak var startMonth: UILabel!
    @IBOutlet weak var startDay: UILabel!
    @IBOutlet weak var endYear: UILabel!
    @IBOutlet weak var endMonth: UILabel!
    @IBOutlet weak var endDay: UILabel!
    
    var leftMenuIsOpen = false
    var isStart = true
    var isDatePickerDown = true
    var component: DateComponents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calender = Calendar.current
        component = calender.dateComponents([.year, .month, .day, .weekday], from: Date())
        dateLabel.text = "\(weekdayList[component!.weekday! - 1]) \(component!.month!)月\(component!.day!)日"
        initDatePicker(component: component!)
        
        leftMenuWidthConstraints.constant = 0
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(visualEffectViewWithdraw)))
        datePicker.addTarget(self, action: #selector(datePickerChange(datePicker:)), for: .valueChanged)
        titleTextField.delegate = self
        startYear.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startTimeEditGesture)))
        startMonth.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startTimeEditGesture)))
        startDay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startTimeEditGesture)))
        endYear.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endTimeEditGesture)))
        endMonth.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endTimeEditGesture)))
        endDay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endTimeEditGesture)))
        // Do any additional setup after loading the view.
    }
    
    private func initDatePicker(component: DateComponents) {
        startYear.text = "\(component.year!)"
        startMonth.text = "\(component.month!)"
        startDay.text = "\(component.day!)"
        endYear.text = "\(component.year!)"
        endMonth.text = "\(component.month!)"
        endDay.text = "\(component.day!)"
    }
    
    @objc func datePickerChange(datePicker: UIDatePicker) {
        let date = datePicker.date
        let format1 = DateFormatter.init()
        format1.dateFormat = "yyyy"
        let format2 = DateFormatter.init()
            format2.dateFormat = "MM"
        let format3 = DateFormatter.init()
            format3.dateFormat = "dd"
        if isStart {
            startYear.text = format1.string(from: date)
            startMonth.text = format2.string(from: date)
            startDay.text = format3.string(from: date)
        } else {
            endYear.text = format1.string(from: date)
            endMonth.text = format2.string(from: date)
            endDay.text = format3.string(from: date)
        }
        //print("year:\(format1.string(from: date))")
        //print("month:\(format2.string(from: date))")
        //print("day:\(format3.string(from: date))")

    }
    
    @objc func startTimeEditGesture() {
        print("hello")
        if !isStart {
            isStart = !isStart
            selectDateConstraints.constant -= 33
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        if isDatePickerDown {
            isDatePickerDown = !isDatePickerDown
            datePickerBottomConstraints.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func endTimeEditGesture() {
        if isStart {
            isStart = !isStart
            selectDateConstraints.constant += 33
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        if isDatePickerDown {
            isDatePickerDown = !isDatePickerDown
            datePickerBottomConstraints.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func visualEffectViewWithdraw() {
        selectViewBottomConstraints.constant = 0
        datePickerBottomConstraints.constant = -216
        leftMenuWidthConstraints.constant = 0
        leftMenuIsOpen = leftMenuIsOpen ? false : true
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        titleTextField.resignFirstResponder()
        visualEffectView.isHidden = true
        isDatePickerDown = true
    }
    
    
    @IBAction func leftMenuButtonTapped(_ sender: Any) {
         leftMenuWidthConstraints.constant = leftMenuIsOpen ? 0 : 165
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        visualEffectView.isHidden = false
        leftMenuIsOpen = !leftMenuIsOpen
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        initDatePicker(component: component!)
        visualEffectView.isHidden = false
        selectViewBottomConstraints.constant = 500
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
}


extension MainPageViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !isDatePickerDown {
            isDatePickerDown = !isDatePickerDown
            datePickerBottomConstraints.constant = -216
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
