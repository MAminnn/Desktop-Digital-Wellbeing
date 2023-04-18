using Application.Requests.Queries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers.Queries
{
    public class GetApplicationHandler : IRequestHandler<GetApplicationQuery>
    {
        public async Task<RequestResponse> Handle(GetApplicationQuery request)
        {
            try
            {
                var application = (await UnitOfWork.GetInstance()
                .ApplicationRepository
                .GetApplication(request.applicationId
                )).ResponseData;
                return new RequestResponse()
                {
                    ResponseData = application,
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
