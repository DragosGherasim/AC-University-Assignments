import java.text.SimpleDateFormat
import java.util.Date

fun String.convertToDate(formatter : SimpleDateFormat): Date?{
    return try{
        formatter.parse(this)
    } catch (e: Exception) {
        null
    }
}

fun main(){
    val dateString = "2023-06-27"
    val formatter = SimpleDateFormat("yyyy-MM-dd")
    val date = dateString.convertToDate(formatter)

    if (date != null) {
        println(date)
    } else {
        println("Invalid date format")
    }
}