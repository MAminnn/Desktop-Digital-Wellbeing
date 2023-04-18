using Domain.Interfaces.Repositories;
using Domain.POCOs;
using Domain.POCOs.Entities;
using Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using System;

namespace Infrastructure.Implementations
{
    public class ApplicationStatRepository : IApplicationStatRepository
    {
        private readonly DWDbContext _context;
        public ApplicationStatRepository()
        {
            _context = DbContextManager.GetContext();
        }
        
        
        public async Task<RequestResponse> AddApplicationState(Application app, Day day)
        {
            try
            {
                var appStat = new ApplicationStat()
                {
                    Application = app,
                    ApplicationId = app.ID,
                    Day = day,
                    DayDate = day.DateTime,
                    UsedTime = TimeSpan.Zero
                };
                await _context.AddAsync<ApplicationStat>(appStat);
                return new RequestResponse()
                {
                    Status = Domain.Enums.RequestStatus.Success
                };
            }
            catch (Exception e)
            {
                return new RequestResponse()
                {
                    Status = Domain.Enums.RequestStatus.Failure,
                    ErrorDescription = e.Message,
                };
            }
        }
        
        public async Task<RequestResponse> GetApplicationStat(Guid applicationId, DateTime dayDate)
        {
            try
            {
                var res = await _context.FindAsync<ApplicationStat>(new { ApplicationId = applicationId, DayDate = dayDate });
                return new RequestResponse()
                {
                    Status = Domain.Enums.RequestStatus.Success,
                    ResponseData = res
                };
            }
            catch (Exception e)
            {
                return new RequestResponse()
                {
                    Status = Domain.Enums.RequestStatus.Failure,
                    ErrorDescription = e.Message,
                };
            }
        }

        public async Task<RequestResponse> GetApplicationsStats()
        {
            try
            {
                var appsStats = await _context.ApplicationStats.ToListAsync();
                return new RequestResponse()
                {
                    ResponseData = appsStats,
                    Status = Domain.Enums.RequestStatus.Success
                };
            }
            catch (Exception e)
            {

                return new RequestResponse()
                {
                    ErrorDescription = e.Message,
                    Status = Domain.Enums.RequestStatus.Failure
                };
            }
        }

        public async Task<RequestResponse> GetApplicationStatsOfApp(Guid applicationId)
        {
            try
            {
                var appsStats = await _context.ApplicationStats.Where(appstat => appstat.ApplicationId == applicationId).ToListAsync();
                return new RequestResponse()
                {
                    ResponseData = appsStats,
                    Status = Domain.Enums.RequestStatus.Success
                };
            }
            catch (Exception e)
            {

                return new RequestResponse()
                {
                    ErrorDescription = e.Message,
                    Status = Domain.Enums.RequestStatus.Failure
                };
            }
        }

        public async Task<RequestResponse> GetApplicationStatsOfDay(DateTime dayDate)
        {
            try
            {
                var appsStats = await _context.ApplicationStats.Where(appstat => appstat.DayDate == dayDate).ToListAsync();
                return new RequestResponse()
                {
                    ResponseData = appsStats,
                    Status = Domain.Enums.RequestStatus.Success
                };
            }
            catch (Exception e)
            {

                return new RequestResponse()
                {
                    ErrorDescription = e.Message,
                    Status = Domain.Enums.RequestStatus.Failure
                };
            }
        }
        
        public async Task<RequestResponse> UpdateTimeStat(ApplicationStat appstat, TimeSpan usedTime)
        {
            return await Task.Run(() =>
            {
                try
                {
                    appstat.UsedTime = usedTime;
                    _context.Update<ApplicationStat>(appstat);
                    return new RequestResponse()
                    {
                        Status = Domain.Enums.RequestStatus.Success
                    };
                }
                catch (Exception e)
                {
                    return new RequestResponse()
                    {
                        Status = Domain.Enums.RequestStatus.Failure,
                        ErrorDescription = e.Message,
                    };
                }

            });
        }
        
        public async Task<RequestResponse> UpdateTimeStat(Guid applicationId, DateTime dayDate, TimeSpan usedTime)
        {
            try
            {
                var appstat = (await GetApplicationStat(applicationId, dayDate)).ResponseData as ApplicationStat;

                if (appstat != null)
                {
                    appstat.UsedTime = usedTime;
                    _context.Update<ApplicationStat>(appstat);
                    return new RequestResponse()
                    {
                        Status = Domain.Enums.RequestStatus.Success
                    };
                }

                return new RequestResponse()
                {
                    Status = Domain.Enums.RequestStatus.Failure,
                    ErrorDescription = "Object was NULL",
                };

            }
            catch (Exception e)
            {
                return new RequestResponse()
                {
                    Status = Domain.Enums.RequestStatus.Failure,
                    ErrorDescription = e.Message,
                };
            }
        }
    }
}
