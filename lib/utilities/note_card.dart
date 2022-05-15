class NoteCard {
  String _term;
  String _def;
  NoteCard(this._term, this._def);

  void setTerm(String term) => _term = term;
  void setDef(String def) => _def = def;
  String getTerm() => _term;
  String getDef() => _def;
  @override
  String toString() => '$_term: $_def';
  String toJSON() => '["$_term", "$_def"]';
}