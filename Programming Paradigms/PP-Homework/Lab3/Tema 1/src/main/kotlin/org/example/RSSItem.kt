package org.example

class RSSItem(val title: String, val description: String, val link: String, val pubData: String) {
    fun PrintTitleLink(){
        println("Title : $title\nLink : $link\n")
    }
}