import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_jobsity/core/design_system/colors.dart';
import 'package:test_jobsity/features/show_details/data/models/season.dart';

import 'episode_list_builder.dart';

class SeasonsListBuilder extends ConsumerStatefulWidget {
  const SeasonsListBuilder({super.key, required this.seasons});

  final List<Season> seasons;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SeasonsListBuilderState();
}

class _SeasonsListBuilderState extends ConsumerState<SeasonsListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.seasons.length,
      itemBuilder: (BuildContext context, int index) {
        final Season season = widget.seasons[index];
        return Card(
          color: Colors.white12,
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          child: ExpansionTile(
            iconColor: primaryColor,
            title: Text(
              "SEASON ${season.number}",
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white),
            ),
            leading: const Icon(
              Icons.tv,
              color: primaryColor,
            ),
            children: <Widget>[
              EpisodeListBuilder(
                episodes: season.episodes,
              )
            ],
          ),
        );
      },
    );
  }
}
