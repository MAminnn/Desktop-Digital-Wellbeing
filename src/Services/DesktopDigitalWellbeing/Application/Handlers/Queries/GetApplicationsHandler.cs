using Application.Requests.Queries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers.Queries
{
    public class GetApplicationsHandler : IRequestHandler<GetApplicationsQuery>
    {
        public async Task<RequestResponse> Handle(GetApplicationsQuery request)
        {
            try
            {
                var applications = (await UnitOfWork.GetInstance()
                .ApplicationRepository
                .GetApplications(
                )).ResponseData;
                return new RequestResponse()
                {
                    ResponseData = applications,
                    Status = Enums.RequestStatus.Success
                };

            }
            catch (Exception e)
            {

                return new RequestResponse()
                {
                    Status = Enums.RequestStatus.Failure,
                    ErrorDescription = e.Message
                };
            }
        }
    }
}
