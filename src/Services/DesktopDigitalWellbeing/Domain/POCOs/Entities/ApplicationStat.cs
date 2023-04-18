using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.POCOs.Entities
{
    public class ApplicationStat
    {
        private Application? _application;
        private Guid _appId;
        private Day _day;
        private DateTime _dayDate;
        private TimeSpan _usedTime;


        public Application? Application { get => _application; set => _application = value; }
        public Guid ApplicationId { get => _appId; set => _appId = value; }
        public Day Day { get => _day; set => _day = value; }
        public DateTime DayDate { get; set; }
        public TimeSpan UsedTime { get => _usedTime; set => _usedTime = value; }


        public ApplicationStat()
        {

        }
    }
}
