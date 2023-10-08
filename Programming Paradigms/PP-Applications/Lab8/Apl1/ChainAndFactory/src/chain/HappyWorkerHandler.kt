package chain

class HappyWorkerHandler(var next1: Handler? = null, var next2: Handler? = null): Handler {
    override fun setNext12(next1: Handler?, next2: Handler?) {
        this.next1 = next1
        this.next2 = next2
    }

    override fun handleRequest(messageToBeProcessed: String) {
        val splitMessage = messageToBeProcessed.split(":")

        if (splitMessage[0] == "4") {
            println("Sunt HappyWorker si prelucrez mesajul: " + splitMessage[1])
            //next2!!.handleRequest("3:Sunt HappyWorker, am gestionat mesajul cu succes !")
        }
        else{
            println("HappyWorker : INVALID PRIORITY")
        }
    }
}