using Application.Requests.Queries;
using Application.Requests.Commands;
using System.Diagnostics;
using WorkerService.POCOs;
using Application.DTOs;
using Application;
using Application.Enums;

namespace WorkerService
{
    public class Worker : BackgroundService
    {
        private readonly ILogger<Worker> _logger;
        private static List<ApplicationDTO> _applications = new List<ApplicationDTO>();
        private static DayDTO _today;
        private DateTime _lastModified;

        public Worker(ILogger<Worker> logger)
        {
            _logger = logger;
            _lastModified = DateTime.Now;
            CheckDay();
        }

        private async void CheckDay()
        {
            var getDayQuery = new GetDayParallelQuery(DateTime.Today, true);
            var res = await Mediator.GetInstance().HandleQuery<GetDayParallelQuery, DayDTO>(getDayQuery);
            if (res.Status == RequestStatus.Failure)
            {
                if (res.ErrorDescription == "Day Not Found")
                {
                    var insertDayCMD = new DayInsertParallelCommand(DateTime.Today);
                    await Mediator.GetInstance().HandleCommand<DayInsertParallelCommand>(insertDayCMD);
                    res = await Mediator.GetInstance().HandleQuery<GetDayParallelQuery, DayDTO>(getDayQuery);
                }
            }
            _today = res.ResponseData;

            await Task.Run(() =>
            {

                DateTime now = DateTime.Now;
                DateTime twelveAfterNoon = new DateTime(now.Year, now.Month, now.Day + 1, 0, 0, 0);
                int delay = (int)(twelveAfterNoon - now).TotalMilliseconds;
                Thread.Sleep(delay);
                CheckDay();

            });
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    string openAppPath = OpenWindowsGetter.GetActiveProcessFileName();
                    if ((DateTime.Now - _lastModified).TotalSeconds > 3)
                    {
                        CheckDay();
                    }
                    Guid? appId = _applications.FirstOrDefault(a => a.Path == openAppPath)?.Id;
                    if (appId is null)
                    {
                        var getAppQuery = new GetApplicationByPathQuery(openAppPath);
                        var response = await Mediator.GetInstance().HandleQuery<GetApplicationByPathQuery, ApplicationDTO>(getAppQuery);
                        if (response.Status == Application.Enums.RequestStatus.Failure)
                        {
                            if (response.ErrorDescription == "Application Not Found")
                            {
                                var insertAppCMD = new ApplicationInsertCommand(openAppPath);
                                await Mediator.GetInstance().HandleCommand(insertAppCMD);
                                response = await Mediator.GetInstance().HandleQuery<GetApplicationByPathQuery, ApplicationDTO>(getAppQuery);
                            }
                        }

                        ApplicationDTO app = (response.ResponseData as ApplicationDTO)!;
                        _applications.Add(app);
                        appId = app.Id;
                    }

                    if (!_today.ApplicationsStats.Any(aps => aps.ApplicationId == appId))
                    {
                        var appstatInsertCMD = new AppStatInsertCommand(appId!.Value, _today.DateTime);
                        var res = await Mediator.GetInstance().HandleCommand<AppStatInsertCommand>(appstatInsertCMD);

                        if (res.Status == Application.Enums.RequestStatus.Failure)
                        {

                        }

                        var appstatQuery = new GetApplicationStatQuery(appId!.Value, _today.DateTime);
                        var appstat = (await Mediator.GetInstance().HandleQuery<GetApplicationStatQuery, ApplicationStatDTO>(appstatQuery)).ResponseData;

                        _today.ApplicationsStats.Add(appstat);
                    }


                    var updateAppStatCMD = new AppStatUpdateTimeCommand(appId!.Value, _today.DateTime, TimeSpan.FromSeconds(1));
                    var updateRes = await Mediator.GetInstance().HandleCommand(updateAppStatCMD);

                    if (updateRes.Status == RequestStatus.Success)
                    {
                        _lastModified = DateTime.Now;
                    }
                }
                catch (Exception e)
                {
                    _logger.LogError(e.Message);
                }

                await Task.Delay(1000, stoppingToken);
            }
        }
    }
}