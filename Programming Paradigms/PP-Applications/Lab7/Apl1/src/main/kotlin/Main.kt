import java.io.*

fun main() {
    val fileName = "syslog"
    val classLoader = ::main.javaClass.classLoader
    val filePath = File(classLoader.getResource(fileName)?.file ?: throw FileNotFoundException("File not found"))
    val fileReader = FileReader(filePath)

    val bufferedReader = BufferedReader(fileReader)
    var line = bufferedReader.readLine()
    val reversedLines = mutableListOf<String>()

    while (line != null) {
        reversedLines.add(line)
        line = bufferedReader.readLine()
    }

    reversedLines.reverse()

    val regexSyslog = """^(\w+\s+\d\s\d+:\d+:\d+)\s(\w+)\s(\S+)\[(\d+)\]:\s(.*)$""".toRegex()
    val regexTime = """^\w+\s+\d\s(\d+):(\d+):\d+$""".toRegex()

    val listSysLogRecord = mutableListOf<SyslogRecord>()

    for (line : String in reversedLines) {
        val h = 16
        val m = 45

        val matchResultsSysLog = regexSyslog.matchEntire(line)

        val (timestamp, hostName, applicationName, pid, logEntry) = matchResultsSysLog!!.destructured

        val matchResultsTimeStamp = regexTime.matchEntire(timestamp)

        val (hl, ml) = matchResultsTimeStamp!!.destructured

       if ((60*h + m) - (60*Integer.parseInt(hl) + Integer.parseInt(ml)) > 30){
           break
       }

        val syslogRecord = SyslogRecord(timestamp, hostName, applicationName, pid, logEntry)

        listSysLogRecord.add(syslogRecord)
    }

    val dictSysLog = linkedMapOf<String, MutableList<SyslogRecord>>()

    for(log: SyslogRecord in listSysLogRecord){
        dictSysLog.getOrPut(log.applicationName) { mutableListOf<SyslogRecord>() }.add(log)
        // daca cheia exista, metoda va returna lista asociata cu cheia, si apoi va adauga inregistrarea (log)
        // daca cheia nu exista, va crea o lista goala de inregistrari si va adauga inregistrarea (log)
    }

    val appPID = linkedMapOf(
            "systemd" to "1",
            "pipewire-media-session" to "2139",
            "lightdm" to "2183",
            "dbus-daemon" to "586",
            "NetworkManager" to "587",
            "anacron" to "2944",
            "CRON" to "2922"
    )

    dictSysLog.forEach{(applicationName, logs) ->
        val sortedLogs = logs.sortedBy{it.logEntry.lowercase()}
        dictSysLog[applicationName] = sortedLogs.toMutableList()
    }

    dictSysLog.forEach{(applicationName, logs) ->
        val filteredLogs = logs.filter { it.pid.compareTo(appPID[it.applicationName]!!) == 0}
        println("Inregistrarile care specifica un PID pentru aplicatia tinta $applicationName :")
        filteredLogs.forEach{
            println("PID ${it.pid} : ${it.logEntry}")
        }
    }

    bufferedReader.close()
}