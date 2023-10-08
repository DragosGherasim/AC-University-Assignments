import java.util.*;

public class BankAccount {
    private double _availableAmount;
    private String _cardNumber;
    private int _expirationDate;
    private int _cvvCode;
    private String _userName;

    BankAccount(double avAm, String crdNum, int expDate, int cvv, String userName){
        _availableAmount = avAm;
        _cardNumber = crdNum;
        _expirationDate = expDate;
        _cvvCode = cvv;
        _userName = userName;
    }

    public boolean substractAmount(double value){
        if (_availableAmount - value >= 0){
            _availableAmount -= value;
            return true;
        }
        return false;
    }

    public void addingAmount(double value){
        _availableAmount += value;
    }

    public void afisareBalanta(){
        System.out.printf("Balanta Contului %s este : %f\n", _userName, _availableAmount);
    }
}
