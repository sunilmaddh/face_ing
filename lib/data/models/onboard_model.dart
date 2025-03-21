// To parse this JSON data, do
//
//     final pages = pagesFromJson(jsonString);

import 'dart:convert';

List<Pages> pagesFromJson(String str) => List<Pages>.from(json.decode(str).map((x) => Pages.fromJson(x)));

String pagesToJson(List<Pages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pages {
    String image;
    String title;
    String description;

    Pages({
        required this.image,
        required this.title,
        required this.description,
    });

    factory Pages.fromJson(Map<String, dynamic> json) => Pages(
        image: json["image"],
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "description": description,
    };
}
