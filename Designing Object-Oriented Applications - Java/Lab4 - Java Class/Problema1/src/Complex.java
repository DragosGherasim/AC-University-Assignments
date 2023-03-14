public class Complex {
    private int _re;
    private int _img;

    Complex(int re, int img) {
        this._re = re;
        this._img = img;
    }

    Complex() {
    }

    public void adunare(Complex c1) {
        this._re = this._re + c1._re;
        this._img = this._img + c1._img;
    }

    public void inmultire(Complex c1) {
        this._re = this._re * c1._re - this._img * c1._img;
        this._img = this._re * c1._img + c1._re * this._img;
    }

    public void ridicareLaPutere(int exp) {
        for (int i = 1; i < exp; ++i) {
            this.inmultire(this);
        }
    }

    @Override
    public boolean equals(Object c1){
        return this._re == ((Complex)c1)._re && this._img == ((Complex)c1)._img;
    }

    @Override
    public String toString(){
        return "(" + this._re + "," + this._img + ")";
    }
}