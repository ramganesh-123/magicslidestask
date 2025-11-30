import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicslides_app/app/screens/home/home_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultView extends GetView<HomeController> {
  const ResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generated Presentation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.resetForm();
              Get.back();
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.presentationResult.value == null) {
            return const Center(
              child: Text('No presentation generated yet'),
            );
          }

          final url = controller.presentationResult.value!.data!.url;
          final isPdf = url.toLowerCase().endsWith('.pdf');

          return Column(
            children: [
              Expanded(
                child: Card(
                  margin: const EdgeInsets.all(16),
                  child: isPdf
                      ? SfPdfViewer.network(
                          url,
                          onDocumentLoadFailed:
                              (PdfDocumentLoadFailedDetails details) {
                            Get.snackbar(
                              'Error',
                              'Failed to load PDF: ${details.error}',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.slideshow,
                                size: 100,
                                color: Color(0xFF9D781C),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Presentation Generated Successfully!',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Download to view or open in browser',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () => _launchURL(url),
                                icon: const Icon(Icons.open_in_browser),
                                label: const Text('Open in Browser'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (controller.pdfPath.value.isEmpty)
                      ElevatedButton.icon(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.downloadPresentation,
                        icon: controller.isLoading.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Icon(Icons.download),
                        label: Text(
                          controller.isLoading.value
                              ? 'Downloading...'
                              : 'Download Presentation',
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )
                    else
                      // Show Open button after download
                      ElevatedButton.icon(
                        onPressed: () => controller
                            .openDownloadedFile(controller.pdfPath.value),
                        icon: const Icon(Icons.folder_open),
                        label: const Text('Open Presentation'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        controller.resetForm();
                        Get.back();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Create New Presentation'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      print('Attempting to launch URL: $url');
      final uri = Uri.parse(url);

      final canLaunch = await canLaunchUrl(uri);
      print('Can launch URL: $canLaunch');

      if (canLaunch) {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        print('Launch result: $launched');

        if (!launched) {
          Get.snackbar(
            'Error',
            'Could not open the URL in browser',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'No app available to open this link',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error launching URL: $e');
      Get.snackbar(
        'Error',
        'Failed to open URL: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
