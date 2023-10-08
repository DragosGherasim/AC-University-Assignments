//utilizam File din Java.io pentru a deschide fisierul text
import java.io.File

fun GetUniqueWordCount(all_words : List<String>) : MutableMap<String, Int> {
    //functia pentru calculul cuvintelor unice
    val result = mutableMapOf<String, Int>()
    return result
}

fun GetUniqueCharCount(all_chars : List<String>) : MutableMap<Char, Int> {
    //functia pentru calculul caracterelor unice
    val result = mutableMapOf<Char, Int>()
    return result
}

fun SortByHitCount(items : MutableMap<Char, Int>, how: Boolean) : MutableMap<Int, Char>{
    //functia de sortare a caracterelor, dupa valoare (frecventa), atat crescator cat si descrescator, in functie de how
    val result = mutableMapOf<Int, Char>()
    return result
}

//functia main()
fun main(args : Array<String>){
    //citim liniile din fisier
    val lines = File("src/main/resources/Fisier.txt").reader().readText()
    //construim un array de cuvinte, seprand prin spatiu
    val words = lines.split(" ")

    //eliminam semnele de punctuatie de pe marginile cuvintelor
    val trim_words = mutableListOf<String>()
    words.forEach {
        val filter = it.trim(',','.','"','?', '!')
        trim_words += filter.toLowerCase()
        print(filter + " ")
    }
    println("\n")

    //construim o lista cu toate caracterele folosite 'A..Z'
    val chars = mutableListOf<String>()
    trim_words.forEach {
        for (c in it){
            if (c in 'a'..'z' || c in 'A'..'Z') {
                chars += c.toUpperCase().toString()
                print(c.toUpperCase())
            }
        }
    }
    println("\n")

    //Pentru constructia histogramelor, R foloseste un mecanism prin care asociaza caracterelor unice, numarul total de aparitii (frecventa)
    // 1. Construiti in Kotlin acelasi mecanism de masurare a frecventei elementelor unice si afisati cuvintele unice din trim_words
    // 2. Construiti in Kotlin acelasi mecanism de masurare a frecventei elementelor unice si afisati caracterele unice din chars
    // 3. Pentru frecventele caracterelor unice caclulate anterior si
    //      A. Afisati perechile (frecventa -> Caracter) sortate crescator si descrescator
    //      B. afisati graficele variatiei de frecventa sortate anterior crescator si descrescator si concatenati-le intr-un grafic de puncte

    //construim histograma pentru cuvinte
    //RHistogram.BuildHistogram(trim_words.toTypedArray(), "Words", true)
    //construim histograma pentru caractere
    //RHistogram.BuildHistogram(chars.toTypedArray(), "Chars", true)

    val uniqueWords = trim_words.groupBy { it }.mapValues { it.value.size } // .groupBy() -> groups the words in the trim_words list by their value,
                                                                            // so that all occurrences of each word are grouped together :
                                                                            // (mr=[mr, mr, mr, mr, mr, mr, mr...], coyote=[coyote, coyote...
                                                                            // {it} -> for single param lambda expression, iterating through trim_words
                                                                            // and process each element.
                                                                            // .mapValues() -> convert the list of occurrences of each word to their count
                                                                            // {it.value.size} -> returns the size of the list of values for the current key.
    println("Unique words: $uniqueWords")

    val uniqueChars = chars.groupBy { it }.mapValues { it.value.size }
    println("Unique chars: $uniqueChars")

    val ascUniqueWords = uniqueWords.entries.sortedBy { it.value }.associate { it.toPair() }    // .entries -> converts the map to a list of entries (key-value pair)
                                                                                                // .sortedBy {it.value} -> returns a sorted list by value
                                                                                                // .associate is a higher-order function that transforms the Set of Map.Entry
                                                                                                // objects into a new Map object.
                                                                                                // it.toPair() -> is a function that returns a Pair object created from the key-value
                                                                                                // pair of the current entry.
    println("Ascending sorted unique words : $ascUniqueWords")

    val descUniqueWords = uniqueWords.entries.sortedByDescending { it.value }.associate { it.toPair() }
    println("Descending sorted unique words : $descUniqueWords\n")

    val ascUniqueChars = uniqueChars.entries.sortedBy { it.value }.associate { it.toPair() }
    println("Ascending sorted unique words : $ascUniqueChars")

    val descUniqueChars= uniqueChars.entries.sortedByDescending { it.value }.associate { it.toPair() }
    println("Descending sorted unique words : $descUniqueChars")
}
