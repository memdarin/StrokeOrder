//
//  ViewController.swift
//  StrokeOrder
//
//  Created by Henry on 05/12/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

import UIKit

/**
 {"character":"一","strokes":["M 518 382 Q 572 385 623 389 Q 758 399 900 383 Q 928 379 935 390 Q 944 405 930 419 Q 896 452 845 475 Q 829 482 798 473 Q 723 460 480 434 Q 180 409 137 408 Q 130 408 124 408 Q 108 408 106 395 Q 105 380 127 363 Q 146 348 183 334 Q 195 330 216 338 Q 232 344 306 354 Q 400 373 518 382 Z"],"medians":[[[121,393],[193,372],[417,402],[827,434],[920,401]]]}
 
 
 758 399 900 383 Q 928 379    Q     Q     Q     Q     Q     Q     Q     Q     Q     Q     Q     Q     Z"],"medians":[[[121,393],[193,372],[417,402],[827,434],[920,401]]]}
 */

class ViewController: UIViewController {
    
    @IBOutlet weak var drawView: WordView!
    private var animation: CABasicAnimation!
    private var word: Word!
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.duration = 3.0
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.delegate = self
        
        let liJson = """
{"character":"柳",
"strokes":["M 300 561 Q 313 567 329 570 Q 360 580 365 585 Q 372 592 368 601 Q 361 611 331 616 Q 315 619 301 615 L 258 599 Q 162 566 106 557 Q 72 548 98 534 Q 143 516 196 532 Q 218 539 245 545 L 300 561 Z","M 298 487 Q 299 523 300 561 L 301 615 Q 301 714 321 786 Q 336 811 306 831 Q 291 843 266 857 Q 244 873 223 859 Q 219 855 225 839 Q 256 791 257 743 Q 257 676 258 599 L 254 443 Q 251 257 238 200 Q 217 119 234 69 Q 235 63 240 54 Q 247 36 255 33 Q 261 26 268 35 Q 295 51 295 114 Q 294 154 298 461 L 298 487 Z","M 245 545 Q 197 407 50 197 Q 44 187 56 186 Q 77 186 182 321 Q 221 372 254 443 L 256.7026773132926 548.4044152184124 L 245 545 Z","M 298 461 Q 302 455 311 446 Q 354 395 364 392 Q 371 391 377 401 Q 383 411 379 435 Q 378 450 357 463 Q 305 490 298 487 L 298 461 Z","M 460 579 Q 506 613 596 691 Q 614 707 637 719 Q 656 729 646 747 Q 633 763 606 776 Q 582 788 570 784 Q 557 783 562 769 Q 566 744 493 650 Q 471 623 446 593 L 460 579 Z","M 554 416 Q 464 379 460 381 Q 453 382 454 400 Q 458 476 459 514 Q 458 542 460 566 Q 461 573 460 579 L 446 593 Q 430 605 414 611 Q 398 615 390 611 Q 381 605 393 589 Q 432 531 409 382 Q 403 361 387 336 Q 377 318 384 309 Q 391 297 415 288 Q 428 281 440 297 Q 458 330 546 384 Q 549 385 552 388 L 554 416 Z","M 552 388 Q 552 244 454 126 Q 447 120 441 112 Q 396 69 395 63 Q 394 56 404 57 Q 468 64 552 194 Q 558 207 564 219 Q 603 321 607 537 Q 610 555 611 566 Q 617 585 597 593 Q 552 615 539 612 Q 520 608 536 588 Q 558 551 554 416 L 552 388 Z","M 739 590 Q 788 606 825 612 Q 834 613 836 611 Q 846 598 847 562 Q 851 460 835 413 Q 823 385 800 385 Q 787 386 775 389 Q 750 398 768 373 Q 799 334 813 305 Q 835 287 850 307 Q 901 356 907 485 Q 907 597 921 624 Q 930 637 923 644 Q 914 653 868 666 Q 850 670 836 657 Q 815 645 731 616 L 739 590 Z","M 674 -35 Q 680 -60 686 -69 Q 692 -76 699 -74 Q 717 -62 720 -7 Q 729 77 727 159 Q 723 229 728 501 Q 731 558 739 590 L 731 616 Q 730 617 729 618 Q 698 640 682 642 Q 669 646 654 638 Q 645 631 652 620 Q 677 575 678 499 Q 678 361 672 159 Q 669 14 674 -35 Z"],
"medians":[[[99,546],[133,543],[183,551],[312,592],[357,595]],
[[234,853],[280,807],[286,773],[279,666],[275,325],[260,126],[260,46]],[[253,541],[232,451],[200,389],[144,300],[56,193]],[[301,481],[349,440],[366,402]],[[569,775],[589,752],[593,736],[461,594],[461,587]],[[397,603],[433,568],[438,487],[431,390],[437,351],[476,362],[530,389],[540,397],[543,410]],[[540,600],[575,572],[579,550],[577,399],[558,273],[529,196],[494,145],[452,98],[401,62]],
[[745,599],[749,608],[764,614],[835,633],[860,634],[877,621],[876,457],[856,380],[832,352],[768,383]],[[661,628],[693,605],[703,578],[695,-64]]]}
"""

        word = Word.init(jsonStr: liJson)!
        
        drawWord()
    }
}


extension ViewController: CAAnimationDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        drawNextIndex()
    }
    
    func drawWord() -> Void {
        let organicLayer = CAShapeLayer()
        organicLayer.fillColor = UIColor.lightGray.cgColor
        organicLayer.path = word.outline.cgPath
        organicLayer.setAffineTransform(CGAffineTransform.init(scaleX: drawView.frame.width/1024, y: -drawView.frame.height/1024).translatedBy(x: 0, y: -900))
        drawView.layer.addSublayer(organicLayer)

    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if index < word.strokes.count-1 {
            index = index + 1
            drawNextIndex()
        }
    }
    
    func drawNextIndex() -> Void {
        let stroke = word.strokes[index]考虑
        let strokeOutline = stroke.outline
        let strokeMedian = stroke.median
        
        let clipLayer = CAShapeLayer()
        clipLayer.fillColor = UIColor.lightGray.cgColor
        clipLayer.path = strokeOutline.cgPath
        
        let drawLayer = CAShapeLayer()
        drawLayer.strokeColor = UIColor.red.cgColor
        drawLayer.fillColor = UIColor.clear.cgColor
        drawLayer.path = strokeMedian.cgPath
        drawLayer.lineWidth = 128
        drawLayer.lineJoin = kCALineJoinRound
        drawLayer.lineCap = kCALineCapRound
        drawLayer.setAffineTransform(CGAffineTransform.init(scaleX: drawView.frame.width/1024, y: -drawView.frame.height/1024).translatedBy(x: 0, y: -900))
        drawLayer.add(animation, forKey: "path")
        drawLayer.mask = clipLayer
        drawView.layer.addSublayer(drawLayer)
    }
    
}
