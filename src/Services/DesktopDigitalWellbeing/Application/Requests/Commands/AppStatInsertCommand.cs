using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Requests.Commands
{
    public record AppStatInsertCommand(Guid ApplicationId,DateTime DayDate) : ICommand;
}
