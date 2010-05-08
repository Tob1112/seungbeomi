using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Chronos.Domain;

namespace Chronos.Repository.DAO
{
    public interface IChronosDAO
    {
        List<ChronosDTO> Select();
    }
}
