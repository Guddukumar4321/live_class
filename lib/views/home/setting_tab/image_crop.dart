import 'dart:io';
import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';


import '../../../core/theme/app_theme.dart';


class CropSample extends StatefulWidget {
  final File tempImage;

  const CropSample({required this.tempImage, super.key});

  @override
  _CropSampleState createState() => _CropSampleState();
}

class _CropSampleState extends State<CropSample> {
  final _cropController = CropController();

  Uint8List? _imageBytes;
  Uint8List? _croppedData;
  bool _isCircleUi = false;
  bool _isThumbnail = false;
  bool _isOverlayActive = true;

  @override
  void initState() {
    super.initState();
    _loadImageFromFile();
  }



  Future<void> _loadImageFromFile() async {
    final bytes = await widget.tempImage.readAsBytes();
    setState(() => _imageBytes = bytes);
  }

  @override
  Widget build(BuildContext context) {
    return _imageBytes == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: _croppedData == null
                    ? Stack(
                        children: [
                          Crop(
                            controller: _cropController,
                            image: _imageBytes!,
                            withCircleUi: _isCircleUi,
                            fixCropRect: true,
                            willUpdateScale: (scale) => scale < 5,
                            onCropped: (result) async {
                              switch (result) {
                                case CropSuccess(:final croppedImage):
                                  print("check run type :: ${croppedImage.runtimeType}");
                                    if (mounted) {
                                      Navigator.pop(context, croppedImage);
                                    }
                                  break;

                                case CropFailure(:final cause):
                                  if (!mounted) return;

                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Crop Failed'),
                                      content: Text('Reason: $cause'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                              }
                            },
                            initialRectBuilder: InitialRectBuilder.withBuilder((
                              viewportRect,
                              imageRect,
                            ) {
                              return Rect.fromLTRB(
                                viewportRect.left + 24,
                                viewportRect.top + 24,
                                viewportRect.right - 24,
                                viewportRect.bottom - 24,
                              );
                            }),
                            overlayBuilder: _isOverlayActive
                                ? (context, rect) {
                                    final overlay = CustomPaint(
                                      painter: GridPainter(),
                                    );
                                    return _isCircleUi
                                        ? ClipOval(child: overlay)
                                        : overlay;
                                  }
                                : null,
                          ),
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: GestureDetector(
                              onTapDown: (_) =>
                                  setState(() => _isThumbnail = true),
                              onTapUp: (_) =>
                                  setState(() => _isThumbnail = false),
                              child: CircleAvatar(
                                backgroundColor: _isThumbnail
                                    ? Colors.blue.shade50
                                    : Colors.blue,
                                child: const Icon(Icons.crop_free_rounded),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
              ),
              _buildControls(),
            ],
          );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: [
              IconButton(
                icon: Icon(Icons.crop_7_5, color: AppColors.card),
                onPressed: () {
                  _isCircleUi = false;
                  _cropController.aspectRatio = 16 / 4;
                },
              ),
              IconButton(
                icon: const Icon(Icons.crop_16_9, color: AppColors.card),
                onPressed: () {
                  _isCircleUi = false;
                  _cropController.aspectRatio = 16 / 9;
                },
              ),
              IconButton(
                icon: const Icon(Icons.crop_5_4, color: AppColors.card),
                onPressed: () {
                  _isCircleUi = false;
                  _cropController.aspectRatio = 4 / 3;
                },
              ),
              IconButton(
                icon: const Icon(Icons.crop_square, color: AppColors.card),
                onPressed: () {
                  _isCircleUi = false;
                  _cropController
                    ..withCircleUi = false
                    ..aspectRatio = 1;
                },
              ),
              IconButton(
                icon: const Icon(Icons.circle, color: AppColors.card),
                onPressed: () {
                  _isCircleUi = true;
                  _cropController.withCircleUi = true;
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {

              _isCircleUi
                  ? _cropController.cropCircle()
                  : _cropController.crop();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('CROP IT!'),
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final Paint _paint = Paint()
    ..color = Colors.white.withOpacity(0.7)
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final double thirdWidth = size.width / 3;
    final double thirdHeight = size.height / 3;

    // Draw vertical lines
    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(thirdWidth * i, 0),
        Offset(thirdWidth * i, size.height),
        _paint,
      );
    }

    // Draw horizontal lines
    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(0, thirdHeight * i),
        Offset(size.width, thirdHeight * i),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
