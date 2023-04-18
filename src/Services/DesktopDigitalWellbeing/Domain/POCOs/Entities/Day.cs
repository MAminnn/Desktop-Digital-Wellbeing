using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.POCOs.Entities
{
    public class Day
    {
        private DateTime _dateTime;

        public DateTime DateTime { get => _dateTime; set => _dateTime = value; }
        public List<ApplicationStat> ApplicationsStats { get; set; }


        public Day()
        {
            ApplicationsStats = new List<ApplicationStat>();
        }

    }
}
