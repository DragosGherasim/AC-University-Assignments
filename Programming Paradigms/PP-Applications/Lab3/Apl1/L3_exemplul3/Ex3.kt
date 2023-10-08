import java.util.Scanner


class Birth(val Year: Int, val Month: Int, val Day: Int){ // by-default public, val - immutable property (read-only)
    override fun toString() : String{
        return "($Day.$Month.$Year)"
    }
}

class Contact(val Name: String, var Phone: String, val BirthDate: Birth){
    fun Print() : Unit { // void
        println("Name: $Name, Mobile: $Phone, Date: $BirthDate")
    }

    fun SetPhoneNumber(phoneNumber: String) {
        Phone = phoneNumber
    }

}

class Agenda(val ListOfContacts : MutableList<Contact> = mutableListOf()){
    fun AddContact(contact : Contact) {
        ListOfContacts.add(contact)
    }

    fun PrintContacts(){
        for(contact in ListOfContacts){
            contact.Print()
        }
    }

    fun RemoveContact(name : String){
        for (contact in ListOfContacts){
            if (contact.Name == name){
                ListOfContacts.remove(contact)
                break
            }
        }
    }

    fun FindContactByName(name : String): Contact?{ // Contact? -> Contact or null
        return ListOfContacts.find {it.Name == name} // return contacts.find (fun(contact: Contact): Boolean {
                                                     //        return contact.phoneNumber == phoneNumber })
    }

    fun FindContactByPhoneNumber(phoneNumber : String): Contact?{
        return ListOfContacts.find {it.Phone == phoneNumber}
    }

    fun UpdatePhoneNumber(name : String, phoneNumber: String){
        FindContactByName(name)?.SetPhoneNumber(phoneNumber)
    }
}


fun main(args : Array<String>){
    val agenda = Agenda()

    agenda.AddContact(Contact("Mihai", "0744321987", Birth(1900, 11, 25)))
    agenda.AddContact(Contact("George", "0761332100", Birth(2002, 3, 14)))
    agenda.AddContact(Contact("Liviu" , "0231450211", Birth(1999, 7, 30)))
    agenda.AddContact(Contact("Popescu", "0211342787", Birth(1955, 5, 12)))

    agenda.PrintContacts()

    println("\nAgenda dupa eliminare contact [George]:")
    agenda.RemoveContact("George")
    agenda.PrintContacts()

    val input = Scanner(System.`in`)

    print("\nCe contact vreti sa cautati dupa nume : ")
    var nameToFind = input.nextLine()
    println("Contactul gasit : ")
    agenda.FindContactByName(nameToFind)?.Print() // '?.' acceseaza un obiect chiar daca este null fara a genera exceptia NullPointerException.

    print("\nCe contact vreti sa cautati dupa numar : ")
    var phoneNumber = input.nextLine()
    println("Contactul gasit : ")
    agenda.FindContactByPhoneNumber(phoneNumber)?.Print()

    print("\nPentru ce contact doriti sa schimbati numarul de telefon : ")
    nameToFind = input.nextLine()
    print("\nCare este numarul actualizat : ")
    phoneNumber = input.nextLine()
    agenda.UpdatePhoneNumber(nameToFind, phoneNumber)

    agenda.PrintContacts()
}


