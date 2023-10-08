package chain

class CEOHandler(var next1: Handler? = null, var next2: Handler? = null): Handler {
    override fun setNext12(next1: Handler?, next2: Handler?) {
        this.next1 = next1
        this.next2 = next2
    }

    override fun handleRequest(messageToBeProcessed: String) {
        val splitMessage = messageToBeProcessed.split(":")

        if (splitMessage[0] == "1") {
            println("Sunt CEO si prelucrez mesajul" + splitMessage[1])
        }
        else{
            println("CEO : INVALID PRIORITY")
            next1!!.handleRequest(messageToBeProcessed)
        }
    }
}