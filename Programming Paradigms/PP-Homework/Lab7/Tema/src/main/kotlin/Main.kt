import java.io.*

fun <T: Comparable<T>> maxTimeStamp(first: T, second: T): T{
    return if (first.compareTo(second) < 0) first else second
}

fun replaceHistLog(
        histToReplace : HistoryLogRecord,
        histToReplaceWith: HistoryLogRecord,
        mapHist: MutableMap<String, HistoryLogRecord>
)
{
    val key = mapHist.filterValues { it == histToReplace }.keys.firstOrNull()
    if (key != null) {
        mapHist[key] = histToReplace
    } else {
        println("Record not found in map.")
    }
}

fun main(){
    val fileName = "history.log"
    val classLoader = ::main.javaClass.classLoader
    val filePath = File(classLoader.getResource(fileName)?.file ?: throw FileNotFoundException("File not found"))
    val fileReader = FileReader(filePath)

    val bufferReader = BufferedReader(fileReader)
    val context = bufferReader.readText()

    val histRegex = """Start-Date: (.*)\sCommandline: (.*)""".toRegex()

    val mapHist = mutableMapOf<String, HistoryLogRecord>()

    for (matchResult in histRegex.findAll(context)){
        val timestamp = matchResult.groupValues[1]
        val commandline = matchResult.groupValues[2]

        val histLogRecord = HistoryLogRecord(timestamp, commandline)
        mapHist[timestamp] = histLogRecord
    }

    val mostRecentLog = mapHist.values.reduce(){ log1, log2 ->
        maxTimeStamp(log1, log2)
    }

    println("Cel mai recent historyLog: ${mostRecentLog.timestamp}")
}