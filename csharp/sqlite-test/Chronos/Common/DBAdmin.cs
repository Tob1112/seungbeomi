using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace Chronos.Common
{
    public class DBAdmin
    {
        private static DAOFactory daoFactory = null;

        public static DAOFactory GetDAOFactory()
        { 
            if (daoFactory == null)
            {
                try
                {
                    string dbFileName = DBAdmin.DatabaseFileName;
                    string connectionString = string.Format("Data Source={0}; Version=3; FailIfMissing=True", dbFileName);
                    daoFactory = DAOFactory.CreateFactory(Database.SQLite, connectionString);
                    IDbConnection connection = daoFactory.GetConnection();
                    connection.Open();
                }
                catch (Exception e)
                {
                    daoFactory = null;
                    throw e;
                }                
            }
            return daoFactory;
        }

        public static void ColseAllConnection()
        {
            if (daoFactory != null)
            {
                IDbConnection connection = daoFactory.GetConnection();
                connection.Close();
                daoFactory = null;
            }
        }

        private static string DatabaseFileName
        {
            get
            {
                /*
                string folderName = "";
                string systemFolderName = "SYSTEM";
                string dbFileName = "datafile.sqlite3";
                */
                return "C:\\Projects\\Chronos\\Chronos\\DATABASE\\datafile.sqlite3";
            }
        }
    }
}
