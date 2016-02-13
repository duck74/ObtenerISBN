//
//  ViewController.swift
//  BuscarISBN
//
//  Created by Koss on 12/02/16.
//  Copyright © 2016 mine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var recISBN:String?
    var resultado:String = ""

    @IBOutlet weak var verISBN: UILabel!
    
    @IBOutlet weak var verResultado: UITextView!
    
    @IBOutlet weak var insertarISBN: UIButton!
    
    @IBAction func entrarISBNView(segue: UIStoryboardSegue) {
        
        if let isbnViewController = segue.sourceViewController as? EntrarISBN {
           let isbn = NSMutableString(string: isbnViewController.ISBNbuscar!)
            let isbnString = (crearISBNString(isbn))
            verISBN.text = isbnString
            //verISBN.text = isbnViewController.ISBNbuscar
            recISBN = isbnViewController.ISBNbuscar
            verResultado.text = String(recibirJSON())
        }
    }
    
    
    func recibirJSON() -> NSString{
        let isbn = NSMutableString(string: recISBN!)
        let isbnString = (crearISBNString(isbn))
        //cuando puede test, usa este variable
        //let x = "998-84-376-0494-7"
        var test:NSString?
        
        let urlPath:String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbnString  //sustituir con x
        guard let endpoint = NSURL(string: urlPath as String) else { print("Error creating endpoint");return "error"}
        
        let datos:NSData? = NSData(contentsOfURL: endpoint)
            if let datos = datos {
                test = NSString(data: datos, encoding: NSUTF8StringEncoding)!
                //return test
            }
            else {
                test = "error"
            }
        if  (test!.length <= 2){
            return "No encontró un libro con este ISBN"
        }
        else if test == "error" {
            return "Hay un problema con los datos o el coneccion."
        }
        else {
            return test!
        }
        //return String(jsonISBN)
        //var data:NSData?
        /*
        let isbnString = (crearISBNString(isbn))
        print(isbnString)
        let x = "978-84-376-0494-7"
        let urlPath:String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + x
        guard let endpoint = NSURL(string: urlPath as String) else { print("Error creating endpoint");return  ""}
        let request = NSMutableURLRequest(URL:endpoint)
        print(request)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                guard let dat = data else { throw JSONError.NoData }
                //create dictionary from json
                guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSDictionary else { throw JSONError.ConversionFailed }
                
                let jsonString = NSString(data: dat, encoding: NSUTF8StringEncoding)! as String

                //print(jsonString)
                //resultado = NSString(data: dat, encoding: NSUTF8StringEncoding)! as String
                //print(resultado!)
                self.resultado = jsonString
            print(self.resultado)
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch {
                print(error)
            }
            }.resume()
        //let json = NSJSONSerialization.dataWithJSONObject(dat, options: NSJSONWritingOptions.PrettyPrinted, error: &error)
        return resultado*/
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.sharedApplication().canOpenURL(url)
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //yourTextField.becomeFirstResponder()
        //insertarISBN.layer.cornerRadius = 3
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    func crearISBNString(isbn: NSMutableString) -> String{
        isbn.insertString("-", atIndex: 3)
        isbn.insertString("-", atIndex: 6)
        isbn.insertString("-", atIndex: 10)
        isbn.insertString("-", atIndex: 15)
        //print(isbn)
        return String(isbn)
    }


}

