import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_jobsity/core/design_system/colors.dart';

import '../../../../../core/design_system/text_styles.dart';
import '../../../../show_details/presentation/ui/show_details_page.dart';

class ShowCard extends StatelessWidget {
  const ShowCard({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.rating,
  });

  final int id;
  final String image;
  final String name;
  final num rating;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowDetailsPage(
              showId: id,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.all(4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 190,
                  width: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return const SizedBox(
                          height: 30,
                          width: 30,
                          child: Center(
                            child: Opacity(
                              opacity: 0.2,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                      imageUrl: image,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 34,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(rating.toString(), style: showRating),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: title.copyWith(
                fontSize: 12,
                color: headerColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
