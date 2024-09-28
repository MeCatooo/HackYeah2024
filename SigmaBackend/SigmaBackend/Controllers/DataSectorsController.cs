using System.Runtime.InteropServices.ComTypes;
using Microsoft.AspNetCore.Mvc;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace SigmaBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DataSectorsController : Controller
    {

        [HttpGet]
        public IActionResult GetTreesEfficiency()
        {
            return Ok(new List<TreeEfficiencyResponse>()
            {
                new(1, 3),
                new(25, 25),
                new(50, 50),
                new(100, 25)
            });
        }

        [HttpPost]
        public IActionResult PostAnkietaResults(params int[] userAnswers)
        {

            double minScore = 6000;
            double maxScore = 11000;


            double score = CalculateScore(userAnswers);
            double multiplier = CalculateMultiplier(score, minScore, maxScore);
            double finalResult = score * multiplier;
            int resultt = ResultNormaliser(finalResult);

            return Ok(resultt);
        }



        public record TreeEfficiencyResponse(int age, int carbonReduced);

        public static int ResultNormaliser(double result)
        {
            int resultInt = (int)result;
            //if (resultInt % 100 == 0) 
            //{
            //    Random random = new Random();
            //    int randomValue = random.Next(0, 100); 
            //    return (resultInt / 100) * 100 + randomValue; 

            //}
            return resultInt;
        }

        public static double CalculateScore(int[] answers)
        {
            // Sprawdź, czy liczba odpowiedzi jest zgodna z oczekiwaną
            if (answers.Length != 14)
            {
                throw new ArgumentException("Oczekiwano 14 odpowiedzi.");
            }

            // Oblicz całkowity wynik
            double totalScore = 0;
            foreach (var answer in answers)
            {
                totalScore += answer;
            }

            return totalScore;
        }

        public static double CalculateMultiplier(double score, double minScore, double maxScore)
        {
            double maxPossibleScore = 14 * 4; // Maksymalny możliwy wynik
            double normalizedScore = score / maxPossibleScore; // Normalizacja wyniku (0-1)

            // Przeskaluj do przedziału 7000-11000
            double finalMultiplier = minScore + (normalizedScore * (maxScore - minScore));
            return finalMultiplier / score; // Zwróć mnożnik
        }
    }
}

