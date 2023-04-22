using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.DTOs
{
    public class ApplicationDTO
    {
        public Guid? Id { get; set; }
        public string? Path { get; set; }

    }
}
