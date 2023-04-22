using Application.DTOs;
using Application.Requests.Queries;
using Application.Mappers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers.Queries
{
    public class GetApplicationByPathHandler : IRequestHandler<GetApplicationByPathQuery, ApplicationDTO>
    {
        public async Task<RequestResponse<ApplicationDTO>> Handle(GetApplicationByPathQuery request)
        {
            try
            {
                var res = await UnitOfWork.GetInstance().ApplicationRepository.GetApplication(request.Path);

                if (res.Status == Domain.Enums.RequestStatus.Failure)
                {
                    return new RequestResponse<ApplicationDTO>(Enums.RequestStatus.Failure, new ApplicationDTO(), res.ErrorDescription);
                }

                var appDTO = MapManager.GetInstance().GetMapper().Map<ApplicationDTO>(res.ResponseData);
                return new RequestResponse<ApplicationDTO>(Enums.RequestStatus.Success, appDTO);
            }
            catch (Exception e)
            {
                return new RequestResponse<ApplicationDTO>(Enums.RequestStatus.Failure, new ApplicationDTO(), e.Message);
            }
        }
    }
}
