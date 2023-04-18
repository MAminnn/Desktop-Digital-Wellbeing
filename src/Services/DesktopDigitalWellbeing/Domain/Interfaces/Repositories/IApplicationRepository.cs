using Domain.POCOs;
using Domain.POCOs.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Interfaces.Repositories
{
    public interface IApplicationRepository
    {
        Task<RequestResponse> AddApplication(Application application);
        Task<RequestResponse> GetApplication(Guid applicationId);
        Task<RequestResponse> GetApplications();
    }
}
