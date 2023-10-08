package factory

import java.lang.IllegalArgumentException

class FactoryProducer {
    fun getFactory(choice: String): AbstractFactory {
        return when (choice) {
            "Elite" -> EliteFactory()
            "HappyWorker" -> HappyWorkerFactory()
            else -> throw IllegalArgumentException("Invalid factory choice !")
        }
    }
}