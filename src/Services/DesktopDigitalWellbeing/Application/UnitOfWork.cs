using Infrastructure.Implementations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application
{
    public class UnitOfWork
    {

        private static UnitOfWork _instance;

        private readonly ApplicationRepository _applicationRepository;
        private readonly ApplicationStatRepository _applicationStatRepository;
        private readonly DayRepository _dayRepository;

        private UnitOfWork()
        {
            _applicationRepository = new ApplicationRepository();
            _applicationStatRepository = new ApplicationStatRepository();
            _dayRepository = new DayRepository();

        }

        public static UnitOfWork GetInstance()
        {
            if (_instance == null)
            {
                _instance = new UnitOfWork();
            }
            return _instance;
        }

        public ApplicationRepository ApplicationRepository { get => _applicationRepository; }
        public ApplicationStatRepository ApplicationStatRepository { get => _applicationStatRepository; }
        public DayRepository DayRepository { get => _dayRepository; }
    }
}
