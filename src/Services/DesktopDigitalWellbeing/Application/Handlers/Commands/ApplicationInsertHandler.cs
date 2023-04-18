using Application.Requests.Commands;
using Domain.POCOs.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers.Commands
{
    public class ApplicationInsertHandler : IRequestHandler<ApplicationInsertCommand>
    {
        public async Task<RequestResponse> Handle(ApplicationInsertCommand request)
        {
			try
			{
                await UnitOfWork.GetInstance()
                .ApplicationRepository
                .AddApplication(new Domain.POCOs.Entities.Application() { Path = request.path });

                return new RequestResponse() { Status=Enums.RequestStatus.Success };

            }
            catch (Exception e)
			{

                return new RequestResponse() { Status = Enums.RequestStatus.Failure , ErrorDescription = e.Message};
            }

        }
    }
}
