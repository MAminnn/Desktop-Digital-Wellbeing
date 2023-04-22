using Application.DTOs;
using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Mappers.Profiles
{
    public class ApplicationStatMapProfile : Profile
    {
        public ApplicationStatMapProfile()
        {
            CreateMap<Domain.POCOs.Entities.ApplicationStat, ApplicationStatDTO>()
        .ForMember(adto =>
            adto.ApplicationId,
            a => a.MapFrom(p => p.ApplicationId))
        .ForMember(adto =>
            adto.Application,
            a => a.MapFrom(p => p.Application))
        .ForMember(adto =>
            adto.DayDate,
            a => a.MapFrom(p => p.DayDate))
        .ForMember(adto =>
            adto.Day,
            a => a.MapFrom(p => p.Day))
        .ForMember(adto =>
            adto.UsedTime,
            a => a.MapFrom(p => p.UsedTime))
        ;
        }
    }
}
