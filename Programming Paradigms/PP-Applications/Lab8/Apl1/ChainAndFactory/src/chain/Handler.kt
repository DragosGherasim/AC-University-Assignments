package chain

interface Handler {
    fun setNext12(next1: Handler? = null, next2: Handler? = null)
    fun handleRequest(messageToBeProcessed: String)
}