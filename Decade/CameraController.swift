//
//  CameraController.swift
//  Decade
//
//  Created by Nick Reichard on 6/10/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import AVFoundation

// TODO: - add the camera controller for the camera feature

//struct CameraController {
//    
//    static let shared = CameraController()
//    let captureSesstion = AVCaptureSession()
//    
//    func switchCameraInput() {
//        self.captureSesstion.beginConfiguration()
//        
//        var exisingConnection: AVCaptureDeviceInput?
//        var newInput: AVCaptureDeviceInput?
//        var newCamera: AVCaptureDevice?
//        
//        for connection in self.captureSesstion.inputs {
//            guard let input = connection as? AVCaptureDeviceInput else { return }
//            if input.device.hasMediaType(AVMediaTypeVideo) {
//                exisingConnection = input
//            }
//        }
//        self.captureSesstion.removeInput(exisingConnection)
//        
//        if let oldCamera = exisingConnection {
//            if oldCamera.device.position == .back {
//                newCamera = self.cameraWithPosition(position: .front)
//            } else {
//                newCamera = self.cameraWithPosition(position: .back)
//            }
//        }
//        
//        do {
//            newInput = try AVCaptureDeviceInput(device: newCamera)
//            self.captureSesstion.addInput(newInput)
//        } catch {
//            print("Error: Cannot Capture NewInput \(error.localizedDescription)")
//        }
//        
//        self.captureSesstion.commitConfiguration()
//    }
//}
//
//extension CameraController {
//    
//    func cameraWithPosition(position: AVCaptureDevicePosition) -> AVCaptureDevice? {
//        
//        let discovery = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .unspecified) as AVCaptureDeviceDiscoverySession
//        
//        for device in discovery.devices as [AVCaptureDevice] {
//            if device.position == position {
//                return device
//            }
//        }
//        return nil
//    }
//}
