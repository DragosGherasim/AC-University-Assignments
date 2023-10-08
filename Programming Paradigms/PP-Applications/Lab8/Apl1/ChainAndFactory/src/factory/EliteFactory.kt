package factory

import chain.CEOHandler
import chain.ExecutiveHandler
import chain.Handler
import chain.ManagerHandler

class EliteFactory: AbstractFactory() {
    override fun getHandler(handler: String): Handler {
        return when (handler) {
            "CEO" -> return CEOHandler()
            "Executive" -> return ExecutiveHandler()
            "Manager" -> return ManagerHandler()
            else -> throw IllegalArgumentException("Invalid elite factory handler type.")
        }
    }
}