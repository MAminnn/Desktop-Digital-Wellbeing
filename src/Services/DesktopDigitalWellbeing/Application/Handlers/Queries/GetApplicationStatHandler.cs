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
    public class GetApplicationStatHandler : IRequestHandler<GetApplicationStatQuery, ApplicationStatDTO>
    {
        public async Task<RequestResponse<ApplicationStatDTO>> Handle(GetApplicationStatQuery request)
        {
            try
            {
                var res = await UnitOfWork.GetInstance()
                .ApplicationStatRepository
                .GetApplicationStat(request.ApplicationId, request.DayDate
                );

                if (res.Status == Domain.Enums.RequestStatus.Failure)
                {
                    return new RequestResponse<ApplicationStatDTO>(Enums.RequestStatus.Failure, new ApplicationStatDTO(), res.ErrorDescription);
                }

                var appStat = MapManager.GetInstance().GetMapper().Map<ApplicationStatDTO>(res.ResponseData);
                return new RequestResponse<ApplicationStatDTO>(Enums.RequestStatus.Success, appStat);

            }
            catch (Exception e)
            {

                return new RequestResponse<ApplicationStatDTO>(Enums.RequestStatus.Success, new ApplicationStatDTO(), e.Message);
            }
        }
    }
}
