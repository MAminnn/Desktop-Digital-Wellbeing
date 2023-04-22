using Application.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application
{
    public record RequestResponse(RequestStatus Status, string ErrorDescription = "");
    public record RequestResponse<TResponseDataType>(RequestStatus Status, TResponseDataType ResponseData, string ErrorDescription = "");
}
