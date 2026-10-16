class Effect {
  const Effect(this.id, this.name, this.group);
  final int id;
  final String name;
  final String group;
}

/// Display order of effect groups.
const effectGroups = ['Ambient', 'Emergency', 'Flash & strobe', 'Party'];

/// Effect ids as numbered by the light's firmware.
const effects = [
  Effect(1, 'Flash 1', 'Flash & strobe'),
  Effect(2, 'Flash 2', 'Flash & strobe'),
  Effect(3, 'TV', 'Ambient'),
  Effect(4, 'Candle', 'Ambient'),
  Effect(5, 'Flame 1', 'Ambient'),
  Effect(6, 'Flame 2', 'Ambient'),
  Effect(7, 'Police', 'Emergency'),
  Effect(8, 'Ambulance', 'Emergency'),
  Effect(9, 'Fire truck', 'Emergency'),
  Effect(10, 'Strobe 1', 'Flash & strobe'),
  Effect(11, 'Strobe 2', 'Flash & strobe'),
  Effect(12, 'Strobe 3', 'Flash & strobe'),
  Effect(13, 'Chase 1', 'Party'),
  Effect(14, 'Chase 2', 'Party'),
  Effect(15, 'Chase 3', 'Party'),
  Effect(16, 'Fireworks 1', 'Party'),
  Effect(17, 'Fireworks 2', 'Party'),
  Effect(18, 'Fireworks 3', 'Party'),
  Effect(19, 'Club 1', 'Party'),
  Effect(20, 'Club 2', 'Party'),
  Effect(21, 'Romantic', 'Ambient'),
  Effect(22, 'Music', 'Party'),
  Effect(23, 'Wave 1', 'Party'),
  Effect(24, 'Wave 2', 'Party'),
];

Effect effectById(int id) => effects[(id - 1).clamp(0, effects.length - 1)];
