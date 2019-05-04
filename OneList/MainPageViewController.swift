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
    @IBOutlet weak var tableView: UITableView!
    
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
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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
        if !leftMenuIsOpen && !TitleList.contains(titleTextField.text!) {
            TitleList.append(titleTextField.text!)
            Details[titleTextField.text!] = []
            tableView.reloadData()
        }
        selectViewBottomConstraints.constant = 0
        datePickerBottomConstraints.constant = -216
        leftMenuWidthConstraints.constant = 0
        leftMenuIsOpen = false
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
        titleTextField.text = "标题"
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

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = sender as! IndexPath
        let to = segue.destination as! DetailViewController
        to.listTitle = TitleList[info.row]
        to.detailList = Details[to.listTitle!]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TitleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableCell", for: indexPath) as! GroupTableViewCell
        cell.titleLabel.text = TitleList[indexPath.row]
        let list:[String?] = Details[TitleList[indexPath.row]]!
        cell.textLabel1.text = list.count > 0 ? list[0] : ""
        cell.textLabel2.text = list.count > 1 ? list[1] : ""
        cell.textLabel3.text = list.count > 2 ? list[2] : ""
        cell.textLabel4.text = list.count > 3 ? list[3] : ""
        cell.textLabel5.text = list.count > 4 ? list[4] : ""
        cell.indexPath = indexPath
        cell.mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handle(sender: ))))
        return cell
    }
    
    @objc func handle(sender: UITapGestureRecognizer) {
        let cell = sender.view?.superview?.superview as! GroupTableViewCell
        print("hello")
        performSegue(withIdentifier: "move", sender: cell.indexPath)
    }
}
