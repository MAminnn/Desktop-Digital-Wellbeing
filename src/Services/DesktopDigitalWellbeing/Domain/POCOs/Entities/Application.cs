using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.POCOs.Entities
{
    public class Application
    {
        public Guid ID { get => _id; set => _id = value; }
        public string Path { get => _path; set => _path = value; }

        private Guid _id;
        private string _path;

        public Application() { }

    }
}
