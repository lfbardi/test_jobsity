import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_jobsity/core/design_system/colors.dart';
import 'package:test_jobsity/core/design_system/text_styles.dart';
import 'package:test_jobsity/features/show_details/presentation/store/show_details_state.dart';

import '../../../../core/utils/remove_html_tags_from_string.dart';
import '../store/show_details_store.dart';
import 'widgets/seasons_list_builder.dart';

class ShowDetailsPage extends ConsumerStatefulWidget {
  const ShowDetailsPage({super.key, required this.showId});

  final int showId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShowDetailsPageState();
}

class _ShowDetailsPageState extends ConsumerState<ShowDetailsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final store = ref.read(showDetailsStoreProvider.notifier);
      store.getShowDetails(id: widget.showId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(showDetailsStoreProvider);
    final store = ref.read(showDetailsStoreProvider.notifier);

    if (state is LoadingShowDetailsState) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is SuccessShowDetailsState) {
      return Material(
        child: SafeArea(
          child: Container(
            color: backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: primaryColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        state.show?.name ?? '',
                        style: title,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: state.show!.image ??
                                  'https://via.placeholder.com/140x200',
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Schedule',
                              style: title.copyWith(color: primaryColor),
                            ),
                            Text(
                              'Days: ${state.show!.schedule?.days?.join('\n')}\nTime: ${state.show!.schedule?.time}',
                              style: title.copyWith(fontSize: 12),
                            ),
                            Text(
                              'No network',
                              style: title.copyWith(fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Genres',
                              style: title.copyWith(color: primaryColor),
                            ),
                            Text(
                              state.show!.genres?.join('\n') ?? 'No genres',
                              style: title.copyWith(fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Summary',
                        style: title.copyWith(color: primaryColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      removeAllHtmlTags(state.show!.summary ?? 'No summary'),
                      style: title.copyWith(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SeasonsListBuilder(seasons: state.seasons!),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      );
    } else if (state is ErrorShowDetailsState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                state.errorMessage,
                style:
                    title.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              onPressed: () => store.getShowDetails(id: widget.showId),
              child: Text('Try again', style: whiteTitle),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
