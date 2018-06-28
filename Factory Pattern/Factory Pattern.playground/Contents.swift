//: Playground - noun: a place where people can play

import UIKit
import Foundation

/* 抽象工厂模式：提供接口，创造一系列相关或者独立的对象，而不指定这些对象的具体
   抽象工厂模式将一组对象的实现细节和他们的一般使用分离开来了
客户端不需要知道从这些内部中工厂中得到的对象的具体类型，只需要使用对象的通用接口即可！
 */

// **常规抽象工厂**
//1. 定义接口（客户端需要使用的对象的通用的接口）
protocol Button {
    func printMyName()
}
protocol Border {
    func printMyBorderWidth()
}

//2. 实现抽象类
class MacButton: Button {
    func printMyName() {
        print("MacButton: I am Mac.")
    }
}
class WinButton: Button {
    func printMyName() {
        print("WinButton: I am Win.")
    }
}

class MacBorder: Border {
    func printMyBorderWidth() {
        print("MacBorder: I am 10.")
    }
}
class WinBorder: Border {
    func printMyBorderWidth() {
        print("WinBorder: I am 12.")
    }
}

// 4.实现抽象工厂（工厂需要实现的具体的创建不同产品的方法）
protocol AbstractFactory {
    func creatButton() -> Button
    func creatBorder() -> Border
}

// 3. 实现具体的工厂
class MacFactory: AbstractFactory {
    func creatButton() -> Button {
        return MacButton()
    }
    
    func creatBorder() -> Border {
        return MacBorder()
    }
}

class WinFactory: AbstractFactory {
    func creatButton() -> Button {
        return WinButton()
    }
    
    func creatBorder() -> Border {
        return WinBorder()
    }
}

// 4. 使用工厂创建不同的产品
enum Style {
    case MAC
    case WIN
}

var fac: AbstractFactory?
let style = Style.MAC
switch style {
case .MAC:
    fac = MacFactory()
case .WIN:
    fac = WinFactory()
}
let button: Button? = fac?.creatButton()
let border: Border? = fac?.creatBorder()
button?.printMyName()
border?.printMyBorderWidth()

// **Swift进阶版抽象工厂**
// 抽象工厂用来创建一系列的相关的或者相依赖的objects，这些objects的‘family’是在运行时有抽象工厂决定的。
// 这种方式将具体的工厂的实现方式也放在了产品类中
// 1.定义协议
protocol Decimal {
    func stringValue() -> String
    
    // factory
    static func make(string: String) -> Decimal
}
// 2.定义抽象类（抽象类中也包括工厂的创建方法）
struct NextStepNumber: Decimal {
    var nextStepNumber: NSNumber
    
    func stringValue() -> String {
        print("NextStepNumber: " + nextStepNumber.stringValue)
        return "NextStepNumber: " + nextStepNumber.stringValue
    }
    
    // factory
    static func make(string: String) -> Decimal {
        return NextStepNumber(nextStepNumber: NSNumber(value: (string as NSString).longLongValue))
    }
}

struct SwiftNumber: Decimal {
    var swiftInt: Int
    
    func stringValue() -> String {
        print("SwiftNumber: \(swiftInt)")
        return "SwiftNumber: \(swiftInt)"
    }
    
    // factory
    static func make(string: String) -> Decimal {
        return SwiftNumber(swiftInt: NSString(string: string).integerValue)
    }
}

// 3.Abstract factory
// 根据不同的参数生成不同的工厂
enum NumberType {
    case nextStep, swift
}

// 拿出类型的定义作为工厂的返回类型
typealias NumberFactory = (String) -> Decimal

enum NumberHelp {
    static func factory(for type: NumberType) -> NumberFactory {
        switch type {
        case .nextStep:
            return NextStepNumber.make
        case .swift:
            return SwiftNumber.make
        }
    }
}

// 4. 抽象工厂的使用
let factoryOne: NumberFactory = NumberHelp.factory(for: NumberType.nextStep)
let numberOne = factoryOne("1")
numberOne.stringValue()

let factoryTwo: NumberFactory = NumberHelp.factory(for: NumberType.swift)
let numberTwo = factoryTwo("2")
numberTwo.stringValue()


/// 工厂方法模式：定义一个创建对象的接口，但是让实现这个接口的类来决定需要实例化那个类，工厂方法将对象的实例化方法推迟到了子类中去执行
protocol Fruit {}

struct Apple: Fruit {}
struct Pear: Fruit {}
struct Chestnut: Fruit {}

protocol FactoryMethod {
    func selectFruit() -> Fruit
}

class AppleFactory: FactoryMethod {
    func selectFruit() -> Fruit {
        return Apple()
    }
}

class PearFactory: FactoryMethod {
    func selectFruit() -> Fruit {
        return Pear()
    }
}

class ChestnutFactory: FactoryMethod {
    func selectFruit() -> Fruit {
        return Chestnut()
    }
}

print(AppleFactory().selectFruit())

// **Swfit 工厂方法模式**
// 工厂模式是用来替代类的结构化初始方法，抽象对象生成的过程以便于对象的类型可以在运行时确定下来
protocol Currency {
    func symbol() -> String
}

class Euro: Currency {
    func symbol() -> String {
        print("€")
        return "€"
    }
}
class USDolar: Currency {
    func symbol() -> String {
        print("$")
        return "$"
    }
}

enum Country {
    case unitedStates, spain, uk, greece
}

// 根据不同的类型创建不同的对象
enum CurrencyFactory {
    static func currenty(for country: Country) -> Currency? {
        switch country {
        case .unitedStates:
            return USDolar()
        case .spain, .uk:
            return Euro()
        case .greece:
            return nil
        }
    }
}

CurrencyFactory.currenty(for: Country.unitedStates)?.symbol()




// ***  简单工厂 ***
protocol Bank {}

class CMBC: Bank {}
class ICBC: Bank {}
class CB: Bank {}

enum BankType{
    case CMBC
    case ICBC
    case CB
}

enum BankFactory {
    static func selecteBank(for type: BankType) -> Bank {
        switch type {
        case . CMBC:
            return CMBC()
        case .ICBC:
            return ICBC()
        case .CB:
            return CB()
        }
    }
}






