//
//  OnboardingViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 23/04/22.
//

import UIKit
import Sevruk_PageControl

class OnboardingViewController: SJSViewController, Storyboarded {
    
    weak var coordinator: LoginCoordinator?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: OnboardingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        }
    }
    
    @IBOutlet weak var pageControl: PageControl!
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var loginButtonView: UIView!
    @IBOutlet weak var arrowButtonView: UIView!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                loginButtonView.isHidden = false
            }
            else {
                loginButtonView.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        slides = [
            OnboardingSlide(title: "Selamat Datang di SJS+ Aplikasi Karyawan",
                            description: "Hai SJSquad, SJS+ Karyawan adalah aplikasi yang bertujuan memudahkan karyawan melihat, memeriksa dan memperbaharui administrasi secara otomatis dan mandiri sekaligus sarana melakukan interaksi antara karyawan dan perusahaan",
                            image: UIImage(named: "onboarding_1")!
                           ),
            OnboardingSlide(title: "Kelola urusan administrasi kepegawaianmu dengan mudah",
                            description: "Hi SJSquad, yuk.. kelola urusan administrasi personalia kamu seperti pembaharuan data diri, absensi online, pengajuan cuti, permintaan surat, pembukaan rekening baru, cek kontrak kerja hingga cek slip gaji dengan mudah hanya dalam satu genggaman.",
                            image: UIImage(named: "onboarding_2")!
                           ),
            OnboardingSlide(title: "Dapatkan notifikasi untuk semua proses administrasi yang kamu ajukan",
                            description: "Hi SJSquad, fitur notifikasi SJS+ akan menginformasikan kamu perihal semua aktifitas yang dilakukan melalui aplikasi SJS+",
                            image: UIImage(named: "onboarding_3")!
                           )
        ]
        
        arrowButtonView.layer.cornerRadius = arrowButtonView.frame.width / 2
        
        loginButtonView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        configurePageControl()
    }
    
    func configurePageControl() {
        pageControl.numberOfPages = slides.count
        pageControl.spacing = 12
        pageControl.indicatorDiameter = 8
        pageControl.currentIndicatorDiameter = 12
        pageControl.indicatorTintColor = .lightGray
        pageControl.currentIndicatorTintColor = .appColor(.sjsOrange)
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        coordinator?.goToSignUp()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if currentPage != slides.count - 1 {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        coordinator?.goToSignUp()
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
    
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slides[indexPath.row])
        
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
