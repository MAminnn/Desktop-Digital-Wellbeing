using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Requests.Commands
{
    public record DayInsertParallelCommand(DateTime DayDate) : ICommand;
}
