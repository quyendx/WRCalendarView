//
//  ViewController.swift
//  WRCalendarView
//
//  Created by wayfinder on 04/26/2017.
//  Copyright (c) 2017 wayfinder. All rights reserved.
//

import UIKit
import WRCalendarView

class MainCont: UIViewController {
    @IBOutlet private weak var weekView: WRWeekView!
    @IBOutlet private weak var btnCalendarViewType: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCalendarData()
        
        //add today button
        let rightButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(moveToToday))
        navigationItem.rightBarButtonItem = rightButton
        
        //add events
        weekView.addEvent(event: WREvent.make(date: Date(), chunk: 2.hours, title: "#1"))
        weekView.addEvent(event: WREvent.make(date: Date(), chunk: 1.hours, title: "#2"))
        weekView.addEvent(event: WREvent.make(date: Date().add(90.minutes), chunk: 1.hours, title: "#3"))
        weekView.addEvent(event: WREvent.make(date: Date().add(110.minutes), chunk: 1.hours, title: "#4"))

        weekView.addEvent(event: WREvent.make(date: Date().add(1.days), chunk: 1.hours, title: "tomorrow"))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc
    private func moveToToday() {
        weekView.setCalendarDate(Date(), animated: true)
    }
    
    // MARK: - WRCalendarView
    func setupCalendarData() {
        weekView.setCalendarDate(Date())
        weekView.delegate = self
        weekView.calendarType = .week

        btnCalendarViewType.title = "Day view"
    }

    @IBAction private func changeCalendarViewType(_ sender: Any) {
        let type = weekView.calendarType
        if type == .day {
            weekView.calendarType = .week
            btnCalendarViewType.title = "Day view"
        } else {
            weekView.calendarType = .day
            btnCalendarViewType.title = "Week view"
        }
    }
    
    func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return min(statusBarSize.width, statusBarSize.height)
    }
}

extension MainCont: WRWeekViewDelegate {
    func view(startDate: Date, interval: Int) {
        print(startDate, interval)
    }
    
    func tap(date: Date) {
        print(date)
    }
    
    func selectEvent(_ event: WREvent) {
        print(event.title)
    }
}
