//
//  ViewController.swift
//  AR Solar System
//
//  Created by Justin Vallely on 6/26/18.
//  Copyright © 2018 Pajama Donkey. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet var sceneView: ARSCNView!

    let configuration = ARWorldTrackingConfiguration()

    let mercuryParent = SCNNode()
    let venusParent = SCNNode()
    let earthParent = SCNNode()
    let marsParent = SCNNode()
    let jupiterParent = SCNNode()
    let saturnParent = SCNNode()
    let uranusParent = SCNNode()
    let neptuneParent = SCNNode()
    let moonParent = SCNNode()

    var sunNode = SCNNode()
    var mercuryNode = SCNNode()
    var venusNode = SCNNode()
    var earthNode = SCNNode()
    var marsNode = SCNNode()
    var jupiterNode = SCNNode()
    var saturnNode = SCNNode()
    var uranusNode = SCNNode()
    var neptuneNode = SCNNode()
    var moonNode = SCNNode()

    var allParents = [SCNNode]()
    var allPlanets = [SCNNode]()

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.autoenablesDefaultLighting = true
        sceneView.session.run(configuration)

        speedSlider.setValue(UserDefaults.standard.float(forKey: "savedSliderSpeedValue"), animated: false)

        allParents.append(mercuryParent)
        allParents.append(venusParent)
        allParents.append(earthParent)
        allParents.append(marsParent)
        allParents.append(jupiterParent)
        allParents.append(saturnParent)
        allParents.append(uranusParent)
        allParents.append(neptuneParent)

        allPlanets.append(mercuryNode)
        allPlanets.append(venusNode)
        allPlanets.append(earthNode)
        allPlanets.append(marsNode)
        allPlanets.append(jupiterNode)
        allPlanets.append(saturnNode)
        allPlanets.append(uranusNode)
        allPlanets.append(neptuneNode)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupPlanets()
        setupPlanetParents()
        setupPlanetRotationAnimations()
        setupOrbitAnimations()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()

        UserDefaults.standard.set(speedSlider.value, forKey: "savedSliderSpeedValue")
    }

    private func setupPlanets() {
        sunNode = planet(radius: 0.5, diffuse: #imageLiteral(resourceName: "sun"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, 0))
        mercuryNode = planet(radius: 0.1, diffuse: #imageLiteral(resourceName: "mercury"), specular: nil, emission: nil, normal: nil, position: SCNVector3(sunNode.position.x + 1, 0, 0))
        venusNode = planet(radius: 0.2, diffuse: #imageLiteral(resourceName: "venus"), specular: nil, emission: #imageLiteral(resourceName: "venus atmosphere"), normal: nil, position: SCNVector3(mercuryNode.position.x + 0.5, 0, 0))
        earthNode = planet(radius: 0.2, diffuse: #imageLiteral(resourceName: "earth daymap"), specular: #imageLiteral(resourceName: "earth specular"), emission: #imageLiteral(resourceName: "earth clouds"), normal: #imageLiteral(resourceName: "earth normal"), position: SCNVector3(venusNode.position.x + 0.6, 0, 0))
        marsNode = planet(radius: 0.15, diffuse: #imageLiteral(resourceName: "mars"), specular: nil, emission: nil, normal: nil, position: SCNVector3(earthNode.position.x + 0.6, 0, 0))
        jupiterNode = planet(radius: 0.4, diffuse: #imageLiteral(resourceName: "jupiter"), specular: nil, emission: nil, normal: nil, position: SCNVector3(marsNode.position.x + 0.7, 0, 0))
        saturnNode = planet(radius: 0.4, diffuse: #imageLiteral(resourceName: "saturn"), specular: nil, emission: nil, normal: nil, position: SCNVector3(jupiterNode.position.x + 1, 0, 0))
        uranusNode = planet(radius: 0.3, diffuse: #imageLiteral(resourceName: "uranus"), specular: nil, emission: nil, normal: nil, position: SCNVector3(saturnNode.position.x + 1, 0, 0))
        neptuneNode = planet(radius: 0.3, diffuse: #imageLiteral(resourceName: "nepture"), specular: nil, emission: nil, normal: nil, position: SCNVector3(uranusNode.position.x + 1, 0, 0))
        moonNode = planet(radius: 0.05, diffuse: #imageLiteral(resourceName: "moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.3, 0, 0))
    }

    private func setupPlanetParents() {
        mercuryParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(mercuryParent)
        mercuryParent.addChildNode(mercuryNode)

        venusParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(venusParent)
        venusParent.addChildNode(venusNode)

        earthParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(earthParent)
        earthParent.addChildNode(earthNode)

        marsParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(marsParent)
        marsParent.addChildNode(marsNode)

        jupiterParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(jupiterParent)
        jupiterParent.addChildNode(jupiterNode)

        saturnParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(saturnParent)
        saturnParent.addChildNode(saturnNode)

        uranusParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(uranusParent)
        uranusParent.addChildNode(uranusNode)

        neptuneParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(neptuneParent)
        neptuneParent.addChildNode(neptuneNode)

        moonParent.position = SCNVector3(0, 0, 0)
        earthNode.addChildNode(moonParent)
        moonParent.addChildNode(moonNode)

        sceneView.scene.rootNode.addChildNode(sunNode)
        sceneView.scene.rootNode.addChildNode(mercuryParent)
        sceneView.scene.rootNode.addChildNode(venusParent)
        sceneView.scene.rootNode.addChildNode(earthParent)
        sceneView.scene.rootNode.addChildNode(marsParent)
        sceneView.scene.rootNode.addChildNode(jupiterParent)
        sceneView.scene.rootNode.addChildNode(saturnParent)
        sceneView.scene.rootNode.addChildNode(uranusParent)
        sceneView.scene.rootNode.addChildNode(neptuneParent)
    }

    private func setupPlanetRotationAnimations() {
        sunNode.runAction(rotation(time: 8))
        mercuryNode.runAction(rotation(time: 10))
        venusNode.runAction(rotation(time: 9))
        earthNode.runAction(rotation(time: 8))
        moonNode.runAction(rotation(time: 5))
        marsNode.runAction(rotation(time: 8))
        jupiterNode.runAction(rotation(time: 10))
        saturnNode.runAction(rotation(time: 5))
        uranusNode.runAction(rotation(time: 6))
        neptuneNode.runAction(rotation(time: 7))
    }

    private func setupOrbitAnimations() {
        allParents.forEach({$0.removeAllActions()})
        guard speedSlider.value > 0 else { return }
        mercuryParent.runAction(rotation(time: TimeInterval(10 / speedSlider.value)))
        venusParent.runAction(rotation(time: TimeInterval(6 / speedSlider.value)))
        earthParent.runAction(rotation(time: TimeInterval(12 / speedSlider.value)))
        marsParent.runAction(rotation(time: TimeInterval(11 / speedSlider.value)))
        jupiterParent.runAction(rotation(time: TimeInterval(9 / speedSlider.value)))
        saturnParent.runAction(rotation(time: TimeInterval(7 / speedSlider.value)))
        uranusParent.runAction(rotation(time: TimeInterval(8 / speedSlider.value)))
        neptuneParent.runAction(rotation(time: TimeInterval(4 / speedSlider.value)))
    }

    private func rotation(time: TimeInterval) -> SCNAction {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverAction = SCNAction.repeatForever(action)
        return foreverAction
    }

    private func planet(radius: CGFloat, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: SCNSphere(radius: radius))
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }

    @IBAction func speedSliderValueDidChange(_ sender: Any) {
        setupOrbitAnimations()
    }
    
}

extension Int {
    var degreesToRadians: Double {
        return Double(self) * .pi/180
    }
}
