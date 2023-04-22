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
    public class GetDayHandler : IRequestHandler<GetDayQuery, DayDTO>
    {
        public async Task<RequestResponse<DayDTO>> Handle(GetDayQuery request)
        {
            try
            {
                var res = await UnitOfWork.GetInstance()
                .DayRepository
                .GetDay(request.DayDate, request.IncludeAppStats
                );

                if (res.Status == Domain.Enums.RequestStatus.Failure)
                {
                    return new RequestResponse<DayDTO>(Enums.RequestStatus.Failure, new DayDTO(), res.ErrorDescription);
                }

                var day = MapManager.GetInstance().GetMapper().Map<DayDTO>(res.ResponseData);

                return new RequestResponse<DayDTO>(Enums.RequestStatus.Success, day);

            }
            catch (Exception e)
            {

                return new RequestResponse<DayDTO>(Enums.RequestStatus.Failure, new DayDTO(), e.Message);
            }
        }
    }
}
