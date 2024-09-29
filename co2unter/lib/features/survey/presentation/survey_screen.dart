import 'package:co2unter/features/home_screen/presentation/home_screen.dart';
import 'package:co2unter/features/survey/presentation/question.dart';
import 'package:co2unter/features/user_profile/widgets/tree_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/widgets/wide_button.dart';
import '../widgets/answer_bubble.dart';
import '../widgets/progress_bar.dart';
import 'package:collection/collection.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Question> _questions = [
  Question(
    'Jak często korzystasz z samochodu?',
    [
      'Nigdy',
      'Raz w tygodniu',
      'Kilka razy w tygodniu',
      'Codziennie'
    ],
  ),
  Question(
    'Jakie jest główne źródło energii w domu?',
    [
      'Energia odnawialna',
      'Energia elektryczna',
      'Gaz ziemny',
      'Węgiel, olej opałowy'
    ],
  ),
  Question(
    'Jak często podróżujesz samolotem?',
    [
      'Nigdy',
      'Raz w roku',
      '2-3 razy w roku',
      'Więcej niż 4 razy w roku'
    ],
  ),
  Question(
    'Jakie jest Twoje podejście do zakupu ubrań?',
    [
      'Kupuję tylko z drugiej ręki',
      'Kupuję kilka razy w roku',
      'Kupuję co miesiąc',
      'Kupuję nowe co tydzień'
    ],
  ),
  Question(
    'Jak ogrzewasz swój dom/mieszkanie?',
    [
      'Nie ogrzewam – oszczędzam energię',
      'Ogrzewanie gazowe',
      'Ogrzewanie elektryczne',
      'Ogrzewanie węglowe'
    ],
  ),
  Question(
    'Jak często jadasz mięso?',
    [
      'Nigdy',
      'Kilka razy w miesiącu',
      'Kilka razy w tygodniu',
      'Codziennie'
    ],
  ),
  Question(
    'Jakie są Twoje środki transportu?',
    [
      'Rower lub pieszo',
      'Komunikacja publiczna',
      'Skuter/motocykl',
      'Samochód'
    ],
  ),
  Question(
    'Jakie produkty spożywcze najczęściej wybierasz?',
    [
      'Lokalne, produkty roślinne',
      'Produkty roślinne',
      'Lokalne produkty zwierzęce',
      'Produkty pochodzenia zwierzęcego'
    ],
  ),
  Question(
    'Jak często korzystasz z transportu publicznego?',
    [
      'Codziennie',
      'Kilka razy w tygodniu',
      'Kilka razy w miesiącu',
      'Rzadko lub nigdy'
    ],
  ),
  Question(
    'Jak często wymieniasz urządzenia elektroniczne?',
    [
      'Co 5 lat lub rzadziej',
      'Co 3-4 lata',
      'Co 2-3 lata',
      'Co roku lub częściej'
    ],
  ),
  Question(
    'Jak zarządzasz odpadami?',
    [
      'Kompostuję i segreguję wszystko',
      'Segreguję większość odpadów',
      'Segreguję sporadycznie',
      'Nie segreguję śmieci'
    ],
  ),
  Question(
    'Jakie produkty wybierasz do sprzątania?',
    [
      'Naturalne środki',
      'Produkty ekologiczne',
      'Środki czystości w niewielkich ilościach',
      'Zwykłe chemiczne środki czystości'
    ],
  ),
  Question(
    'Jak często używasz jednorazowych produktów?',
    [
      'Nigdy',
      'Kilka razy w roku',
      'Kilka razy w miesiącu',
      'Codziennie'
    ],
  ),
  Question(
    'Jakie jest Twoje podejście do recyklingu?',
    [
      'Recyklinguję wszystko, co tylko mogę',
      'Recyklinguję większość rzeczy',
      'Rzadko recyklinguję',
      'Nigdy nie recyklinguję'
    ],
  ),
];

  
  final List<int> _answers = List.filled(14, 0);

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
                  return _buildQuestionPage(_questions, index);
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
                      onPressed: _answers[_currentPage] != 0
                          ? () {
                              if (_currentPage < _questions.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                double aiContent = AiPoweratedGenerajtedPercentajel(AiPoweredAlgorithmWithAi(_answers));
                                SharedPreferences.getInstance().then((x) async{
                                  // await x.remove('results'); 
                                  await x.setDouble('results', aiContent);});
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
      List<Question> questionData, int questionIndex) {
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
            questionData[questionIndex].text,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          ...questionData[questionIndex].options.mapIndexed<Widget>((i, option) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AnswerBubble(
                    text: option,
                    isSelected: _answers[questionIndex] == i + 1,
                    onTap: () {
                      setState(() {
                        _answers[questionIndex] = i + 1;
                      });
                    },
                  ),
                ),
              ),
            );
          }),
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

  double AiPoweredAlgorithmWithAi(List<int> params){
    int minScore = 3500;
    int maxScore = 9800;
    int score = params.sum;


    double maxPossibleScore = 14 * 4; 
    double normalizedScore = score / maxPossibleScore;

    double multiplier = minScore + (normalizedScore * (maxScore - minScore));
    double finalMultiplier = multiplier / score;
    return score * finalMultiplier;
  }

  double AiPoweratedGenerajtedPercentajel(double score){
    int averagePolak = 7100;
    double result = double.parse((score / averagePolak).toStringAsFixed(2)) * 100;
    return result; 
  }
}
