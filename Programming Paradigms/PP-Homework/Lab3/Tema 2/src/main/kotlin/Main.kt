fun main(args: Array<String>){
    val ebook = EbookProcessing("src/main/resources/ebook.txt")

    //println(ebook.removeSpaceDuplicates())

    //println(ebook.removeMultipleNewLines())

    println(ebook.removePageNumbers())
}