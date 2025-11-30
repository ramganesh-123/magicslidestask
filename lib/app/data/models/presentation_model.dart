class PresentationRequest {
  final String topic;
  final String? extraInfoSource;
  final String email;
  final String accessId;
  final String? template;
  final String? language;
  final int? slideCount;
  final bool? aiImages;
  final bool? imageForEachSlide;
  final bool? googleImage;
  final bool? googleText;
  final String? model;
  final String? presentationFor;
  final WatermarkConfig? watermark;

  PresentationRequest({
    required this.topic,
    this.extraInfoSource,
    required this.email,
    required this.accessId,
    this.template,
    this.language,
    this.slideCount,
    this.aiImages,
    this.imageForEachSlide,
    this.googleImage,
    this.googleText,
    this.model,
    this.presentationFor,
    this.watermark,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'topic': topic,
      'email': email,
      'accessId': accessId,
    };

    if (extraInfoSource != null) data['extraInfoSource'] = extraInfoSource;
    if (template != null) data['template'] = template;
    if (language != null) data['language'] = language;
    if (slideCount != null) data['slideCount'] = slideCount;
    if (aiImages != null) data['aiImages'] = aiImages;
    if (imageForEachSlide != null)
      data['imageForEachSlide'] = imageForEachSlide;
    if (googleImage != null) data['googleImage'] = googleImage;
    if (googleText != null) data['googleText'] = googleText;
    if (model != null) data['model'] = model;
    if (presentationFor != null) data['presentationFor'] = presentationFor;
    if (watermark != null) data['watermark'] = watermark!.toJson();

    return data;
  }
}

class WatermarkConfig {
  final String width;
  final String height;
  final String brandURL;
  final String position;

  WatermarkConfig({
    required this.width,
    required this.height,
    required this.brandURL,
    required this.position,
  });

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'brandURL': brandURL,
      'position': position,
    };
  }
}

class PresentationResponse {
  final bool success;
  final String? message;
  final PresentationData? data;

  PresentationResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory PresentationResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] is Map &&
        json['data']['message'] != null &&
        json['data']['message'].toString().contains('not enough credits')) {
      return PresentationResponse(
        success: false,
        message: json['data']['message'],
        data: null,
      );
    }

    return PresentationResponse(
      success: json['status'] == 'success',
      message: json['message'],
      data:
          json['data'] != null ? PresentationData.fromJson(json['data']) : null,
    );
  }
}

class PresentationData {
  final String url;
  final String? presentationId;
  final String? pptId;
  final String? message;
  final bool? error;

  PresentationData({
    required this.url,
    this.presentationId,
    this.pptId,
    this.message,
    this.error,
  });

  factory PresentationData.fromJson(Map<String, dynamic> json) {
    return PresentationData(
      url: json['url'] ?? '',
      presentationId: json['presentationId'],
      pptId: json['pptId'],
      message: json['message'],
      error: json['error'],
    );
  }
}
