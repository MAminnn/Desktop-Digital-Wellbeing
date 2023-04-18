using Domain.Interfaces.Repositories;
using Domain.POCOs;
using Domain.POCOs.Entities;
using Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace Infrastructure.Implementations
{
    public class DayRepository : IDayRepository
    {
        private readonly DWDbContext _context;
        public DayRepository()
        {
            _context = DbContextManager.GetContext();
        }


        public async Task<RequestResponse> AddDay(Day day)
        {
            try
            {
                await _context.AddAsync<Day>(day);
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

        public async Task<RequestResponse> GetDay(DateTime dayDate)
        {
            try
            {
                var day = await _context.FindAsync<Day>(dayDate);
                return new RequestResponse()
                {
                    ResponseData = day,
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

        public async Task<RequestResponse> GetDays()
        {
            try
            {
                var days = await _context.Days.ToListAsync();
                return new RequestResponse()
                {
                    ResponseData = days,
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
    }
}
