package org.example

import nl.siegmann.epublib.domain.Book
import nl.siegmann.epublib.epub.EpubReader
import org.jsoup.Jsoup
import org.jsoup.nodes.Element
import java.io.File
import java.lang.StringBuilder


class Dictionary(var dict: MutableMap<String, String> = LinkedHashMap()){
    init {
        val file = File("src/main/resources/dictionary.txt")
        val textString = file.readText(Charsets.UTF_8)

        val regex = Regex(""",\s*""") // avoiding escaping characters
        val keyValuePairs = regex.split(textString)

        for (keyValue in keyValuePairs){
            val (key, value) = keyValue.split(" : ")
            dict.put(key, value)
        }
    }

    constructor(ebookPath: String) : this() {
        val epubReader = EpubReader()
        val file = File(ebookPath)
        val book: Book = epubReader.readEpub(file.inputStream())
        val textString = StringBuilder() // efficiently perform multiple string manipulation operation

        for (resource in book.contents){
            val html = String(resource.data) // converts the HTML file in a string
            val doc = Jsoup.parse(html) // creates a Document object that can be used to search for specific elements within the HTML
            val elements = doc.select("p.calibre1") // selects all the paragraph elements('<p>') with a class attribute equal to "calibre1"
            for (element: Element in elements) {
                textString.append(element.text())
            }
        }

        val regex = Regex(""",\s*""") // avoiding escaping characters
        val keyValuePairs = regex.split(textString)

        for (keyValue in keyValuePairs){
            val (key, value) = keyValue.split(" : ")
            dict.put(key, value)
        }
    }

    fun AddWord(englishWord: String, romanianWord: String){
        dict.put(englishWord, romanianWord)
    }

    fun Translate(story : String){
        var translatedText = ""

        val wordsSplited = story.split(" ")
        val listOfWords = mutableListOf<String>()

        for(word in wordsSplited){
            listOfWords.add(word.trim('.', ','))
        }

        for (word in listOfWords){
            if(dict.contains(word)){
                translatedText += "${dict[word]} "
            }
        }

        val file = File("src/main/resources/translated_text.txt")
        file.writeText(translatedText)
    }
}

