import 'dart:math' as math;

import 'package:flutter/material.dart';

class WebPreviewShell extends StatefulWidget {
  const WebPreviewShell({super.key, required this.child});

  final Widget child;

  @override
  State<WebPreviewShell> createState() => _WebPreviewShellState();
}

class _WebPreviewShellState extends State<WebPreviewShell> {
  static const _canvasColor = Color(0xFFFBF8FC);
  static const _panelColor = Color(0xFF141217);
  static const _mutedText = Color(0xFF9B969F);
  static const _accent = Color(0xFF9BE56E);

  bool _previewEnabled = true;
  bool _frameVisible = true;
  bool _landscape = false;
  bool _androidDevice = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(decoration: TextDecoration.none),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 760) {
            return widget.child;
          }

          final panelWidth = math.min(380.0, constraints.maxWidth * 0.34);
          return SizedBox.expand(
            child: Row(
              children: [
                Expanded(child: _buildCanvas()),
                SizedBox(width: panelWidth, child: _buildSettingsPanel()),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCanvas() {
    return ColoredBox(
      color: _canvasColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (!_previewEnabled) {
            return const Center(
              child: Icon(
                Icons.phone_iphone_rounded,
                size: 48,
                color: Color(0xFFCBC5CE),
              ),
            );
          }

          return Center(
            child: _buildPhonePreview(
              maxWidth: constraints.maxWidth - 36,
              maxHeight: constraints.maxHeight - 36,
            ),
          );
        },
      ),
    );
  }

  Widget _buildPhonePreview({
    required double maxWidth,
    required double maxHeight,
  }) {
    const framePadding = 9.0;
    const portraitDesignSize = Size(372, 826);
    final designSize = _landscape ? const Size(826, 372) : portraitDesignSize;
    final aspectRatio = designSize.width / designSize.height;
    final maxPreviewWidth = _landscape ? 560.0 : 330.0;
    final width = math.min(
      maxPreviewWidth,
      math.min(maxWidth, maxHeight * aspectRatio),
    );
    final height = width / aspectRatio;
    final mediaQuery = MediaQuery.of(context);
    final frameRadius = _landscape ? 42.0 : 48.0;
    final screenRadius = _landscape ? 33.0 : 39.0;

    return SizedBox(
      key: const Key('web-preview-phone'),
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (_frameVisible) ...[
            Positioned(
              left: -3,
              top: _landscape ? 52 : 135,
              child: _hardwareButton(width: 3, height: _landscape ? 48 : 34),
            ),
            Positioned(
              right: -3,
              top: _landscape ? 82 : 180,
              child: _hardwareButton(width: 3, height: _landscape ? 64 : 48),
            ),
            if (!_landscape)
              Positioned(
                right: -3,
                top: 125,
                child: _hardwareButton(width: 3, height: 34),
              ),
          ],
          Container(
            padding: EdgeInsets.all(_frameVisible ? framePadding : 0),
            decoration: _frameVisible
                ? BoxDecoration(
                    color: const Color(0xFF17191C),
                    borderRadius: BorderRadius.circular(frameRadius),
                    border: Border.all(
                      color: const Color(0xFF64717A),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.22),
                        blurRadius: 28,
                        offset: const Offset(0, 14),
                      ),
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.8),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  )
                : null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                _frameVisible ? screenRadius : 0,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: MediaQuery(
                      data: mediaQuery.copyWith(
                        size: designSize,
                        padding: const EdgeInsets.only(top: 25),
                        viewPadding: const EdgeInsets.only(top: 25),
                        viewInsets: EdgeInsets.zero,
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: SizedBox.fromSize(
                          size: designSize,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                  if (_frameVisible) _buildNotch(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hardwareButton({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF53616B),
        borderRadius: BorderRadius.circular(width),
      ),
    );
  }

  Widget _buildNotch() {
    final notch = Container(
      width: _landscape ? 22 : 100,
      height: _landscape ? 72 : 23,
      decoration: BoxDecoration(
        color: const Color(0xFF070809),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Container(
          width: _landscape ? 4 : 35,
          height: _landscape ? 35 : 4,
          decoration: BoxDecoration(
            color: const Color(0xFF25292E),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );

    if (_landscape) {
      return Positioned(
        left: 7,
        top: 0,
        bottom: 0,
        child: Center(child: notch),
      );
    }

    return Positioned(top: 7, left: 0, right: 0, child: Center(child: notch));
  }

  Widget _buildSettingsPanel() {
    return Material(
      key: const Key('web-preview-settings-panel'),
      color: _panelColor,
      child: SizedBox.expand(
        child: SafeArea(
          left: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 16, 20, 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Device preview',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Switch.adaptive(
                        value: _previewEnabled,
                        activeTrackColor: _accent,
                        onChanged: (value) =>
                            setState(() => _previewEnabled = value),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Color(0xFF27242B)),
                _buildSectionLabel('DEVICE'),
                _buildSettingRow(
                  label: 'Model',
                  value: _androidDevice ? 'Pixel 8' : 'iPhone 13',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _androidDevice
                            ? Icons.android_rounded
                            : Icons.phone_iphone_rounded,
                        size: 24,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 22,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onTap: () => setState(() => _androidDevice = !_androidDevice),
                ),
                _buildSettingRow(
                  label: 'Orientation',
                  value: _landscape ? 'Landscape' : 'Portrait',
                  trailing: Icon(
                    Icons.screen_rotation_alt_rounded,
                    size: 25,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  onTap: () => setState(() => _landscape = !_landscape),
                ),
                _buildSettingRow(
                  label: 'Frame visibility',
                  value: _frameVisible ? 'Visible' : 'Hidden',
                  trailing: Switch.adaptive(
                    value: _frameVisible,
                    activeTrackColor: _accent,
                    onChanged: (value) => setState(() => _frameVisible = value),
                  ),
                  onTap: () => setState(() => _frameVisible = !_frameVisible),
                ),
                const SizedBox(height: 28),
                _buildSectionLabel('SYSTEM'),
                _buildSettingRow(
                  label: 'Locale',
                  value: Localizations.localeOf(context).languageCode == 'fr'
                      ? 'French'
                      : 'English (United States)',
                  trailing: const Icon(
                    Icons.language_rounded,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                _buildSettingRow(
                  label: 'Theme',
                  value: 'Dark',
                  trailing: const Icon(
                    Icons.dark_mode_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 25, 20, 10),
      child: Text(
        label,
        style: const TextStyle(
          color: _mutedText,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildSettingRow({
    required String label,
    required String value,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 13, 20, 13),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
