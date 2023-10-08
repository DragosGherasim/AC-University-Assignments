fun main(){
    val str = readln()

    println(str.asSequence().groupBy { it }
        .map { (ch, num) -> if (num.size > 1) "$ch${num.size}" else ch.toString()}
        .joinToString(""))
}