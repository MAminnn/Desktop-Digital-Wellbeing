using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Domain.POCOs;
using Domain.POCOs.Entities;

namespace Domain.Interfaces.Repositories
{
    public interface IApplicationStatRepository
    {
        Task<RequestResponse> UpdateTimeStat(ApplicationStat appstat, TimeSpan usedTime);
        Task<RequestResponse> AddApplicationState(Application app, Day day);
        Task<RequestResponse<ApplicationStat>> GetApplicationStat(Guid applicationId, DateTime dayDate);
        Task<RequestResponse<IEnumerable<ApplicationStat>>> GetApplicationsStats();
        Task<RequestResponse<IEnumerable<ApplicationStat>>> GetApplicationStatsOfApp(Guid applicationId);
        Task<RequestResponse<IEnumerable<ApplicationStat>>> GetApplicationStatsOfDay(DateTime dayDate);
    }
}
