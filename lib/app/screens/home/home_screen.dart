import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicslides_app/app/core/config/app_config.dart';
import 'package:magicslides_app/app/screens/home/home_controller.dart';
import 'package:magicslides_app/app/screens/login/auth_controller.dart';
import 'package:magicslides_app/app/screens/splash/splash_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    final themeController = Get.find<ThemeController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.slideshow),
            SizedBox(width: 8),
            Text('MagicSlides'),
          ],
        ),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: themeController.toggleTheme,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.signOut(),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSectionTitle('Topic'),
                    TextField(
                      controller: controller.topicController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: AppStrings.enterTopic,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('Additional Context (Optional)'),
                    TextField(
                      controller: controller.extraInfoController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: 'Focus on recent developments...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Template Type'),
                    Obx(
                      () => SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(
                            value: 'Default Template',
                            label: Text('Default'),
                          ),
                          ButtonSegment(
                            value: 'Editable Template',
                            label: Text('Editable'),
                          ),
                        ],
                        selected: {controller.selectedTemplateType.value},
                        onSelectionChanged: (Set<String> newSelection) {
                          controller.onTemplateTypeChanged(newSelection.first);
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Presentation Settings'),
                    _buildAdvancedOptions(),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: controller.generatePresentation,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Generate Presentation',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAdvancedOptions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(child: Text('Slide Count:')),
                Obx(
                  () => DropdownButton<int>(
                    value: controller.slideCount.value,
                    items: List.generate(
                      50,
                      (index) => DropdownMenuItem(
                        value: index + 1,
                        child: Text('${index + 1}'),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        controller.slideCount.value = value;
                      }
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('Template:')),
                Expanded(
                  child: Obx(
                    () => DropdownButton<String>(
                      value: controller.selectedTemplate.value,
                      isExpanded: true,
                      items: controller.availableTemplates
                          .map(
                            (template) => DropdownMenuItem(
                              value: template,
                              child: Text(
                                template,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedTemplate.value = value;
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('Language:')),
                Obx(
                  () => DropdownButton<String>(
                    value: controller.selectedLanguage.value,
                    items: const [
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'es', child: Text('Spanish')),
                      DropdownMenuItem(value: 'fr', child: Text('French')),
                      DropdownMenuItem(value: 'de', child: Text('German')),
                      DropdownMenuItem(value: 'hi', child: Text('Hindi')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedLanguage.value = value;
                      }
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('AI Model:')),
                Obx(
                  () => DropdownButton<String>(
                    value: controller.selectedModel.value,
                    items: ModelOptions.models
                        .map(
                          (model) => DropdownMenuItem(
                            value: model,
                            child: Text(model),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedModel.value = value;
                      }
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('Audience:')),
                Expanded(
                  child: Obx(
                    () => DropdownButton<String>(
                      value: controller.selectedAudience.value,
                      isExpanded: true,
                      items: PresentationAudience.audiences
                          .map(
                            (audience) => DropdownMenuItem(
                              value: audience,
                              child: Text(
                                audience,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedAudience.value = value;
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            const Text(
              'Image Options',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Obx(
              () => CheckboxListTile(
                title: const Text('AI Generated Images'),
                value: controller.aiImages.value,
                onChanged: (value) {
                  controller.aiImages.value = value ?? false;
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Obx(
              () => CheckboxListTile(
                title: const Text('Image on Each Slide'),
                value: controller.imageForEachSlide.value,
                onChanged: (value) {
                  controller.imageForEachSlide.value = value ?? true;
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Obx(
              () => CheckboxListTile(
                title: const Text('Google Images'),
                value: controller.googleImages.value,
                onChanged: (value) {
                  controller.googleImages.value = value ?? false;
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Obx(
              () => CheckboxListTile(
                title: const Text('Google Text'),
                value: controller.googleText.value,
                onChanged: (value) {
                  controller.googleText.value = value ?? false;
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const Divider(),
            Obx(
              () => CheckboxListTile(
                title: const Text('Add Watermark'),
                value: controller.enableWatermark.value,
                onChanged: (value) {
                  controller.enableWatermark.value = value ?? false;
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Obx(
              () => controller.enableWatermark.value
                  ? Column(
                      children: [
                        TextField(
                          controller: controller.watermarkUrlController,
                          decoration: const InputDecoration(
                            labelText: 'Watermark URL',
                            hintText: 'https://example.com/logo.png',
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.watermarkWidthController,
                                decoration: const InputDecoration(
                                  labelText: 'Width',
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller:
                                    controller.watermarkHeightController,
                                decoration: const InputDecoration(
                                  labelText: 'Height',
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
