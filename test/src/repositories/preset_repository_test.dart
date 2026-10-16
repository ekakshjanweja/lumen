import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:lumen/src/core/models/color_preset.dart';
import 'package:lumen/src/core/providers.dart';
import 'package:lumen/src/modules/control/view_models/presets_view_model.dart';
import 'package:lumen/src/repositories/preset_repository.dart';
import 'package:lumen/src/services/preset_store.dart';

void main() {
  late Directory dir;
  late Box<Map> box;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('lumen_presets');
    Hive.init(dir.path);
    box = await Hive.openBox<Map>(PresetStore.boxName);
  });

  tearDown(() async {
    await Hive.close();
    await dir.delete(recursive: true);
  });

  test('saved presets survive a restart, oldest first', () async {
    final repo = PresetRepository(store: PresetStore(box));
    await repo.save(name: 'Reading', hue: 30, saturation: 40);
    await repo.save(name: 'Party', hue: 300, saturation: 100);

    final reloaded = PresetRepository(store: PresetStore(box));
    expect(reloaded.saved.map((p) => (p.name, p.hue, p.saturation)), [('Reading', 30, 40), ('Party', 300, 100)]);
  });

  test('delete removes it from memory and storage', () async {
    final repo = PresetRepository(store: PresetStore(box));
    final p = await repo.save(name: 'Gone', hue: 10, saturation: 10);
    await repo.delete(p);

    expect(repo.saved, isEmpty);
    expect(PresetRepository(store: PresetStore(box)).saved, isEmpty);
  });

  test('deleted built-ins stay hidden after a restart until restored', () async {
    final repo = PresetRepository(store: PresetStore(box));
    final red = builtInPresets.first;
    await repo.delete(red);

    expect(repo.builtIns, isNot(contains(red)));
    expect(repo.builtIns, hasLength(builtInPresets.length - 1));
    final reloaded = PresetRepository(store: PresetStore(box));
    expect(reloaded.builtIns, isNot(contains(red)));
    expect(reloaded.saved, isEmpty, reason: 'the hidden list is not a preset');

    await reloaded.restoreBuiltIns();
    expect(PresetRepository(store: PresetStore(box)).builtIns, builtInPresets);
  });

  test('view model can restore once a built-in is deleted', () async {
    final container = ProviderContainer(overrides: [presetBoxProvider.overrideWithValue(box)]);
    addTearDown(container.dispose);
    container.listen(presetsViewModelProvider, (_, _) {});
    final vm = container.read(presetsViewModelProvider.notifier);
    expect(container.read(presetsViewModelProvider).canRestore, isFalse);

    await vm.delete(builtInPresets[3]);
    expect(container.read(presetsViewModelProvider).canRestore, isTrue);
    expect(container.read(presetsViewModelProvider).all, isNot(contains(builtInPresets[3])));

    await vm.restoreBuiltIns();
    expect(container.read(presetsViewModelProvider).canRestore, isFalse);
  });

  test('values are normalised and blank names get a default', () async {
    final repo = PresetRepository(store: PresetStore(box));
    final p = await repo.save(name: '   ', hue: 370, saturation: 150);
    expect((p.name, p.hue, p.saturation), ('My color', 10, 100));
  });

  test('entries that do not parse are skipped', () async {
    await box.put('bad', {'name': 3});
    await box.put('00000000000000000001', {'name': 'Ok', 'hue': 5, 'saturation': 50});
    expect(PresetRepository(store: PresetStore(box)).saved.map((p) => p.name), ['Ok']);
  });

  test('view model lists newest saved first, then built-ins, and follows changes', () async {
    final container = ProviderContainer(overrides: [presetBoxProvider.overrideWithValue(box)]);
    addTearDown(container.dispose);
    container.listen(presetsViewModelProvider, (_, _) {});
    final vm = container.read(presetsViewModelProvider.notifier);

    await vm.save('First', hue: 1, saturation: 1);
    await vm.save('Second', hue: 2, saturation: 2);
    final all = container.read(presetsViewModelProvider).all;
    expect(all.take(2).map((p) => p.name), ['Second', 'First']);
    expect(all.skip(2), builtInPresets);

    await vm.delete(all.first);
    expect(container.read(presetsViewModelProvider).saved.map((p) => p.name), ['First']);
  });
}
