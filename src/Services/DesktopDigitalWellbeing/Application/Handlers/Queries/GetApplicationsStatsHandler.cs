using Application.DTOs;
using Application.Mappers;
using Application.Requests.Queries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers.Queries
{
    public class GetApplicationsStatsHandler : IRequestHandler<GetApplicationsStatsQuery, IEnumerable<ApplicationStatDTO>>
    {
        public async Task<RequestResponse<IEnumerable<ApplicationStatDTO>>> Handle(GetApplicationsStatsQuery request)
        {
            try
            {
                var res = await UnitOfWork.GetInstance()
                .ApplicationStatRepository
                .GetApplicationsStats(
                );

                if (res.Status == Domain.Enums.RequestStatus.Failure)
                {
                    return new RequestResponse<IEnumerable<ApplicationStatDTO>>(Enums.RequestStatus.Failure, new List<ApplicationStatDTO>(), res.ErrorDescription);
                }

                var applicationsStats = MapManager.GetInstance().GetMapper().Map<IEnumerable<ApplicationStatDTO>>(res.ResponseData);
                return new RequestResponse<IEnumerable<ApplicationStatDTO>>(Enums.RequestStatus.Success, applicationsStats);

            }
            catch (Exception e)
            {

                return new RequestResponse<IEnumerable<ApplicationStatDTO>>(Enums.RequestStatus.Success, new List<ApplicationStatDTO>(), e.Message);
            }
        }
    }
}
