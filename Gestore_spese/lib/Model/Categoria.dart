class Categoria {
  late String _nomeCategoria;

  late int _numSpese;

  Categoria(String nomeCategoria) {
    _nomeCategoria = nomeCategoria;
    _numSpese = 0;
  }

  Categoria.init(this._nomeCategoria, this._numSpese);

  String get nomeCategoria => _nomeCategoria;


  set nomeCategoria(String value) {
    _nomeCategoria = value;
  }

  int get numSpese => _numSpese;

  set numSpese(int value) {
    _numSpese = value;
  }

  addNumSpese() {
    _numSpese = _numSpese + 1;
  }

  remNumSpese() {
    _numSpese = _numSpese - 1;
  }

  @override
  bool operator ==(Object other) {
    return other is Categoria &&
        other.nomeCategoria.toLowerCase() == nomeCategoria.toLowerCase(); // case-insensitive
  }

  /*Map<String, dynamic> toJson(){

    return{
      'nomeCategoria': nomeCategoria,
      'numSpese': numSpese
    };

  }

  factory Categoria.fromJson(Map<String, dynamic> json){
    Categoria c = new Categoria(json['nomeCategoria']);
    c.numSpese = json['numSpese'];
    return c;
  }*/

  @override
  String toString() {
    return 'Categoria: $_nomeCategoria, Spese totali: $_numSpese';
  }
}
