import UIKit


/*
 Factory Method
 Фабричный метод — это порождающий паттерн проектирования, который решает проблему создания различных продуктов, без указания конкретных классов продуктов.

 Фабричный шаблон используется для замены конструкторов классов, абстрагируя процесс создания объекта, чтобы тип создаваемого экземпляра объекта можно было определить во время выполнения.

 Применимость: Паттерн можно часто встретить в проекте, где требуется гибкость при создании продуктов.
 */
protocol CurrencyDescribing
{
  var symbol: String { get }
  var code: String { get }
}


class Euro: CurrencyDescribing
{
  var symbol: String
  {
    return "💶"
  }

  var code: String
  {
    return "EUR"
  }
}

class USADollar: CurrencyDescribing
{
  var symbol: String
  {
    return "💵"
  }

  var code: String
  {
    return "USD"
  }
}

enum Country
{
  case USA
  case Spain
  case UK
}

enum CurrencyFactory
{
  static func currency(coutry: Country) -> CurrencyDescribing?
  {
    switch coutry {
    case .Spain:
      return Euro()
    case .USA:
      return USADollar()
    default:
      return nil
    }
  }
}


let message = "кода валюты нет"

CurrencyFactory.currency(coutry: .USA)!.symbol
CurrencyFactory.currency(coutry: .UK)?.code ?? message
CurrencyFactory.currency(coutry: .Spain)?.symbol ?? message












/*
 !!observer
 Шаблон наблюдателя используется для того, чтобы объект мог публиковать изменения своего состояния. Другие объекты подписываются на немедленное уведомление о любых изменениях.

 Наблюдатель — это поведенческий паттерн проектирования, который создаёт механизм подписки, позволяющий одним объектам следить и реагировать на события, происходящие в других объектах.
 */

protocol PropertyObserver: class
{
  func willChange(propertyName: String, newPropertyValue: Any?)
  func didChange(propertyName: String, oldPropertyValue: Any?)
}

class TestChambers
{
  weak var observer: PropertyObserver?

  private let testChamberNumberName = "testChamberNumber"

  var testChamberNumber: Int = 0 {
    willSet(newValue){
      observer?.willChange(propertyName: testChamberNumberName, newPropertyValue: newValue)
    }

    didSet{
      observer?.didChange(propertyName: testChamberNumberName, oldPropertyValue: oldValue)
    }
  }

}


class Observer: PropertyObserver
{
  func willChange(propertyName: String, newPropertyValue: Any?) {
    if newPropertyValue as! Int == 1 {
      print("Хорошо. Смотри. Мы оба наговорили много такого, о чем ты пожалеешь.")
    }

  }

  func didChange(propertyName: String, oldPropertyValue: Any?) {
    if oldPropertyValue as! Int == 0 {
      print("Извините за беспорядок. Я действительно отпустил это место с тех пор, как ты убил меня.")
    }
  }


}


var observerInstance = Observer() // экземпляр наблюдателя
var testChambers = TestChambers()
testChambers.observer = observerInstance
testChambers.testChamberNumber += 1



/*
 !!Template Method

 Шаблонный метод — это поведенческий паттерн проектирования, который определяет скелет алгоритма, перекладывая ответственность за некоторые его шаги на подклассы. Паттерн позволяет подклассам переопределять шаги алгоритма, не меняя его общей структуры.

 Шаблон шаблонного метода определяет этапы алгоритма и позволяет переопределить один или несколько из этих шагов. Таким образом, шаблонный метод защищает алгоритм, порядок выполнения и предоставляет абстрактные методы, которые могут быть реализованы конкретными типами.
 */


protocol Garden{
  func prepareSoli()
  func plantSeeds()
  func waterPlants()
  func prepareGarden()
}

extension Garden {
  func prepareGarden(){
    prepareSoli()
    plantSeeds()
    waterPlants()
  }
}

var apple = UIView()

class RoseGarden: Garden
{

  func prepare(){
    prepareGarden()
  }

  func prepareSoli() {
    print("подготовьте почву для розария")
  }

  func plantSeeds() {
    print ("семена растений для розария")

  }
  func waterPlants() {
    print("поливайте розовый сад")
  }

}


let roseGarden = RoseGarden()
roseGarden.prepare()


