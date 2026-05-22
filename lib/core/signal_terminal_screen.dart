import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/widgets/anomaly_panel_widget.dart';
import 'package:signal/core/widgets/crt_distortion.dart';
import 'package:signal/core/widgets/footer_widget.dart';
import 'package:signal/core/widgets/header_logo_widget.dart';
import 'package:signal/core/widgets/header_metadata_widget.dart';
import 'package:signal/core/widgets/menu_panel_widget.dart';
import 'package:signal/core/widgets/radar_panel_widget.dart';
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

class MainPanelWidget extends StatelessWidget {
  const MainPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: primaryColor.withValues(alpha: 0.35), width: 1.5),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              //* MENU - RADAR *//
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: MenuPanelWidget()),
                  Expanded(child: RadarPanelWidget()),
                ],
              ),
            ),
            Expanded(
              //*  INDEX - ANOMALY*//
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: EntriesIndexPanelWidget()),
                  Expanded(child: AnomalyPanelWidget()),
                ],
              ),
            ),
            Expanded(
              //* ENTRY CONSOLE *//
              flex: 2,
              child: TextField(
                maxLines: null,
                expands: true,
                cursorColor: primaryColor,
                cursorWidth: 10,
                cursorHeight: 22,
                autofocus: true,
                style: TextStyle(
                  color: primaryColor,
                  fontFamily: 'VT323',
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: primaryColor,
                      offset: Offset(0, 0)
                    )
                  ]
                ),
                decoration: const InputDecoration(
                  prefixText: ">",
                  
                  prefixStyle: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class EntriesIndexPanelWidget extends StatelessWidget {
  const EntriesIndexPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: BoxBorder.fromLTRB(
          bottom: BorderSide(width: 1.5, color: primaryColor.withValues(alpha: 0.35)),
          right: BorderSide(width: 1.5, color: primaryColor.withValues(alpha: 0.35))
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ENTRY // INDEX', 
            style: TextStyle(
              color: primaryColor.withValues(alpha: 0.8),
              shadows: [
                Shadow(
                  color: primaryColor.withValues(alpha: 0.8),
                  blurRadius: 2, 
                  offset: Offset(0, 0)
                ),
              ],
            ),
          ),
          Text('LOCAL_WRITE: ACTIVE', style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72))),
          Text('TEXT_INTEGRITY: 98.2%', style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72))),
          Text('AUTOSAVE_NODE: E-19', style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72))),
          Text('TIME_STAMP: 30 MAY 2026', style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72))),
          Text('WORD_CNT: 0182', style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72))),
          Text('CHAR_CNT: 1240', style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72))),
          Text('BUFFER_USAGE: 38%',style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72))),
          Text('[████░░░░░░]', style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72)))
        ],
      ),
    );
  }
}
