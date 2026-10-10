/// A sargam syllable relative to Sa.
enum SwaraVariant { shuddha, komal, tivra }

/// Scale degree of a note once Sa is chosen.
///
/// Degrees: 0 Sa, 1 Re, 2 Ga, 3 Ma, 4 Pa, 5 Dha, 6 Ni.
class Swara {
  const Swara({required this.degree, required this.variant});

  final int degree;
  final SwaraVariant variant;

  @override
  bool operator ==(Object other) {
    return other is Swara &&
        other.degree == degree &&
        other.variant == variant;
  }

  @override
  int get hashCode => Object.hash(degree, variant);

  /// Semitone offset from Sa, in equal temperament (0–11).
  static const semitoneMap = <Swara>[
    Swara(degree: 0, variant: SwaraVariant.shuddha), // Sa
    Swara(degree: 1, variant: SwaraVariant.komal), // komal Re
    Swara(degree: 1, variant: SwaraVariant.shuddha), // Re
    Swara(degree: 2, variant: SwaraVariant.komal), // komal Ga
    Swara(degree: 2, variant: SwaraVariant.shuddha), // Ga
    Swara(degree: 3, variant: SwaraVariant.shuddha), // Ma
    Swara(degree: 3, variant: SwaraVariant.tivra), // tivra Ma
    Swara(degree: 4, variant: SwaraVariant.shuddha), // Pa
    Swara(degree: 5, variant: SwaraVariant.komal), // komal Dha
    Swara(degree: 5, variant: SwaraVariant.shuddha), // Dha
    Swara(degree: 6, variant: SwaraVariant.komal), // komal Ni
    Swara(degree: 6, variant: SwaraVariant.shuddha), // Ni
  ];
}
