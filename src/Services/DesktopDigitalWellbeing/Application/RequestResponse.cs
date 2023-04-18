using Application.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application
{
    public record RequestResponse
    {
        public object? ResponseData { get; set; }
        public RequestStatus Status { get; set; }
        public string? ErrorDescription { get; set; }
    }
}
