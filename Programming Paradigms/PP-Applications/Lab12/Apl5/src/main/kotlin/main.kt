fun main(){
    print("Introdu un numar : ")

    val inputNum = readln().toIntOrNull() ?: return

    val list = listOf(1, 2, 3)

    println(list.flatMap { element -> List(inputNum) { element } })
}