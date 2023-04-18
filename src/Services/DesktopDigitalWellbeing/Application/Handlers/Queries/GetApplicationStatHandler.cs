using Application.Requests.Queries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers.Queries
{
    public class GetApplicationStatHandler : IRequestHandler<GetApplicationStatQuery>
    {
        public async Task<RequestResponse> Handle(GetApplicationStatQuery request)
        {
            try
            {
                var appStat = (await UnitOfWork.GetInstance()
                .ApplicationStatRepository
                .GetApplicationStat(request.applicationId,request.DayDate
                )).ResponseData;
                return new RequestResponse()
                {
                    ResponseData = appStat,
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
