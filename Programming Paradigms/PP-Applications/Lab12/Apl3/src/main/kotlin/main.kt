fun main(){
    val simpleMap = mapOf(
        1 to "abc",
        2 to "def",
        3 to "ghi"
    )

    val reversedMap = simpleMap.map { (key, value) -> value to key }.toMap()

    reversedMap.forEach(::println)
}