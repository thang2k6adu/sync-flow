class Meaning {
  final int order;
  final String? pos;
  final String meaningVi;
  final String? definitionEn;
  final String? exampleEn;
  final String? exampleVi;

  const Meaning({
    required this.order,
    this.pos,
    required this.meaningVi,
    this.definitionEn,
    this.exampleEn,
    this.exampleVi,
  });
}
