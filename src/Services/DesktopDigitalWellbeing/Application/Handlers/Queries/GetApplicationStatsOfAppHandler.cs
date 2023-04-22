﻿using Application.DTOs;
using Application.Mappers;
using Application.Requests.Queries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers.Queries
{
    public class GetApplicationStatsOfAppHandler : IRequestHandler<GetApplicationStatsOfAppQuery, IEnumerable<ApplicationStatDTO>>
    {
        public async Task<RequestResponse<IEnumerable<ApplicationStatDTO>>> Handle(GetApplicationStatsOfAppQuery request)
        {
            try
            {
                var res = await UnitOfWork.GetInstance()
                .ApplicationStatRepository
                .GetApplicationStatsOfApp(request.ApplicationId
                );

                if (res.Status == Domain.Enums.RequestStatus.Failure)
                {
                    return new RequestResponse<IEnumerable<ApplicationStatDTO>>(Enums.RequestStatus.Failure, new List<ApplicationStatDTO>(), res.ErrorDescription);
                }
                var appStats = MapManager.GetInstance().GetMapper().Map<IEnumerable<ApplicationStatDTO>>(res.ResponseData);
                return new RequestResponse<IEnumerable<ApplicationStatDTO>>(Enums.RequestStatus.Success, appStats);

            }
            catch (Exception e)
            {

                return new RequestResponse<IEnumerable<ApplicationStatDTO>>(Enums.RequestStatus.Failure, new List<ApplicationStatDTO>(), e.Message);
            }
        }
    }
}
