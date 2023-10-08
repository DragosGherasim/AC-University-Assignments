public class CardPayment implements PaymentMethod{
    private BankAccount _bankAccount;

    CardPayment(BankAccount bnkAcc){
        _bankAccount = bnkAcc;
    }

    @Override
    public boolean pay(double fee){
        return _bankAccount.substractAmount(fee);
    }
}
