using Application.Requests.Commands;

namespace Application.Handlers.Commands
{
    public class AppStatUpdateTimeHandler : IRequestHandler<AppStatUpdateTimeCommand>
    {
        public async Task<RequestResponse> Handle(AppStatUpdateTimeCommand request)
        {

            try
            {
                await UnitOfWork.GetInstance()
                .ApplicationStatRepository
                .UpdateTimeStat(request.applicationId, request.dayDate, request.usedTime
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
