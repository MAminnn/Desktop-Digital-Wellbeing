using Application.Requests.Commands;
using Domain.POCOs.Entities;
using Domain;
using Domain.POCOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace Application.Handlers.Commands
{
    public class AppStatInsertHandler : IRequestHandler<AppStatInsertCommand>
    {
        public async Task<RequestResponse> Handle(AppStatInsertCommand cmd)
        {
            try
            {
                var application = (await UnitOfWork.GetInstance().ApplicationRepository.GetApplication(cmd.ApplicationId)).ResponseData;
                var day = (await UnitOfWork.GetInstance().DayRepository.GetDay(cmd.DayDate, false)).ResponseData;
                var res = await UnitOfWork.GetInstance()
                .ApplicationStatRepository
                .AddApplicationState(
                application, day
                );

                if (res.Status == Domain.Enums.RequestStatus.Failure)
                {
                    return new RequestResponse(Enums.RequestStatus.Failure, res.ErrorDescription);
                }

                return new RequestResponse(Enums.RequestStatus.Success);

            }
            catch (Exception e)
            {

                return new RequestResponse(Enums.RequestStatus.Failure, e.Message);
            }
        }
    }
}
