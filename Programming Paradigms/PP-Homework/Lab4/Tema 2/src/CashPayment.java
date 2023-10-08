public class CashPayment implements PaymentMethod{
    private double _availableAmount;

    CashPayment(double avAm){
        _availableAmount = avAm;
    }

    @Override
    public boolean pay(double fee){
        if (_availableAmount - fee >= 0){
            _availableAmount -= fee;
            return true;
        }
        return false;
    }
}
