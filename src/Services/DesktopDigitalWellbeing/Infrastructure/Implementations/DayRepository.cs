using Domain.Interfaces.Repositories;
using Domain.POCOs;
using Domain.POCOs.Entities;
using Domain.Enums;
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


        public async Task<RequestResponse> AddDay(DateTime dayDate)
        {
            try
            {
                await _context.AddAsync<Day>(new Day()
                {
                    DateTime = dayDate,
                });
                await _context.SaveChangesAsync();
                return new RequestResponse(RequestStatus.Success);
            }
            catch (Exception e)
            {
                return new RequestResponse(RequestStatus.Failure, e.Message);
            }
        }

        public async Task<RequestResponse> AddDayParallel(DateTime dayDate)
        {
            try
            {
                var parallelContext = DbContextManager.GetParallelContext();
                await parallelContext.AddAsync<Day>(new Day()
                {
                    DateTime = dayDate,
                });
                await parallelContext.SaveChangesAsync();
                return new RequestResponse(RequestStatus.Success);
            }
            catch (Exception e)
            {
                return new RequestResponse(RequestStatus.Failure, e.Message);
            }
        }

        public async Task<RequestResponse<Day>> GetDay(DateTime dayDate, bool includeAppStats)
        {
            try
            {
                var day = await _context.FindAsync<Day>(dayDate);
                if (day is null)
                    return new RequestResponse<Day>(RequestStatus.Failure, new Day(), "Day Not Found");
                if (includeAppStats)
                    await _context.Entry(day!).Collection(d => d.ApplicationsStats).LoadAsync();
                return new RequestResponse<Day>(RequestStatus.Success, day);
            }
            catch (Exception e)
            {
                return new RequestResponse<Day>(RequestStatus.Failure, new Day(), e.Message);
            }
        }

        public async Task<RequestResponse<Day>> GetDayParallel(DateTime dayDate, bool includeAppStats)
        {
            try
            {
                var parallelContext = DbContextManager.GetParallelContext();
                var day = await parallelContext.FindAsync<Day>(dayDate);
                if (day is null)
                    return new RequestResponse<Day>(RequestStatus.Failure, new Day(), "Day Not Found");
                if (includeAppStats)
                    await parallelContext.Entry(day!).Collection(d => d.ApplicationsStats).LoadAsync();
                return new RequestResponse<Day>(RequestStatus.Success, day);
            }
            catch (Exception e)
            {
                return new RequestResponse<Day>(RequestStatus.Failure, new Day(), e.Message);
            }
        }

        public async Task<RequestResponse<IEnumerable<Day>>> GetDays()
        {
            try
            {
                var days = await _context.Days.ToListAsync();
                return new RequestResponse<IEnumerable<Day>>(RequestStatus.Success, days);
            }
            catch (Exception e)
            {

                return new RequestResponse<IEnumerable<Day>>(RequestStatus.Failure, new List<Day>(), e.Message);
            }
        }
    }
}
