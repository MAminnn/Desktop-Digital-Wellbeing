using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.DTOs
{
    public class ApplicationStatDTO
    {
        public ApplicationDTO? Application { get; set; }
        public Guid ApplicationId { get; set; }
        public DayDTO? Day { get; set; }
        public DateTime DayDate { get; set; }
        public TimeSpan UsedTime { get; set; }
    }
}
