using Application.Requests.Commands;
using Application.Enums;
using Domain.Enums;
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
                var res = await UnitOfWork.GetInstance()
                .ApplicationRepository
                .AddApplication(request.Path);

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
