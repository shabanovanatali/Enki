class Details {
  Details(
      {required this.normalized, required this.visual, required this.meanings});

  factory Details.from(dynamic json) {
    // print("Details.from $json");

    List<Meaning> meanings = [];

    for (final data in json["meanings"]) {
      final meaning = Meaning.from(data);
      meanings.add(meaning);
    }

    return Details(
      normalized: json["normalized"],
      visual: json["visual"],
      meanings: meanings,
    );
  }
  final String normalized;
  final String visual;
  List<Meaning> meanings;
}

class Meaning {
  Meaning({required this.lemma, required this.pos, required this.trans});

  factory Meaning.from(dynamic json) {
    print("Meaning $json");

    List<Trans> trans = [];

    for (final data in json["trans"]) {
      final tran = Trans.from(data);
      trans.add(tran);
    }

    return Meaning(
      lemma: json["lemma"],
      pos: json["pos"],
      trans: trans,
    );
  }

  final String lemma;
  final String pos;
  final List<Trans> trans;
}

class Trans {
  Trans(
      {required this.count,
      required this.pc,
      required this.eng_label,
      required this.rus_label});

  factory Trans.from(dynamic json) {
    print("Trans $json");

    final labels = json["labels"];

    return Trans(
      count: json["count"],
      pc: json["pc"],
      eng_label: labels["eng"],
      rus_label: labels["rus"],
    );
  }

  final int count;
  final int pc;
  final String eng_label;
  final String rus_label;
}
