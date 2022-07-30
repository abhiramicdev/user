import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user_app/models/user_details.dart';

class DetailScreen extends StatelessWidget {
  final UserDetails userDetails;
  const DetailScreen(this.userDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xff0F2E39)),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 112,
                  width: 112,
                  color: Colors.grey[200],
                  child: userDetails.profileImage != null
                      ? CachedNetworkImage(
                          imageUrl: userDetails.profileImage ?? "")
                      : const Icon(Icons.person, size: 55, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userDetails.name ?? "",
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 7),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      "@${userDetails.username ?? ""}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "${userDetails.email ?? ""} | ${userDetails.phone ?? ""}",
              ),
              const SizedBox(height: 12),
              (userDetails.website != null || userDetails.website != 'null')
                  ? Column(
                      children: [
                        Row(
                          children: [
                            const Text("Website: "),
                            SizedBox(
                              height: 45,
                              child: Center(
                                child: Text(
                                  userDetails.website ?? "",
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    )
                  : const SizedBox(),
              const Text(
                "Address: ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(userDetails.street ?? ""),
              const SizedBox(height: 12),
              Text(userDetails.suite ?? ""),
              const SizedBox(height: 12),
              Text(userDetails.city ?? ""),
              const SizedBox(height: 12),
              const Text(
                "Company Details: ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                userDetails.companyName ?? "",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text("Tag line: ${userDetails.catchPhrase ?? ""}"),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Industry: ${userDetails.bs ?? ""}",
              ),
            ],
          ),
        ));
  }
}
