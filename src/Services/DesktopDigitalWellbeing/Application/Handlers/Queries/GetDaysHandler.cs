using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers.Queries
{
    public class GetDaysHandler : IRequestHandler<GetDaysHandler>
    {
        public async Task<RequestResponse> Handle(GetDaysHandler request)
        {
            try
            {
                var appStats = (await UnitOfWork.GetInstance()
                .DayRepository
                .GetDays(
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
