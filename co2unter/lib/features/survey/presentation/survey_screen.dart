import 'package:co2unter/features/home_screen/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/wide_button.dart';
import '../widgets/answer_bubble.dart';
import '../widgets/progress_bar.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Jak często korzystasz z prywatnego samochodu?',
      'options': [
        'Codziennie',
        'Kilka razy w tygodniu',
        'Kilka razy w miesiącu',
        'Rzadko lub nigdy'
      ],
    },
    {
      'question': 'Czy korzystasz z komunikacji miejskiej?',
      'options': [
        'Codziennie',
        'Kilka razy w tygodniu',
        'Kilka razy w miesiącu',
        'Rzadko lub nigdy'
      ],
    },
    {
      'question': 'Jak często korzystasz z roweru lub chodzisz pieszo?',
      'options': [
        'Codziennie',
        'Kilka razy w tygodniu',
        'Kilka razy w miesiącu',
        'Rzadko lub nigdy'
      ],
    },
  ];
  List<String?> _answers = List.filled(3, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PercentageIndicator(
                percentage: (_currentPage + 1) / _questions.length,
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _questions.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildQuestionPage(_questions[index], index);
                },
              ),
            ),
            _buildPageIndicator(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: _currentPage == _questions.length - 1
                          ? 'Zakończ ankietę'
                          : 'Dalej',
                      onPressed: _answers[_currentPage] != null
                          ? () {
                              if (_currentPage < _questions.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomeScreen(),
                                  ),
                                );
                                print('Survey completed. Answers: $_answers');
                              }
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionPage(
      Map<String, dynamic> questionData, int questionIndex) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CO₂ w Krakowie',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            questionData['question'],
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          ...questionData['options'].map<Widget>((option) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AnswerBubble(
                    text: option,
                    isSelected: _answers[questionIndex] == option,
                    onTap: () {
                      setState(() {
                        _answers[questionIndex] = option;
                      });
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_questions.length, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index
                ? Theme.of(context).primaryColor
                : Colors.grey.withOpacity(0.5),
          ),
        );
      }),
    );
  }
}
