using System.Runtime.InteropServices.ComTypes;
using Microsoft.AspNetCore.Mvc;

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
        public IActionResult PostAnkietaResults(params int[] results)
        {
            var wynik = 0;
            foreach (var result in results)
            {
                if(result == 1)
                    wynik =+ result * 500;
                else if (result == 2)
                    wynik = +result * 1000;
                else if (result == 3)
                    wynik = +result * 1500;
                else if (result == 4)
                    wynik = +result * 2500;
            }
            


            return Ok(wynik);
        }
    }
    
    public record TreeEfficiencyResponse(int age, int carbonReduced);
}
