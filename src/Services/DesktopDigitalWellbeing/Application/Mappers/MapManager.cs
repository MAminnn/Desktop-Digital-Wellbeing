using Application.Mappers.Profiles;
using AutoMapper;
using AutoMapper.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Mappers
{
    public class MapManager
    {
        private static MapManager _instance;
        private IMapper _mapper;
        private MapManager()
        {
            MapperConfigurationExpression _expression = new MapperConfigurationExpression();
            _expression.AddProfile<ApplicationMapProfile>();
            _expression.AddProfile<ApplicationStatMapProfile>();
            _expression.AddProfile<DayMapProfile>();
            MapperConfiguration _configuration = new MapperConfiguration(_expression);
            _mapper = new Mapper(_configuration);
        }

        public static MapManager GetInstance()
        {
            if (_instance is not null)
            {
                return _instance;
            }
            _instance = new MapManager();
            return _instance;
        }

        public IMapper GetMapper() => _mapper;
    }
}
