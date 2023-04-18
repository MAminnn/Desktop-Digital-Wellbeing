using Application.Requests.Commands;
using Domain.POCOs.Entities;
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
                await UnitOfWork.GetInstance()
                .DayRepository
                .AddDay(new Day() { DateTime = request.dayDate });

                return new RequestResponse() { Status = Enums.RequestStatus.Success };

            }
            catch (Exception e)
            {

                return new RequestResponse() { Status = Enums.RequestStatus.Failure, ErrorDescription = e.Message };
            }
        }
    }
}
