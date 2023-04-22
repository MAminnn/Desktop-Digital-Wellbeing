using Application.Requests.Commands;

namespace Application.Handlers.Commands
{
    public class AppStatUpdateTimeHandler : IRequestHandler<AppStatUpdateTimeCommand>
    {
        public async Task<RequestResponse> Handle(AppStatUpdateTimeCommand request)
        {

            try
            {
                var res = await UnitOfWork.GetInstance()
                .ApplicationStatRepository
                .UpdateTimeStat(request.ApplicationId, request.DayDate, request.IncreaseValue
                );

                if (res.Status == Domain.Enums.RequestStatus.Failure)
                {
                    return new RequestResponse(Enums.RequestStatus.Success, res.ErrorDescription);
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
