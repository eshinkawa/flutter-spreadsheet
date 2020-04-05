class RowData {
  String _dia;
  String _max;
  String _min;
  String _batimentos;
  String _quando;

  RowData(this._dia, this._max, this._min, this._batimentos, this._quando);

  // Method to make GET parameters.
  String toParams() => 
    "?dia=$_dia&max=$_max&min=$_min&batimentos=$_batimentos&quando=$_quando";
  }