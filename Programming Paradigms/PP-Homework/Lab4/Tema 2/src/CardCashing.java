public class CardCashing implements CashingMethod{
    private BankAccount _bankAccount;

    CardCashing(BankAccount bnkAcc){
        _bankAccount = bnkAcc;
    }
    @Override
    public void cashing(double value){
        _bankAccount.addingAmount(value);
    }
}
