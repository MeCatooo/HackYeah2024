using System.Runtime.InteropServices.ComTypes;
using Microsoft.AspNetCore.Mvc;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace SigmaBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DataSectorsController : Controller
    {
        [HttpPost]
        public IActionResult PostAnkietaResults(params int[] userAnswers)
        {

            double minScore = 3500;
            double maxScore = 9800;


            double score = CalculateScore(userAnswers);
            double multiplier = CalculateMultiplier(score, minScore, maxScore);
            double finalResult = score * multiplier;
            int resultt = ResultNormaliser(finalResult);

            return Ok(resultt);
        }

        [HttpGet]
        public IActionResult TranslateToTrees(int carbon)
        {
            const int smallReduce = 3;
            const int matureReduce = 50;
            const int oldReduce = 25;

            var small = carbon / smallReduce;
            var mature = carbon / matureReduce;
            var old = carbon / oldReduce;

            return Ok(new
            {
                small,
                mature,
                old
            });
        }

        public record TreeEfficiencyResponse(int age, int carbonReduced);

        private static int ResultNormaliser(double result)
        {
            int resultInt = (int)result;
            return resultInt;
        }

        private static double CalculateScore(int[] answers)
        {

            
            double totalScore = 0;
            foreach (var answer in answers)
            {
                totalScore += answer;
            }

            return totalScore;
        }

        private static double CalculateMultiplier(double score, double minScore, double maxScore)
        {
            double maxPossibleScore = 14 * 4; 
            double normalizedScore = score / maxPossibleScore;

            double finalMultiplier = minScore + (normalizedScore * (maxScore - minScore));
            return finalMultiplier / score; 
        }
    }
}

