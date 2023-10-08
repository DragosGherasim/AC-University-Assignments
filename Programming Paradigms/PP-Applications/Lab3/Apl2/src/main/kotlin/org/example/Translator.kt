package org.example

fun main(args : Array<String>){
    /*val dictionar = Dictionary()

    var poveste = "Once upon a time there was an old woman who loved baking gingerbread. She would bake gingerbread cookies," +
            " cakes, houses and gingerbread people, all decorated with chocolate and peppermint, caramel candies and colored ingredients."

    poveste += " She was in love with a forestman."

    dictionar.AddWord("in", "")
    dictionar.AddWord("love", "indragostita")
    dictionar.AddWord("with", "de")
    dictionar.AddWord("forestman", "padurar")

    dictionar.Translate(poveste)*/

    val dictionarEbook = Dictionary("src/main/resources/dictionary.epub")

    var poveste = "Once upon a time there was an old woman who loved baking gingerbread. She would bake gingerbread cookies," +
            " cakes, houses and gingerbread people, all decorated with chocolate and peppermint, caramel candies and colored ingredients."

    dictionarEbook.Translate(poveste)
}