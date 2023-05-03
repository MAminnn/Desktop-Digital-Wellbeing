using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Persistence
{
    internal static class DbContextManager
    {
        private readonly static DWDbContext _context = new DWDbContext();
        public static DWDbContext GetContext() => _context;
        public static DWDbContext GetParallelContext() => new DWDbContext();
    }
}
