using Domain.Interfaces.Repositories;
using Domain.POCOs;
using Domain.Enums;
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
                await _context.SaveChangesAsync();
                return new RequestResponse(RequestStatus.Success);
            }
            catch (Exception e)
            {
                return new RequestResponse(RequestStatus.Failure, e.Message);
            }
        }

        public async Task<RequestResponse<ApplicationStat>> GetApplicationStat(Guid applicationId, DateTime dayDate)
        {
            try
            {
                var res = await _context.FindAsync<ApplicationStat>(applicationId,dayDate);
                if (res is null)
                {
                    return new RequestResponse<ApplicationStat>(RequestStatus.Failure, new ApplicationStat(), "ApplicationStat Not Found");
                }
                return new RequestResponse<ApplicationStat>(RequestStatus.Success, res);
            }
            catch (Exception e)
            {
                return new RequestResponse<ApplicationStat>(RequestStatus.Failure, new ApplicationStat(), e.Message);
            }
        }

        public async Task<RequestResponse<IEnumerable<ApplicationStat>>> GetApplicationsStats()
        {
            try
            {
                var appsStats = await _context.ApplicationStats.ToListAsync();
                return new RequestResponse<IEnumerable<ApplicationStat>>(RequestStatus.Success, appsStats);
            }
            catch (Exception e)
            {

                return new RequestResponse<IEnumerable<ApplicationStat>>(RequestStatus.Failure, new List<ApplicationStat>(), e.Message); ;
            }
        }

        public async Task<RequestResponse<IEnumerable<ApplicationStat>>> GetApplicationStatsOfApp(Guid applicationId)
        {
            try
            {
                var appsStats = await _context.ApplicationStats.Where(appstat => appstat.ApplicationId == applicationId).ToListAsync();
                return new RequestResponse<IEnumerable<ApplicationStat>>(RequestStatus.Success, appsStats);
            }
            catch (Exception e)
            {

                return new RequestResponse<IEnumerable<ApplicationStat>>(RequestStatus.Failure, new List<ApplicationStat>(), e.Message);
            }
        }

        public async Task<RequestResponse<IEnumerable<ApplicationStat>>> GetApplicationStatsOfDay(DateTime dayDate)
        {
            try
            {
                var appsStats = await _context.ApplicationStats.Where(appstat => appstat.DayDate == dayDate).ToListAsync();
                return new RequestResponse<IEnumerable<ApplicationStat>>(RequestStatus.Success, appsStats);
            }
            catch (Exception e)
            {

                return new RequestResponse<IEnumerable<ApplicationStat>>(RequestStatus.Failure, new List<ApplicationStat>(), e.Message);
            }
        }

        public async Task<RequestResponse> UpdateTimeStat(ApplicationStat appstat, TimeSpan increaseTime)
        {
            try
            {
                appstat.UsedTime = appstat.UsedTime + increaseTime;
                _context.Update<ApplicationStat>(appstat);
                await _context.SaveChangesAsync();
                return new RequestResponse(RequestStatus.Success);
            }
            catch (Exception e)
            {
                return new RequestResponse(RequestStatus.Failure, e.Message);
            }
        }

        public async Task<RequestResponse> UpdateTimeStat(Guid applicationId, DateTime dayDate, TimeSpan increaseTime)
        {
            try
            {
                var appstat = (await GetApplicationStat(applicationId, dayDate)).ResponseData as ApplicationStat;

                if (appstat != null)
                {
                    //var demo = appstat.ApplicationId.ToString().ToUpper();
                    //// Uppercase Application ID
                    //appstat.ApplicationId = Guid.Parse(appstat.ApplicationId.ToString().ToUpper());


                    appstat.UsedTime = appstat.UsedTime + increaseTime;
                    _context.Update<ApplicationStat>(appstat);
                    await _context.SaveChangesAsync();
                    return new RequestResponse(RequestStatus.Success);
                }

                return new RequestResponse(RequestStatus.Failure, "ApplicationStat Not Found");

            }
            catch (Exception e)
            {
                return new RequestResponse(RequestStatus.Failure, e.Message);
            }
        }
    }
}
