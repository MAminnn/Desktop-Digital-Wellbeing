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
    public class GetApplicationsHandler : IRequestHandler<GetApplicationsQuery, IEnumerable<ApplicationDTO>>
    {
        public async Task<RequestResponse<IEnumerable<ApplicationDTO>>> Handle(GetApplicationsQuery request)
        {
            try
            {
                var res = await UnitOfWork.GetInstance()
                .ApplicationRepository
                .GetApplications(
                );

                if (res.Status == Domain.Enums.RequestStatus.Failure)
                {
                    return new RequestResponse<IEnumerable<ApplicationDTO>>(Enums.RequestStatus.Failure, new List<ApplicationDTO>(), res.ErrorDescription);
                }

                var applications = MapManager.GetInstance().GetMapper().Map<IEnumerable<ApplicationDTO>>(res.ResponseData);
                return new RequestResponse<IEnumerable<ApplicationDTO>>(Enums.RequestStatus.Success, applications);

            }
            catch (Exception e)
            {

                return new RequestResponse<IEnumerable<ApplicationDTO>>(Enums.RequestStatus.Success, new List<ApplicationDTO>(), e.Message);
            }
        }
    }
}
