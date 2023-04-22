using Application.DTOs;
using Application.Handlers;
using Application.Handlers.Commands;
using Application.Handlers.Queries;
using Application.Requests;
using Application.Requests.Commands;
using Application.Requests.Queries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;

namespace Application
{
    public class Mediator
    {
        private static Mediator _instance;

        private Dictionary<Type, Object> _commandHandlers;
        private Dictionary<Type, Object> _queryHandlers;
        private Mediator()
        {
            _commandHandlers = new Dictionary<Type, Object>();

            #region Commands Instances Configuration
            _commandHandlers.Add(typeof(ApplicationInsertCommand), new ApplicationInsertHandler());
            _commandHandlers.Add(typeof(AppStatInsertCommand), new AppStatInsertHandler());
            _commandHandlers.Add(typeof(AppStatUpdateTimeCommand), new AppStatUpdateTimeHandler());
            _commandHandlers.Add(typeof(DayInsertCommand), new DayInsertHandler());
            #endregion

            _queryHandlers = new Dictionary<Type, Object>();

            #region Queries Instances Configuration 
            _queryHandlers.Add(typeof(GetApplicationByPathQuery), new GetApplicationByPathHandler());
            _queryHandlers.Add(typeof(GetApplicationQuery), new GetApplicationHandler());
            _queryHandlers.Add(typeof(GetApplicationsQuery), new GetApplicationsHandler());
            _queryHandlers.Add(typeof(GetApplicationsStatsQuery), new GetApplicationsStatsHandler());
            _queryHandlers.Add(typeof(GetApplicationStatQuery), new GetApplicationStatHandler());
            _queryHandlers.Add(typeof(GetApplicationStatsOfAppQuery), new GetApplicationStatsOfAppHandler());
            _queryHandlers.Add(typeof(GetApplicationStatsOfDayQuery), new GetApplicationStatsOfDayHandler());
            _queryHandlers.Add(typeof(GetDayQuery), new GetDayHandler());
            _queryHandlers.Add(typeof(GetDaysQuery), new GetDaysHandler());
            #endregion


        }

        public static Mediator GetInstance()
        {
            if (_instance == null)
            {
                _instance = new Mediator();
            }
            return _instance;
        }

        public async Task<RequestResponse> HandleCommand<TCommand>(TCommand command)
        {
            var handler = _commandHandlers[command!.GetType()];
            return await (handler as IRequestHandler<TCommand>)!.Handle(command);
        }

        public async Task<RequestResponse<TResponseData>> HandleQuery<TQuery, TResponseData>(TQuery query)
        {
            var handler = _queryHandlers[query!.GetType()];
            return await (handler as IRequestHandler<TQuery, TResponseData>)!.Handle(query);
        }

        //var result = handler.GetType().GetMethod("Handle")!.Invoke(handler, new[] { query });
    }
}
