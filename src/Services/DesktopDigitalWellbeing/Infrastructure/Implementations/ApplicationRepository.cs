using Domain.Interfaces.Repositories;
using Domain.POCOs;
using Domain.POCOs.Entities;
using Domain.Enums;
using Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Implementations
{
    public class ApplicationRepository : IApplicationRepository
    {
        private readonly DWDbContext _context;
        public ApplicationRepository()
        {
            _context = DbContextManager.GetContext();
        }


        public async Task<RequestResponse> AddApplication(string applicationPath)
        {
            try
            {
                var application = new Application()
                {
                    Path = applicationPath
                };
                await _context.AddAsync<Application>(application);
                await _context.SaveChangesAsync();
                return new RequestResponse(RequestStatus.Success);
            }
            catch (Exception e)
            {
                return new RequestResponse(RequestStatus.Failure, e.Message);
            }
        }

        public async Task<RequestResponse<Application>> GetApplication(Guid applicationId)
        {
            try
            {
                var app = await _context.FindAsync<Application>(applicationId);
                if (app is null)
                {
                    return new RequestResponse<Application>(RequestStatus.Failure, new Application(), "Application Not Found");
                }
                return new RequestResponse<Application>(RequestStatus.Success, app);
            }
            catch (Exception e)
            {
                return new RequestResponse<Application>(RequestStatus.Failure, new Application(), e.Message);
            }
        }

        public async Task<RequestResponse<Application>> GetApplication(string applicationPath)
        {
            try
            {
                var app = await _context.Applications.SingleOrDefaultAsync(a => a.Path == applicationPath);
                if (app is null)
                {
                    return new RequestResponse<Application>(RequestStatus.Failure, new Application(), "Application Not Found");
                }
                return new RequestResponse<Application>(RequestStatus.Success, app);
            }
            catch (Exception e)
            {
                return new RequestResponse<Application>(RequestStatus.Failure, new Application(), e.Message);
            }
        }

        public async Task<RequestResponse<IEnumerable<Application>>> GetApplications()
        {
            try
            {
                var apps = await _context.Applications.ToListAsync();
                return new RequestResponse<IEnumerable<Application>>(RequestStatus.Success, apps, "");
            }
            catch (Exception e)
            {
                return new RequestResponse<IEnumerable<Application>>(RequestStatus.Failure, new List<Application>(), e.Message);
            }

        }
    }
}
