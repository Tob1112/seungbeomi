using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SQLite;
using System.Text;

using Chronos.Repository.DAO;

namespace Chronos.Common
{
    public sealed class SQLiteDAOFactory : DAOFactory
    {
        private IDbConnection connection;

        public SQLiteDAOFactory(string connectionString)
        {
            connection = new SQLiteConnection(connectionString);
        }

        public override IDbConnection GetConnection()
        {
            return this.connection;
        }

        public override IChronosDAO CreateChronosDAO()
        {
            return new SQLiteChronosDAO(connection);
        }
    }
}
