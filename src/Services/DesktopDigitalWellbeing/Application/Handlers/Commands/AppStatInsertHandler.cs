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
                await UnitOfWork.GetInstance()
                .ApplicationStatRepository
                .AddApplicationState(
                new Domain.POCOs.Entities.Application() { ID = cmd.applicationId },
                new Day() { DateTime = cmd.dayDate }
                );
                return new RequestResponse()
                {
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
