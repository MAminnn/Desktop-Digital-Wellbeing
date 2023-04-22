using Application.DTOs;
using Application.Mappers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers.Queries
{
    public class GetDaysHandler : IRequestHandler<GetDaysHandler, IEnumerable<DayDTO>>
    {

        public async Task<RequestResponse<IEnumerable<DayDTO>>> Handle(GetDaysHandler request)
        {
            try
            {
                var res = await UnitOfWork.GetInstance()
                .DayRepository
                .GetDays(
                );

                if (res.Status == Domain.Enums.RequestStatus.Failure)
                {
                    return new RequestResponse<IEnumerable<DayDTO>>(Enums.RequestStatus.Failure, new List<DayDTO>(), res.ErrorDescription);
                }

                var days = MapManager.GetInstance().GetMapper().Map<IEnumerable<DayDTO>>(res.ResponseData);
                return new RequestResponse<IEnumerable<DayDTO>>(Enums.RequestStatus.Success, days);

            }
            catch (Exception e)
            {

                return new RequestResponse<IEnumerable<DayDTO>>(Enums.RequestStatus.Failure, new List<DayDTO>(), e.Message);
            }
        }
    }
}
