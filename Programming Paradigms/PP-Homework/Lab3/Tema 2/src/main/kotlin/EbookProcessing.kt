import java.io.File

class EbookProcessing(path : String) {
    val stringFormat: String

    init{
        val file = File(path)
        stringFormat = file.readText()
    }

    fun printText(){
        println(stringFormat)
    }

    fun removeSpaceDuplicates(): String{
        var newString = stringFormat

        newString = newString.replace(Regex(" {2,}"), " ")

        return newString
    }

    fun removeMultipleNewLines(): String{
        var newString = stringFormat

        newString = newString.replace(Regex("[\\n\\r]{2,}"), "\n\r")

        return newString
    }

    fun removePageNumbers(): String{
        var newString = stringFormat

        newString = newString.replace(Regex("(?:_ +\\d+)"), "_")

        return newString
    }
}