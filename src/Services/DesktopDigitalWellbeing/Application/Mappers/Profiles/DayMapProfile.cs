using Application.DTOs;
using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Mappers.Profiles
{
    public class DayMapProfile : Profile
    {
        public DayMapProfile()
        {
            CreateMap<Domain.POCOs.Entities.Day, DayDTO>()
        .ForMember(ddto =>
            ddto.ApplicationsStats,
            d => d.MapFrom(p => p.ApplicationsStats))
        .ForMember(ddto =>
            ddto.DateTime,
            d => d.MapFrom(p => p.DateTime));
        }
    }
}
