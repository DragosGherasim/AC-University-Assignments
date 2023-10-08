class HistoryLogRecord (val timestamp : String, val commandLine: String) : Comparable<HistoryLogRecord>{
    override fun compareTo(other: HistoryLogRecord): Int {
        return timestamp.compareTo(timestamp)
    }
}