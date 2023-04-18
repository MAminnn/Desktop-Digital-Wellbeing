﻿using Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.POCOs
{
    public record RequestResponse
    {
        public object? ResponseData { get; set; }
        public RequestStatus Status { get; set; }
        public string? ErrorDescription { get; set; }
    }
}
