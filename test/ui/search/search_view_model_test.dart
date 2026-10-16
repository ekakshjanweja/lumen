import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumen/domain/models/light_connection.dart';
import 'package:lumen/domain/models/light_state.dart';
import 'package:lumen/domain/models/paired_light.dart';
import 'package:lumen/ui/search/view_models/search_view_model.dart';

import '../../testing/fakes.dart';

void main() {
  late FakeLightRepository lights;
  late FakeBluetoothRepository bluetooth;
  late ProviderContainer c;

  SearchViewModel vm() => c.read(searchViewModelProvider.notifier);
  SearchState state() => c.read(searchViewModelProvider);

  setUp(() {
    lights = FakeLightRepository();
    bluetooth = FakeBluetoothRepository();
    c = makeContainer(lights: lights, bluetooth: bluetooth);
    c.listen(searchViewModelProvider, (_, _) {}); // keep the auto-dispose view model alive
  });

  test('search blinks the factory-default channel and pairs on confirm', () async {
    await vm().search();

    expect(state().step, SearchStep.blinking);
    expect(lights.probes.first.$1, ChannelLight.factoryDefault);
    expect(lights.probes.first.$2.mode, LightMode.white);

    await vm().confirmBlinking();
    expect(lights.paired, ChannelLight.factoryDefault);
  });

  test('declined permission stays on the intro without broadcasting', () async {
    bluetooth.grantPermission = false;
    await vm().search();

    expect(state().step, SearchStep.intro);
    expect(lights.probes, isEmpty);
  });

  test('sweep turns candidates red, then confirms the one that flashes', () async {
    await vm().search();
    vm().rejectBlinking();

    expect(state().step, SearchStep.sweeping);
    final first = SearchViewModel.sweepOrder.first;
    expect(lights.probes.last.$1, first);
    expect(lights.probes.last.$2.hue, 0); // red

    vm().turnedRed();
    expect(state().step, SearchStep.confirming);
    expect(state().candidateCount, 1);
    expect(lights.probes.last.$1, first);

    await vm().confirmCandidate();
    expect(lights.paired, first);
  });

  test('rejecting every candidate resumes the sweep', () async {
    await vm().search();
    vm()
      ..rejectBlinking()
      ..turnedRed()
      ..rejectCandidate();

    expect(state().step, SearchStep.sweeping);
    expect(lights.probes.last.$1, SearchViewModel.sweepOrder[1]);
  });

  test('sweep never repeats the factory default it already tried', () {
    expect(SearchViewModel.sweepOrder, isNot(contains(ChannelLight.factoryDefault)));
    expect(SearchViewModel.sweepOrder.toSet().length, SearchViewModel.sweepOrder.length);
    expect(SearchViewModel.sweepOrder.length, channelCount * (groupCount + 1) - 1);
  });

  test('lights found in a scan are listed', () async {
    bluetooth.nearby.add([const FoundLight('aa', 'LYD_MWRGB', -50)]);
    await Future<void>.delayed(Duration.zero);

    expect(state().nearby.single.name, 'LYD_MWRGB');
  });

  test('leaving without pairing stops the probe broadcast', () async {
    await vm().search();
    c.dispose();

    expect(lights.endProbeCalls, 1);
  });
}
