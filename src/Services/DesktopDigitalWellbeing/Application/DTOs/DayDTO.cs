using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.DTOs
{
    public class DayDTO
    {
        public DateTime DateTime { get; set; }
        public List<ApplicationStatDTO> ApplicationsStats { get; set; }

        public DayDTO()
        {
            ApplicationsStats = new List<ApplicationStatDTO>();
        }

    }
}
