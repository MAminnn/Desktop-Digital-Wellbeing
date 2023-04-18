using Domain.Interfaces.Repositories;
using Domain.POCOs;
using Domain.POCOs.Entities;
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


        public async Task<RequestResponse> AddApplication(Application application)
        {
            try
            {
                await _context.AddAsync<Application>(application);
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

        public async Task<RequestResponse> GetApplication(Guid applicationId)
        {
            try
            {
                var app = await _context.FindAsync<Application>(applicationId);
                return new RequestResponse()
                {
                    Status = Domain.Enums.RequestStatus.Success,
                    ResponseData = app
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

        public async Task<RequestResponse> GetApplications()
        {
            try
            {
                var apps = await _context.Applications.ToListAsync();
                return new RequestResponse()
                {
                    Status = Domain.Enums.RequestStatus.Success,
                    ResponseData = apps
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
