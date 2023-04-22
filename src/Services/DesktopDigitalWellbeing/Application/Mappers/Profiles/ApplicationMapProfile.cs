using Application.DTOs;
using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Mappers.Profiles
{
    public class ApplicationMapProfile : Profile
    {
        public ApplicationMapProfile()
        {
            CreateMap<Domain.POCOs.Entities.Application, ApplicationDTO>()
        .ForMember(adto =>
            adto.Id,
            a => a.MapFrom(p => p.ID))
        .ForMember(adto =>
            adto.Path,
            a => a.MapFrom(p => p.Path));
        }
    }
}
