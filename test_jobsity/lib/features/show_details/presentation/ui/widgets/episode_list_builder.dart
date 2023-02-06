import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_jobsity/core/design_system/colors.dart';
import 'package:test_jobsity/core/utils/remove_html_tags_from_string.dart';
import 'package:test_jobsity/features/show_details/data/models/episode.dart';

class EpisodeListBuilder extends ConsumerStatefulWidget {
  const EpisodeListBuilder({super.key, required this.episodes});

  final List<Episode> episodes;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EpisodeListBuilderState();
}

class _EpisodeListBuilderState extends ConsumerState<EpisodeListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.episodes.length,
        itemBuilder: (BuildContext context, int index) {
          final Episode episode = widget.episodes[index];
          return Card(
            color: backgroundColor.withOpacity(0.8),
            margin: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            elevation: 4.0,
            child: ExpansionTile(
              iconColor: primaryColor,
              title: Text(
                "${episode.number}. ${episode.name}",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CachedNetworkImage(
                  height: 70,
                  width: 60,
                  imageUrl:
                      episode.image ?? 'https://via.placeholder.com/70x60',
                ),
              ),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    30,
                    10,
                    30,
                    10,
                  ),
                  child: Center(
                    child: Text(
                      removeAllHtmlTags(episode.summary),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[200],
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    30,
                    0,
                    30,
                    10,
                  ),
                  child: const Text(
                    "_______",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
