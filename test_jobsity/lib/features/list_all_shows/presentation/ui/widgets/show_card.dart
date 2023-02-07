import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_jobsity/core/design_system/colors.dart';

import '../../../../../core/design_system/text_styles.dart';
import '../../../../show_details/presentation/ui/show_details_page.dart';
import '../../../data/models/show.dart';

class ShowCard extends ConsumerStatefulWidget {
  const ShowCard({
    super.key,
    required this.show,
  });

  final Show show;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShowCardState();
}

class _ShowCardState extends ConsumerState<ShowCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final resetHomeAndFavorites = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowDetailsPage(
              showId: widget.show.id,
            ),
          ),
        );

        resetHomeAndFavorites();
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
                      imageUrl: widget.show.image ??
                          'https://via.placeholder.com/140x190',
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
                      child: Text(
                        (widget.show.rating ?? 0).toString(),
                        style: showRating,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.show.name ?? 'No Name',
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
