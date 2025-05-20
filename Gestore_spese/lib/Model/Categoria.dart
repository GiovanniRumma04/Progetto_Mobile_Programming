class Categoria{

  late String _nomeCategoria;
  late int _numSpese;

  Categoria(String nomeCategoria) {
    _nomeCategoria = nomeCategoria;
    _numSpese = 0;
  }

  String get nomeCategoria => _nomeCategoria;
  int get numSpese => _numSpese;

  addNumSpese(){
    _numSpese = _numSpese+1;
  }

  remNumSpese(){
    _numSpese = _numSpese-1;
  }

  @override
  String toString() {
    return 'Categoria: $_nomeCategoria, Spese totali: $_numSpese';
  }
}