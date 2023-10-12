import 'package:weather/models/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:weather/views/widgets/suggestion_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SuggestionsWidget extends StatelessWidget {
  const SuggestionsWidget({
    super.key,
    required this.suggestions,
  });

  final List<Suggestion> suggestions;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            SizedBox(
              height: 72,
              width: double.infinity,
              child: PageView(
                controller: controller,
                children: [
                  for (int i = 0; i < suggestions.length; i++) ...[
                    SuggestionItem(
                        title: suggestions[i].title,
                        subtitle: suggestions[i].subTitle)
                  ]
                  //   SuggestionItem(
                  //       title: "Enjoy the day outdoors",
                  //       subtitle: "The sky is clear"),
                  // SuggestionItem(
                  //   title: "Text 2",
                  //   subtitle: "text 2",
                  // ),
                  // SuggestionItem(
                  //   title: "Text 3",
                  //   subtitle: "text 3",
                  // ),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: suggestions.length,
              effect: const WormEffect(
                dotHeight: 6,
                dotWidth: 6,
                dotColor: Colors.white60,
                activeDotColor: Colors.white70,
                paintStyle: PaintingStyle.stroke,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
