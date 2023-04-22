using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WorkerService.POCOs
{
    public record Application(Guid applicationId,string path);
}
