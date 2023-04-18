﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Handlers
{
    public interface IRequestHandler<TRequest>
    {
        Task<RequestResponse> Handle(TRequest request);
    }
}
