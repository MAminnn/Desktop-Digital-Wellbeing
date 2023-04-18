using Application.Requests.Queries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers.Queries
{
    public class GetDayHandler : IRequestHandler<GetDayQuery>
    {
        public async Task<RequestResponse> Handle(GetDayQuery request)
        {
            try
            {
                var appStats = (await UnitOfWork.GetInstance()
                .DayRepository
                .GetDay(request.dayDate
                )).ResponseData;
                return new RequestResponse()
                {
                    ResponseData = appStats,
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
