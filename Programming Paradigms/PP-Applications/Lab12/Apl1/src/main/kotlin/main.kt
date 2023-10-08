import kotlin.math.sqrt

fun Int.isPrime(): Boolean{
    if (this <= 1){
        return false
    }

    for (i in 2..sqrt(this.toDouble()).toInt()){
        if (this % i == 0){
            return false
        }
    }

    return true
}

fun main(){
    val num = 13

    println(num.isPrime())
}