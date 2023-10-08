import factory.FactoryProducer

fun main(args: Array<String>) {

    // se creeaza 1xFactoryProducer, 1xEliteFactory, 1xHappyWorkerFactory
    //...
    val newFactoryProd = FactoryProducer()

    val newEliteFactory = newFactoryProd.getFactory("Elite")
    val newHappyWorkerFactory = newFactoryProd.getFactory("HappyWorker")

    val newCEO = newEliteFactory.getHandler("CEO")
    val newExecutive = newEliteFactory.getHandler("Executive")
    val newManager = newEliteFactory.getHandler("Manager")

    val newHappyWorker = newHappyWorkerFactory.getHandler("HappyWorker")

    newCEO.setNext12(newExecutive, null)
    newExecutive.setNext12(newManager, newCEO)
    newManager.setNext12(newHappyWorker, newExecutive)
    newHappyWorker.setNext12(null, newManager)

    newCEO.handleRequest("4:Mesaj catre HappyWoker1, este nevoie de tine la parter !")
}