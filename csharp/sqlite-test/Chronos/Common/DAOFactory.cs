using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

using Chronos.Repository.DAO;

namespace Chronos.Common
{
    public abstract class DAOFactory
    {
        public static DAOFactory CreateFactory (Database db, string connectionString)
        { 
            switch (db)
            {
                case Database.SQLite:
                    return new SQLiteDAOFactory(connectionString);
                default:
                    throw new NotImplementedException("not database");
            }
        }

        public abstract IDbConnection GetConnection();

        public abstract IChronosDAO CreateChronosDAO();
    }
}
