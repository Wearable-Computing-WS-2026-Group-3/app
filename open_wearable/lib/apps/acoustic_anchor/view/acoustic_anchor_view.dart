import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:open_earable_flutter/open_earable_flutter.dart';
import 'package:open_wearable/apps/posture_tracker/model/earable_attitude_tracker.dart';
import 'package:open_wearable/models/wearable_display_group.dart';
import 'package:open_wearable/view_models/wearables_provider.dart';
import 'package:open_wearable/widgets/devices/devices_page.dart';
import 'package:provider/provider.dart';

class AcousticAnchorView extends StatefulWidget {
  final EarableAttitudeTracker _tracker;
  final Wearable wearable;

  final String deviceId;

  const AcousticAnchorView(this._tracker, {super.key,
  required this.wearable,
  required this.deviceId});

  @override
  State<AcousticAnchorView> createState() => _AcousticAnchorViewState();
}

class _AcousticAnchorViewState extends State<AcousticAnchorView> {
  late final WearablesProvider _wearablesProvider;
  Wearable? _wearable;

  @override
  void initState() {
    super.initState();
    _wearablesProvider = context.read<WearablesProvider>();
    _wearablesProvider.addListener(_updateConnection);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _updateConnection();
    });
  }

  void _updateConnection() {
    final wearable = _wearablesProvider.wearables
        .where((device) => device.deviceId == widget.wearable.deviceId)
        .firstOrNull;
    if (identical(wearable, _wearable)) {
      return;
    }
    setState(() {
      _wearable = wearable;
      if (wearable == null) {
        return;
      }});
  }

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Acoustic Anchor'),
      ),
      body: ListView(
        children: [
          DeviceRow(
              group: WearableDisplayGroup.single(
                  wearable: _wearable!,),),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: PlatformText("Das sollte die erste Karte sein"),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: PlatformText("Das sollte die zweite Karte sein"),
            ),
          ),
        ],
      ),
    );
  }
}
