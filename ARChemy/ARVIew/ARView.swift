//
//  ViewController.swift
//  ARKit_1
//
//  Created by Vincent Alexander Christian on 24/10/20.
//

import UIKit
import SceneKit
import ARKit

class ARView: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var symbol = ""
    var elementCount = InitViewController.arrayOfElements.count
    
    var nodeArr: [SCNNode] = []
    
    var helperArr: [SCNNode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        configureAR()
        
        for idx in 0..<nodeArr.count {
            configureChild(index: idx)
        }
        
        for node in nodeArr {
            sceneView.scene.rootNode.addChildNode(node)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @IBAction func backToHome(_ sender: Any) {
        InitViewController.arrayOfElements.removeAll()
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitTab") as! TabBarViewController
        sb.idx = 1
        sb.modalPresentationStyle = .overFullScreen
        present(sb, animated: true, completion: nil)
    }
    
    @IBAction func addElement(_ sender: Any) {
        if elementCount == 5 {
            makeAlert(title: "Gagal", desc: "Maksimal 5 Elemen")
        }
        else {
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ARMode")
            sb.modalPresentationStyle = .overFullScreen
            present(sb, animated: true, completion: nil)
        }
    }
    
    @IBAction func toDesc(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ElementDesc") as! DescriptionViewController
        present(sb, animated: true, completion: nil)
    }
}

extension ARView {
    @objc func handleTap(_ gestureRecognize: UITapGestureRecognizer) {
        let location = gestureRecognize.location(in: sceneView)
        let hitResults = sceneView.hitTest(location, options: [:])
        
        if hitResults.count > 0 {
            let tappedPiece = hitResults[0].node
            
            for helper in helperArr {
                if helper.parent == tappedPiece {
                    helper.isHidden.toggle()
                    break
                }
            }
        }
    }
    
    func configureAR() {
        if elementCount == 1 {
            symbol = InitViewController.arrayOfElements[elementCount-1].symbol
            addSphere2(x: 0, y: 0, z: -1.5, symbol: symbol, color: UIColor.orange)
        }
        else if elementCount == 2 {
            symbol = InitViewController.arrayOfElements[0].symbol
            addSphere2(x: -0.25, y: 0, z: -1.5, symbol: symbol, color: UIColor.orange)
            symbol = InitViewController.arrayOfElements[1].symbol
            addSphere2(x: 0.25, y: 0, z: -1.5, symbol: symbol, color: UIColor.blue)
        }
        else if elementCount == 3 {
            symbol = InitViewController.arrayOfElements[0].symbol
            addSphere2(x: 0, y: 0, z: -1.5, symbol: symbol, color: UIColor.orange)
            symbol = InitViewController.arrayOfElements[1].symbol
            addSphere2(x: 0.25, y: -0.25, z: -1.5, symbol: symbol, color: UIColor.blue)
            symbol = InitViewController.arrayOfElements[2].symbol
            addSphere2(x: -0.25, y: -0.25, z: -1.5, symbol: symbol, color: UIColor.red)
        }
        else if elementCount == 4 {
            symbol = InitViewController.arrayOfElements[0].symbol
            addSphere2(x: 0, y: 0, z: -1.5, symbol: symbol, color: UIColor.orange)
            symbol = InitViewController.arrayOfElements[1].symbol
            addSphere2(x: 0.25, y: -0.25, z: -1.5, symbol: symbol, color: UIColor.blue)
            symbol = InitViewController.arrayOfElements[2].symbol
            addSphere2(x: -0.25, y: -0.25, z: -1.5, symbol: symbol, color: UIColor.red)
            symbol = InitViewController.arrayOfElements[3].symbol
            addSphere2(x: -0.25, y: 0.25, z: -1.5, symbol: symbol, color: UIColor.yellow)
        }
        else if elementCount == 5 {
            symbol = InitViewController.arrayOfElements[0].symbol
            addSphere2(x: 0, y: 0, z: -1.5, symbol: symbol, color: UIColor.orange)
            symbol = InitViewController.arrayOfElements[1].symbol
            addSphere2(x: 0.25, y: -0.25, z: -1.5, symbol: symbol, color: UIColor.blue)
            symbol = InitViewController.arrayOfElements[2].symbol
            addSphere2(x: -0.25, y: -0.25, z:-1.5, symbol: symbol, color: UIColor.red)
            symbol = InitViewController.arrayOfElements[3].symbol
            addSphere2(x: -0.25, y: 0.25, z: -1.5, symbol: symbol, color: UIColor.yellow)
            symbol = InitViewController.arrayOfElements[4].symbol
            addSphere2(x: 0.25, y: 0.25, z: -1.5, symbol: symbol, color: UIColor.green)
        }
    }
    
    func addSphere2(x: CGFloat, y: CGFloat, z: CGFloat, symbol: String, color: UIColor) {
        let sphere = SCNSphere(radius: 0.1)
        sphere.firstMaterial?.diffuse.contents = childView(text: symbol, bgColor: color, textColor: .white)
        
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(2 * Double.pi), z: 0, duration: 7)
        let repAction = SCNAction.repeatForever(action)
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x, y, z)
        sphereNode.runAction(repAction)
        
        nodeArr.append(sphereNode)
    }
    
    func configureChild(index: Int) {
        var initX: CGFloat = 0
        var initZ: CGFloat = 0
        
        let helperNode = SCNNode()
        helperNode.position = SCNVector3(0,0,0)
        helperArr.append(helperNode)
        
        let angle: CGFloat = 360 / CGFloat(InitViewController.arrayOfElements[index].electrons)
        var initAngle = angle
        
        for _ in 0..<InitViewController.arrayOfElements[index].electrons {
            let electron = SCNSphere(radius: 0.02)
            electron.firstMaterial?.diffuse.contents = childView(text: "-", bgColor: .lightGray, textColor: .black)
            let electronNode = SCNNode(geometry: electron)
            
            
            initX = 0.3 * cos(initAngle)
            initZ = 0.3 * sin(initAngle)
            
            electronNode.position = SCNVector3(initX, 0, initZ)
            helperNode.addChildNode(electronNode)
            
            initAngle += angle
        }
        
        helperNode.isHidden = true
        
        nodeArr[index].addChildNode(helperNode)
    }
    
    func childView(text: String, bgColor: UIColor, textColor: UIColor) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        view.backgroundColor = bgColor
        let label = UILabel(frame: CGRect(x: 0, y: 35, width: 200, height: 30))
        label.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(label)
        label.textAlignment = .center
        label.text = text
        label.font = .systemFont(ofSize: 80)
        label.textColor = textColor
        
        return view
    }
    
    func createCylinder() {
        let cylinder = SCNCylinder(radius: 0.15, height: 1)
        let cylinderNode = SCNNode(geometry: cylinder)
        cylinderNode.position = SCNVector3(0, 1, -2.5)
        
        sceneView.scene.rootNode.addChildNode(cylinderNode)
    }
}
