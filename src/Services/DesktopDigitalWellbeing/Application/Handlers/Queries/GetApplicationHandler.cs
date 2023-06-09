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
    public class GetApplicationHandler : IRequestHandler<GetApplicationQuery, ApplicationDTO>
    {
        public async Task<RequestResponse<ApplicationDTO>> Handle(GetApplicationQuery request)
        {
            try
            {
                var res = await UnitOfWork.GetInstance()
                .ApplicationRepository
                .GetApplication(request.ApplicationId
                );

                if (res.Status == Domain.Enums.RequestStatus.Failure)
                {
                    return new RequestResponse<ApplicationDTO>(Enums.RequestStatus.Failure, new ApplicationDTO(), res.ErrorDescription);
                }

                var application = MapManager.GetInstance().GetMapper().Map<ApplicationDTO>(res.ResponseData);

                return new RequestResponse<ApplicationDTO>(Enums.RequestStatus.Success, application);

            }
            catch (Exception e)
            {

                return new RequestResponse<ApplicationDTO>(Enums.RequestStatus.Failure, new ApplicationDTO(), e.Message);
            }
        }
    }
}
