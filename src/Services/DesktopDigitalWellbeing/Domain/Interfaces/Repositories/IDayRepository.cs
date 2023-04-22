﻿using Domain.POCOs;
using Domain.POCOs.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Interfaces.Repositories
{
    public interface IDayRepository
    {
        Task<RequestResponse> AddDay(DateTime dayDate);
        Task<RequestResponse<IEnumerable<Day>>> GetDays();
        Task<RequestResponse<Day>> GetDay(DateTime dayDate, bool includeAppStats);
    }
}
