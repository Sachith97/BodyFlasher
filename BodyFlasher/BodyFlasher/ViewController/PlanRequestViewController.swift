//
//  PlanRequestViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-07.
//
//  used swiftui library to create state vars
//

import UIKit
import AVKit
import AVFoundation

class PlanRequestViewController: UIViewController {
    
    var authDetail: LoginResponseDetail = LoginResponseDetail()
    
    // av player properties
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    let heightDataValues = 110...243
    let weightDataValues = 20...180
    
    var heightData: [String] = []
    var weightData: [String] = []
    var goalData = ["Cardio", "Shoulders", "Biceps", "Chest", "Abs", "Forearms", "Triceps", "Lower Back", "Quads", "Calves"]
    
    var workoutPlanRequest = WorkoutPlanRequest()
    var networkManager = NetworkManager()
    var spinnerHandler = SpinnerHandler()
    
    private let spinner: Spinner = {
        let spinner = Spinner()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // initial elements
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userDetailHeader : UserDetailHeader = {
        let userDetailHeader = UserDetailHeader()
        userDetailHeader.backgroundColor = UIColor.clear
        userDetailHeader.translatesAutoresizingMaskIntoConstraints = false
        return userDetailHeader
    }()
    
    let startButton : UIButton = {
        let button = UIButton()
        button.setTitle("GET MY PLAN", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 14.0)
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(enableSurvey), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let homeButton : UIButton = {
        let button = UIButton()
        button.setTitle("HOME", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 14.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let closeContainer: UIView = {
        let view = UIView()
        view.isHidden = true
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeRequest), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let infoContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let infoOneHeaderLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "semi-yellow")
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "New & Improved Trainer"
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoOneLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 16.0)
        label.text = "A brand new look, upgraded workout plans, and a more advanced training method for even better results"
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoTwoHeaderLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "semi-yellow")
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "Smarter Workout Experience"
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoTwoLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 16.0)
        label.text = "Now your training just got smarter, with a more sophisticated training models weight and rep suggessions, that's based on your request"
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoThreeHeaderLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "semi-yellow")
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "Better Exercise Information"
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoThreeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 16.0)
        label.text = "All new videos with advanced training tips on proper form and a lifting history graph to tracj your exerice time and performance"
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let formStack : UIView = {
        let stackView = UIView()
        stackView.isHidden = true
        stackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 120, right: 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // first form elements
    let firstQuestionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "What is your gender?"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let maleButton : UIButton = {
        let button = UIButton()
        button.setTitle("MALE", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(setGenderMale), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let femaleButton : UIButton = {
        let button = UIButton()
        button.setTitle("FEMALE", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(setGenderFemale), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // second form elements
    let secondQuestionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "What is your birthday?"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let agePicker : UIDatePicker = {
        // create a calender
        let calendar = Calendar.current
        var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        minDateComponent.day = 01
        minDateComponent.month = 01
        minDateComponent.year = 1950
        let minDate = calendar.date(from: minDateComponent)
        // create the date picker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = minDate! as Date
        datePicker.maximumDate = Date()
        datePicker.semanticContentAttribute = .forceRightToLeft
        datePicker.subviews.first?.semanticContentAttribute = .forceRightToLeft
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    let birthdayField : UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let ageSubmitButton : UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(processSecondForm), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // third form elements
    let thirdQuestionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "What's your height?"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let heightPicker : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    let heightField : UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let heightSubmitButton : UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(processThirdForm), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // fourth form elements
    let fourthQuestionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "What's your weight?"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let weightPicker : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    let weightField : UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let weightSubmitButton : UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(processFourthForm), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // fifth form elements
    let fifthQuestionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "What's your fitness goal?"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let goalPicker : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    let goalField : UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let goalSubmitButton : UIButton = {
        let button = UIButton()
        button.setTitle("PROCESS", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(processFifthForm), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // sixth form elements
    let generatePlanInfoLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "All set! Let's generate your plan!"
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let generatePlanButton : UIButton = {
        let button = UIButton()
        button.setTitle("GENERATE PLAN", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(generatePlan), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {

        let theURL = Bundle.main.url(forResource:"home-vid", withExtension: "mov")

        avPlayer = AVPlayer(url: theURL!)
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayerLayer.frame = self.view.layer.bounds
        
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none

        avPlayerLayer.frame = view.layer.bounds
        
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        // hide default nav bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerItemDidReachEnd(notification:)),
                                           name: .AVPlayerItemDidPlayToEndTime,
                                           object: avPlayer.currentItem)
        
        // set user's details
        self.userDetailHeader.usernameLabel.text = (self.authDetail.user?.firstName ?? "Anonymous") + " " + (self.authDetail.user?.lastName ?? "User")
        self.userDetailHeader.professionLabel.text = (self.authDetail.user?.profession ?? "Profession")
        
        // initiate data sources
        heightData = heightDataValues.map(String.init)
        weightData = weightDataValues.map(String.init)
        
        closeButton.tintColor = .white
        closeContainer.addSubview(closeButton)
        
        // initialize stack views
        formStack.addSubview(firstQuestionLabel)
        formStack.addSubview(maleButton)
        formStack.addSubview(femaleButton)
        
        infoContainer.addSubview(infoOneHeaderLabel)
        infoContainer.addSubview(infoOneLabel)
        infoContainer.addSubview(infoTwoHeaderLabel)
        infoContainer.addSubview(infoTwoLabel)
        infoContainer.addSubview(infoThreeHeaderLabel)
        infoContainer.addSubview(infoThreeLabel)
        
        // add components
        view.addSubview(spinner)
        view.addSubview(backgroundView)
        view.addSubview(userDetailHeader)
        view.addSubview(closeContainer)
        view.addSubview(formStack)
        view.addSubview(startButton)
        view.addSubview(homeButton)
        view.addSubview(infoContainer)
        setupConstraintsFirstForm()
    }

    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: .zero)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayer.play()
        paused = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
    
    @objc func closeRequest() {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to exit from plan creation?", preferredStyle: .alert)
        
        // create a "Confirm" action
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { (_) in
            self.goToHome()
        }
        alert.addAction(confirmAction)
        
        // create a "Cancel" action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        // present the alert
        present(alert, animated: true, completion: nil)
    }
    
    @objc func enableSurvey() {
        closeContainer.isHidden = false
        formStack.isHidden = false
        startButton.isHidden = true
        homeButton.isHidden = true
        userDetailHeader.isHidden = true
        infoContainer.isHidden = true
        backgroundView.isHidden = true
    }
    
    @objc func goToHome() {
        let homeTabVC = TabViewController()
        homeTabVC.authDetail = self.authDetail
        self.navigationController?.pushViewController(homeTabVC, animated: true)
    }
    
    func createAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func setGenderMale() {
        // set struct instance value
        workoutPlanRequest.gender = "Male"
        processFirstForm()
    }
    
    @objc func setGenderFemale() {
        // set struct instance value
        workoutPlanRequest.gender = "Female"
        processFirstForm()
    }
    
    func processFirstForm() {
        formStack.subviews.forEach {
            $0.removeFromSuperview()
        }
        arrangeSecondForm()
    }
    
    @objc func arrangeSecondForm() {
        createBirthdayPicker()
        // initialize stack views
        formStack.addSubview(secondQuestionLabel)
        formStack.addSubview(birthdayField)
        formStack.addSubview(ageSubmitButton)
        
        setupConstraintsSecondForm()
    }
    
    func createBirthdayPicker() {
        birthdayField.inputView = agePicker
        birthdayField.inputAccessoryView = createDatePickerToolBar()
    }
    
    func createDatePickerToolBar() -> UIToolbar {
        // toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(setBirthday))
        toolBar.setItems([doneBtn], animated: true)
        
        return toolBar
    }
    
    @objc func setBirthday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.birthdayField.text = dateFormatter.string(from: agePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func processSecondForm() {
        if (!birthdayField.hasText) {
            createAlert(title: nil, message: "Please select your birthday")
        } else {
            // set struct instance value
            workoutPlanRequest.birthday = agePicker.date
            // clear form and proceed
            formStack.subviews.forEach {
                $0.removeFromSuperview()
            }
            arrangeThirdForm()
        }
    }
    
    @objc func arrangeThirdForm() {
        createHeightPicker()
        // initialize stack views
        formStack.addSubview(thirdQuestionLabel)
        formStack.addSubview(heightField)
        formStack.addSubview(heightSubmitButton)
        
        setupConstraintsThirdForm()
    }
    
    func createHeightPicker() {
        heightField.inputView = heightPicker
        heightField.inputAccessoryView = createHeightPickerToolBar()
        
        heightPicker.delegate = self
        heightPicker.dataSource = self
        
        heightPicker.tag = 1
    }
    
    func createHeightPickerToolBar() -> UIToolbar {
        // toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(setHeight))
        toolBar.setItems([doneBtn], animated: true)
        
        return toolBar
    }
    
    @objc func setHeight() {
        self.heightField.text = heightData[heightPicker.selectedRow(inComponent: 0)]
        self.view.endEditing(true)
    }
    
    @objc func processThirdForm() {
        if (!heightField.hasText) {
            createAlert(title: nil, message: "Please select your height")
        } else {
            // set struct instance value
            workoutPlanRequest.height = Int(heightField.text!)
            // clear form and proceed
            formStack.subviews.forEach {
                $0.removeFromSuperview()
            }
            arrangeFourthForm()
        }
    }
    
    @objc func arrangeFourthForm() {
        createWeightPicker()
        // initialize stack views
        formStack.addSubview(fourthQuestionLabel)
        formStack.addSubview(weightField)
        formStack.addSubview(weightSubmitButton)
        
        setupConstraintsFourthForm()
    }
    
    func createWeightPicker() {
        weightField.inputView = weightPicker
        weightField.inputAccessoryView = createWeightPickerToolBar()
        
        weightPicker.delegate = self
        weightPicker.dataSource = self
        
        weightPicker.tag = 2
    }
    
    func createWeightPickerToolBar() -> UIToolbar {
        // toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(setWeight))
        toolBar.setItems([doneBtn], animated: true)
        
        return toolBar
    }
    
    @objc func setWeight() {
        self.weightField.text = weightData[weightPicker.selectedRow(inComponent: 0)]
        self.view.endEditing(true)
    }
    
    @objc func processFourthForm() {
        if (!weightField.hasText) {
            createAlert(title: nil, message: "Please select your weight")
        } else {
            // set struct instance value
            workoutPlanRequest.weight = Int(weightField.text!)
            // clear form and proceed
            formStack.subviews.forEach {
                $0.removeFromSuperview()
            }
            arrangeFifthForm()
        }
    }
    
    @objc func arrangeFifthForm() {
        createGoalPicker()
        // initialize stack views
        formStack.addSubview(fifthQuestionLabel)
        formStack.addSubview(goalField)
        formStack.addSubview(goalSubmitButton)
        
        setupConstraintsFifthForm()
    }
    
    func createGoalPicker() {
        goalField.inputView = goalPicker
        goalField.inputAccessoryView = createGoalPickerToolBar()
        
        goalPicker.delegate = self
        goalPicker.dataSource = self
        
        goalPicker.tag = 3
    }
    
    func createGoalPickerToolBar() -> UIToolbar {
        // toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(setGoal))
        toolBar.setItems([doneBtn], animated: true)
        
        return toolBar
    }
    
    @objc func setGoal() {
        self.goalField.text = goalData[goalPicker.selectedRow(inComponent: 0)]
        self.view.endEditing(true)
    }
    
    @objc func processFifthForm() {
        if (!goalField.hasText) {
            createAlert(title: nil, message: "Please select your goal")
        } else {
            // set struct instance value
            workoutPlanRequest.goal = goalField.text!
            // clear form and proceed
            formStack.subviews.forEach {
                $0.removeFromSuperview()
            }
            arrangeSixthForm()
        }
    }
    
    @objc func arrangeSixthForm() {
        // initialize stack views
        formStack.addSubview(generatePlanInfoLabel)
        formStack.addSubview(generatePlanButton)
        
        setupConstraintsSixthForm()
    }
    
    @objc func generatePlan() {
        // send request
        sendWorkoutPlanRequest()
    }
    
    func sendWorkoutPlanRequest() {
        spinnerHandler.handle(source: self.view, spinner: self.spinner, status: true)
        networkManager.sendWorkoutPlanRequest(planRequest: self.workoutPlanRequest, jwt: authDetail.jwt ?? "") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.spinnerHandler.handle(source: self.view, spinner: self.spinner, status: false)
                    if (response.ok ?? false) {
                        self.goToHome()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.spinnerHandler.handle(source: self.view, spinner: self.spinner, status: false)
                    print("Error occurred: \(error.localizedDescription)")
                    self.createAlert(title: "Error", message: "Error occurred")
                }
            }
        }
    }
    
    func setupConstraintsFirstForm() {
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: view.topAnchor),
            spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            userDetailHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userDetailHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userDetailHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            userDetailHeader.heightAnchor.constraint(equalToConstant: 40),
            
            closeContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            closeContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            closeContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            closeContainer.heightAnchor.constraint(equalToConstant: 60),
            
            closeButton.topAnchor.constraint(equalTo: closeContainer.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: closeContainer.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            
            formStack.topAnchor.constraint(equalTo: closeContainer.bottomAnchor, constant: 10),
            formStack.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -50),
            formStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            formStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            firstQuestionLabel.topAnchor.constraint(equalTo: formStack.topAnchor, constant: 100),
            firstQuestionLabel.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            firstQuestionLabel.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            
            maleButton.bottomAnchor.constraint(equalTo: femaleButton.topAnchor, constant: -20),
            maleButton.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            maleButton.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            maleButton.heightAnchor.constraint(equalToConstant: 40),
            
            femaleButton.bottomAnchor.constraint(equalTo: formStack.bottomAnchor, constant: -100),
            femaleButton.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            femaleButton.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            femaleButton.heightAnchor.constraint(equalToConstant: 40),
            
            startButton.heightAnchor.constraint(equalToConstant: 40),
            startButton.bottomAnchor.constraint(equalTo: homeButton.topAnchor, constant: -10),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            homeButton.heightAnchor.constraint(equalToConstant: 40),
            homeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            homeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            homeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            infoContainer.topAnchor.constraint(equalTo: userDetailHeader.bottomAnchor, constant: 20),
            infoContainer.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20),
            infoContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            infoContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            infoOneHeaderLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 40),
            infoOneHeaderLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor),
            infoOneHeaderLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor),
            
            infoOneLabel.topAnchor.constraint(equalTo: infoOneHeaderLabel.bottomAnchor, constant: 7),
            infoOneLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor),
            infoOneLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor),
            
            infoTwoHeaderLabel.topAnchor.constraint(equalTo: infoOneLabel.bottomAnchor, constant: 40),
            infoTwoHeaderLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor),
            infoTwoHeaderLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor),
            
            infoTwoLabel.topAnchor.constraint(equalTo: infoTwoHeaderLabel.bottomAnchor, constant: 7),
            infoTwoLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor),
            infoTwoLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor),
            
            infoThreeHeaderLabel.topAnchor.constraint(equalTo: infoTwoLabel.bottomAnchor, constant: 40),
            infoThreeHeaderLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor),
            infoThreeHeaderLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor),
            
            infoThreeLabel.topAnchor.constraint(equalTo: infoThreeHeaderLabel.bottomAnchor, constant: 7),
            infoThreeLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor),
            infoThreeLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor)
        ])
    }
    
    func setupConstraintsSecondForm() {
        NSLayoutConstraint.activate([
            secondQuestionLabel.topAnchor.constraint(equalTo: formStack.topAnchor, constant: 100),
            secondQuestionLabel.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            secondQuestionLabel.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            
            birthdayField.bottomAnchor.constraint(equalTo: ageSubmitButton.topAnchor, constant: -60),
            birthdayField.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            birthdayField.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            birthdayField.heightAnchor.constraint(equalToConstant: 40),
            
            ageSubmitButton.bottomAnchor.constraint(equalTo: formStack.bottomAnchor, constant: -100),
            ageSubmitButton.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            ageSubmitButton.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            ageSubmitButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupConstraintsThirdForm() {
        NSLayoutConstraint.activate([
            thirdQuestionLabel.topAnchor.constraint(equalTo: formStack.topAnchor, constant: 100),
            thirdQuestionLabel.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            thirdQuestionLabel.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            
            heightField.bottomAnchor.constraint(equalTo: heightSubmitButton.topAnchor, constant: -60),
            heightField.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            heightField.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            heightField.heightAnchor.constraint(equalToConstant: 40),
            
            heightSubmitButton.bottomAnchor.constraint(equalTo: formStack.bottomAnchor, constant: -100),
            heightSubmitButton.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            heightSubmitButton.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            heightSubmitButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupConstraintsFourthForm() {
        NSLayoutConstraint.activate([
            fourthQuestionLabel.topAnchor.constraint(equalTo: formStack.topAnchor, constant: 100),
            fourthQuestionLabel.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            fourthQuestionLabel.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            
            weightField.bottomAnchor.constraint(equalTo: weightSubmitButton.topAnchor, constant: -60),
            weightField.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            weightField.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            weightField.heightAnchor.constraint(equalToConstant: 40),
            
            weightSubmitButton.bottomAnchor.constraint(equalTo: formStack.bottomAnchor, constant: -100),
            weightSubmitButton.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            weightSubmitButton.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            weightSubmitButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupConstraintsFifthForm() {
        NSLayoutConstraint.activate([
            fifthQuestionLabel.topAnchor.constraint(equalTo: formStack.topAnchor, constant: 100),
            fifthQuestionLabel.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            fifthQuestionLabel.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            
            goalField.bottomAnchor.constraint(equalTo: goalSubmitButton.topAnchor, constant: -60),
            goalField.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            goalField.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            goalField.heightAnchor.constraint(equalToConstant: 40),
            
            goalSubmitButton.bottomAnchor.constraint(equalTo: formStack.bottomAnchor, constant: -100),
            goalSubmitButton.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            goalSubmitButton.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            goalSubmitButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupConstraintsSixthForm() {
        NSLayoutConstraint.activate([
            generatePlanInfoLabel.topAnchor.constraint(equalTo: formStack.topAnchor, constant: 100),
            generatePlanInfoLabel.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            generatePlanInfoLabel.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            
            generatePlanButton.bottomAnchor.constraint(equalTo: formStack.bottomAnchor, constant: -100),
            generatePlanButton.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 20),
            generatePlanButton.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            generatePlanButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension PlanRequestViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return heightData.count
        case 2:
            return weightData.count
        case 3:
            return goalData.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return heightData[row]
        case 2:
            return weightData[row]
        case 3:
            return goalData[row]
        default:
            return "No Data"
        }
    }
}

extension PlanRequestViewController {
    
    func waitingIndicator() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func killWaitingIndicator(waitingIndicator: UIAlertController) {
        DispatchQueue.main.async {
            waitingIndicator.dismiss(animated: true, completion: nil)
        }
    }
}
