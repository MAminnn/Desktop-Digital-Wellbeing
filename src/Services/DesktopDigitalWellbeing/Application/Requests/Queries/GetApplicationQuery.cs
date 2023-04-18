using Application.Requests.Commands;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Requests.Queries
{
    public record GetApplicationQuery(Guid applicationId);
}
