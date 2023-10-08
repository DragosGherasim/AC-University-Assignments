import kotlin.math.sqrt
import kotlin.properties.Delegates

fun Int.isPrime(): Boolean{
    if (this <= 1)
        return false

    for (i in 2 .. sqrt(this.toDouble()).toInt()){
        if (this % i == 0)
            return false
    }

    return true
}

var myPrimeIntEvent:Int by Delegates.vetoable(0){
    property, oldValue, newValue -> println("${property.name} $oldValue -> $newValue")

    newValue.isPrime()
}

fun main(){
    myPrimeIntEvent = 3
    myPrimeIntEvent = 6

    println("myPrimeIntEvent : $myPrimeIntEvent")
}