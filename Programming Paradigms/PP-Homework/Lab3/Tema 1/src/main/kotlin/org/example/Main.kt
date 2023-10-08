package org.example

fun main(args: Array<String>) {
    val url = "http://rss.cnn.com/rss/edition.rss"

    val rssReader = RSSFeedReader(url)

    rssReader.printRSSList()
}

