using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Chronos.Common;
using Chronos.Domain;
using Chronos.Repository.DAO;

namespace Chronos.Repository
{
    class ChronosRepository
    {
        public static List<ChronosDTO> Select()
        {
            DAOFactory factory = DBAdmin.GetDAOFactory();
            IChronosDAO dao = factory.CreateChronosDAO();

            List<ChronosDTO> chronosDTOList = dao.Select();

            return chronosDTOList;
        }
    }
}
