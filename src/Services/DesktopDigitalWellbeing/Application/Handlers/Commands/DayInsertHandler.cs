using Application.Requests.Commands;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers.Commands
{
    public class DayInsertHandler : IRequestHandler<DayInsertCommand>
    {
        public async Task<RequestResponse> Handle(DayInsertCommand request)
        {
            try
            {
                var res = await UnitOfWork.GetInstance()
                .DayRepository
                .AddDay(request.DayDate);

                if (res.Status == Domain.Enums.RequestStatus.Failure)
                {
                    return new RequestResponse(Enums.RequestStatus.Failure, res.ErrorDescription);
                }

                return new RequestResponse(Enums.RequestStatus.Success);

            }
            catch (Exception e)
            {

                return new RequestResponse(Application.Enums.RequestStatus.Failure, e.Message);
            }
        }
    }
}
