import 'package:flutter/material.dart';
import 'package:signal/core/widgets/main_panel_widget.dart';
import 'package:signal/core/widgets/crt_distortion.dart';
import 'package:signal/core/widgets/footer_widget.dart';
import 'package:signal/core/widgets/header_logo_widget.dart';
import 'package:signal/core/widgets/header_metadata_widget.dart';
import 'package:signal/core/widgets/status_bar_widget.dart';

class SignalTerminalScreen extends StatefulWidget {
  const SignalTerminalScreen({super.key});

  @override
  State<SignalTerminalScreen> createState() => _SignalTerminalScreenState();
}

class _SignalTerminalScreenState extends State<SignalTerminalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CRTDistortion(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderMetadataWidget(),
                const HeaderLogoWidget(),
                const StatusBarWidget(),
                const Expanded(child: MainPanelWidget()),
                const FooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
