package org.example

import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.jsoup.nodes.Element
import org.jsoup.select.Elements

class RSSFeedReader(val itemsList: MutableList<RSSItem> = ArrayList()){
    constructor(path: String) : this() {
        val document: Document = Jsoup.connect(path).get() // connects to a URL and retrieve the HTML document( object tha can be used to select specific HTML elements)

        val items: Elements = document.select("item") // finds all the HTML elements(<title>, <link>) in the document that match a given CSS selector (<item>)

        for(item: Element in items){
            val title: String = item.select("title").text() // item retrieves the text content
            val description: String = item.select("description").text()
            val link: String = item.select("link").text()
            val pubDate: String = item.select("pubDate").text()

            val rssItem = RSSItem(title, description, link, pubDate)
            itemsList.add(rssItem)
        }
    }

    fun printRSSList(){
        for (item: RSSItem in itemsList){
            item.PrintTitleLink()
        }
    }
}